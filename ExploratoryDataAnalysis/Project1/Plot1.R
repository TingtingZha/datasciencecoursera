hpc<-read.table("household_power_consumption.txt",sep=';', na.strings = "?",header = TRUE)

hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

clean_hpc <- subset(hpc,Date >= as.Date("2007/2/1") & Date <= as.Date("2007/2/2"))

hist(clean_hpc$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png,"plot1.png", width=480, height=480)

dev.off()
