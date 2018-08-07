Introduction
------------

The data for this assignment can be downloaded from the course web site:

-   Dataset: [Activity monitoring
    data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip)

The variables included in this dataset are:

-   **steps**: Number of steps taking in a 5-minute interval (missing
    values are coded as red)  
-   **date**: The date on which the measurement was taken in YYYY-MM-DD
    format  
-   **interval**: Identifier for the 5-minute interval in which
    measurement was taken

The dataset is stored in a comma-separated-value (CSV) file and there
are a total of 17,568 observations in this dataset.

### Download and loading the data

    path <- getwd()  
    url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip" 
    download.file(url, file.path(path, "dataset.zip"))  
    unzip(zipfile = "dataset.zip")
    activity<-read.csv("activity.csv") 

### What is mean total number of steps taken per day?

1.  Calculate the total number of steps taken per day and make
    a histogram.

<!-- -->

    stepsperday <- aggregate(steps ~ date, data = activity, FUN = sum)
    head(stepsperday)

    ##         date steps
    ## 1 2012-10-02   126
    ## 2 2012-10-03 11352
    ## 3 2012-10-04 12116
    ## 4 2012-10-05 13294
    ## 5 2012-10-06 15420
    ## 6 2012-10-07 11015

    with(stepsperday,hist(steps,xlab = "Steps", breaks = 15,col="lightblue",main = "Histogram of the total number of steps per day"))

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-2-1.png)

1.  Calculate and report the mean and median of the total number of
    steps taken per day

<!-- -->

    meansteps<-mean(stepsperday$steps)
    mediansteps<-median(stepsperday$steps)

-   The mean of the total number of steps taken per day is 10766.19.  
-   The median of the total number of steps taken per day is 10765.

### What is the average daily activity pattern?

1.  Make a time series plot (i.e. type="l") of the 5-minute
    interval (x-axis) and the average number of steps taken, averaged
    across all days (y-axis).

<!-- -->

    steps_5mins <- aggregate(steps ~ interval, data = activity, FUN = mean, na.rm = TRUE)
    with(steps_5mins,plot(interval,steps,type = "l",col="blue",lwd=2,
          xlab ="5-minutes Intervals", ylab="Average steps per day", 
          main="Average number of steps taken during each 5-minute interval"))

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-4-1.png)

1.  Which 5-minute interval, on average across all the days in the
    dataset, contains the maximum number of steps?

<!-- -->

    steps_5mins[which.max(steps_5mins$steps),]

    ##     interval    steps
    ## 104      835 206.1698

-   The 5-minute interval that, on average across all the days in the
    data set, contains the maximum number of steps is interval number
    835 (contains 206.1698 steps).

### Imputing missing values

-   Note that there are a number of days/intervals where there are
    missing values (coded as NA). The presence of missing days may
    introduce bias into some calculations or summaries of the data.

1.  Calculate and report the total number of missing values in the
    dataset (i.e. the total number of rows with NAs)

<!-- -->

    missingvalues<-sum(is.na(activity$steps))
    missingvalues

    ## [1] 2304

-   The total number of rows with NAs is 2304.

1.  Create a new dataset that is equal to the original dataset but with
    the missing data filled in. The strategy is to fill up all the
    missing values with the mean for that 5-minute interval.

<!-- -->

    activitynoNA<-activity
    narows <- which(is.na(activity$steps))
    for(i in narows){
      activitynoNA$steps[i] <- steps_5mins$steps[steps_5mins$interval==activitynoNA$interval[i]]
    }
    # Check the missing Values in the new dataset.
    sum(is.na(activitynoNA$steps))

    ## [1] 0

1.  Make a histogram of the total number of steps taken each day and
    Calculate and report the mean and median total number of steps taken
    per day. Do these values differ from the estimates from the first
    part of the assignment? What is the impact of imputing missing data
    on the estimates of the total daily number of steps?

<!-- -->

    stepsnoNA <- aggregate(steps ~ date, data = activitynoNA, FUN = sum)
    with(stepsnoNA,hist(steps,xlab = "Steps", breaks = 15,col="lightblue",main = "Histogram of the total number of steps per day with imputing missing data"))

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-8-1.png)

    meanstepsnew<-mean(stepsnoNA$steps)
    medianstepsnew<-median(stepsnoNA$steps)

    ##      Type of Estimate Mean_Steps Median_Steps
    ## [1,] "Original"       "10766"    "10765"     
    ## [2,] "without_NA"     "10766"    "10766"

-   The mean of the total number of steps taken per day is 10766.19,
    which is identical to the mean total number of steps taken per day
    in the original data set.  
-   The median of the total number of steps taken per day is 10766.19,
    up from the median steps in the original data set.  
-   Imputing missing data with the mean for that 5-minute interval had
    little impact on the mean and median total number of steps taken per
    day, despite a fairly high percentage of missing values.

### Are there differences in activity patterns between weekdays and weekends?

-   For this part use the dataset with the filled-in missing values for
    this part.

1.  Create a new factor variable in the dataset with two levels –
    “weekday” and “weekend” indicating whether a given date is a weekday
    or weekend day.

<!-- -->

    activitynoNA$date<-as.POSIXct(activitynoNA$date)
    activitynoNA$weekdays<-weekdays(activitynoNA$date)
    activitynoNA$weekdays <- gsub('Saturday|Sunday', 'Weekend', activitynoNA$weekdays)
    activitynoNA$weekdays <- gsub('Monday|Tuesday|Wednesday|Thursday|Friday', 'Weekday', activitynoNA$weekdays)

1.  Make a panel plot containing a time series plot (i.e. type="l") of
    the 5-minute interval (x-axis) and the average number of steps
    taken, averaged across all weekday days or weekend days (y-axis).
    See the README file in the GitHub repository to see an example of
    what this plot should look like using simulated data.

<!-- -->

    steps_weekdays <- aggregate(steps ~ interval+weekdays, data = activitynoNA, FUN = mean, na.rm = TRUE)
    library(lattice)

    ## Warning: package 'lattice' was built under R version 3.3.3

    xyplot(steps ~ interval | weekdays, data = steps_weekdays,type="l",
           xlab = "5-minute Interval ",
           ylab = "Steps",
           main = "Average number of steps taken across weekday and weekend days",
           layout=c(1,2))

![](PA1_template_files/figure-markdown_strict/unnamed-chunk-11-1.png)
