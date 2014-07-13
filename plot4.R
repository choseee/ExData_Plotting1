# file downloaded, unzipped
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              "household_power_consumption.zip")
unzip("household_power_consumption.zip")
unlink("household_power_consumption.zip")
file_desc = "household_power_consumption.txt"


# table scanned for classes, loaded
hpc <- read.table(file_desc, header=T, sep=";", na.strings = "?", nrows=100)
cl <- sapply(hpc, class)
hpc <- read.table(file_desc, header=T, sep=";", na.strings = "?", nrows=2075259)
hpc_small <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")
rm(cl, hpc)


# plot4.png -- matrix 2x2 of four graphs
#
png("plot4.png", width = 480, height = 480)
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME","C")
par(mfrow=c(2,2), mar = c(5, 5, 2, 1), oma = c(0, 0, 2, 0))
with(hpc_small, {
  plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Global_active_power, 
       type="l", ylab="Global Active Power", xlab="")
  plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Voltage, 
       type="l", ylab="Voltage", xlab="datetime")
  {
    plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Sub_metering_1,
         type="n", ylab="Energy sub metering", xlab="");
    points(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Sub_metering_1, 
           col = "black", type="l");
    points(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Sub_metering_2, 
           col = "red", type="l");
    points(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Sub_metering_3, 
           col = "blue", type="l");
    legend("topright", pch = 151, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  }
  plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Global_reactive_power, 
       type="l", ylab="Global_active_power", xlab="datetime")
})
dev.off()
Sys.setlocale("LC_TIME",lct)


#cleanup
unlink(file_desc)
rm(file_desc, hpc_small, lct)
q("no")

