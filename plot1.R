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


# plot1.png -- histogram of Global Active Power 
png("plot1.png", width = 480, height = 480)
hist(hpc_small$Global_active_power, xlab="Global Active Power (kilowatts)", 
     col="red", main="Global Active Power")
dev.off()


#cleanup
unlink(file_desc)
rm(file_desc, hpc_small)
q("no")

