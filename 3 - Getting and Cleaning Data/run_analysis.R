library(dplyr)

path <- getwd()

# Download and unzip the Data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataset.zip"))
unzip(zipfile = "dataset.zip")

# Read in the list of all features and the class labels with activity name.
activitylabels<-read.table("UCI HAR Dataset/activity_labels.txt",col.names =c("classlabels", "activityname") )

features <-read.table("UCI HAR Dataset/features.txt",col.names = c("index", "featurenames"))

# Step 1: Extracts only the measurements on the mean and standard deviation 
features_m_s <- grep("(mean|std)\\(\\)", features[, "featurenames"])
measurements <- features[features_m_s, "featurenames"]
measurements <- gsub('[()]', '', measurements)

# Step 2
# Load train datasets
train<-read.table("UCI HAR Dataset/train/X_train.txt")[, features_m_s]
names(train)<-measurements

trainlabels <- read.table("UCI HAR Dataset/train/Y_train.txt",col.names = c("Activity"))
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject"))

# Load test datasets
test <- read.table( "UCI HAR Dataset/test/X_test.txt")[, features_m_s]
names(test)<-measurements

testlabels <- read.table( "UCI HAR Dataset/test/Y_test.txt", col.names = c("Activity"))
testsubjects <- read.table( "UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject"))

# merge the datasets
tidyData<-rbind(cbind(trainsubjects, trainlabels, train),cbind(testsubjects, testlabels, test))

rm(trainsubjects, trainlabels, train,testsubjects, testlabels, test)
# Step 3: Uses descriptive activity names to name the activities in the data set
# Step 4: Appropriately labels the data set with descriptive variable names.
tidyData$Subject <- as.factor(tidyData$Subject)
tidyData$Activity <- factor(tidyData$Activity, 
                                 levels = activitylabels[["classlabels"]],
                                 labels = activitylabels[["activityname"]])

# Step 5: creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
tidyDatamean <- tidyData %>% 
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean))

write.table(tidyDatamean, file = "tidy_Data.txt", row.names = FALSE,quote = FALSE)
