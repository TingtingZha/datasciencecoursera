hpc<-read.table("household_power_consumption.txt",sep=';', na.strings = "?",header = TRUE)
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
clean_hpc <- subset(hpc,Date >= as.Date("2007/2/1") & Date <= as.Date("2007/2/2"))

datetime <- paste(clean_hpc$Date, clean_hpc$Time)
clean_hpc <- clean_hpc[ ,!(names(clean_hpc) %in% c("Date","Time"))]
clean_hpc <- cbind(datetime, clean_hpc)
clean_hpc$datetime <- as.POSIXct(datetime)

par(mfrow=c(2,2), mar=c(4,4,2,1))

with(clean_hpc, {
  plot(Global_active_power~datetime, type="l", ylab="Global Active Power ", xlab="")
  
  plot(Voltage~datetime, type="l", ylab="Voltage", xlab="datatime")
  
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"),  bty="n",lty=1, lwd=2, cex=0.8,y.intersp=0.5)

  plot(Global_reactive_power~datetime, type="l", xlab="datetime")
  })

dev.copy(png,"plot4.png",width=480, height=480)
dev.off()

