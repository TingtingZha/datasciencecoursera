hpc<-read.table("household_power_consumption.txt",sep=';', na.strings = "?",header = TRUE)

hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

clean_hpc <- subset(hpc,Date >= as.Date("2007/2/1") & Date <= as.Date("2007/2/2"))

datetime <- paste(clean_hpc$Date, clean_hpc$Time)

clean_hpc <- clean_hpc[ ,!(names(clean_hpc) %in% c("Date","Time"))]

clean_hpc <- cbind(datetime, clean_hpc)

clean_hpc$datetime <- as.POSIXct(datetime)

plot(clean_hpc$Global_active_power~clean_hpc$datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png", width=480, height=480)

dev.off()
