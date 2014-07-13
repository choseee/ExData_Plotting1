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


# plot2.png -- plot of Global Active Power over the two days
#
# I really haven't found easier way how to change ticks' label for c("Thu", "Fri", "Sat").
# So, I virtually moved my laptop to London (UTC Time Zone)
#
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME","C")
png("plot2.png", width = 480, height = 480)
with(hpc_small,
     plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Global_active_power, 
          type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
Sys.setlocale("LC_TIME",lct)


#cleanup
unlink(file_desc)
rm(file_desc, hpc_small, lct)
q("no")

