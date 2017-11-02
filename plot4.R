##  Download the file in the /data directory and and unzips it 
##  and reads it into the dataframe power

#if(!file.exists("./data")){dir.create("./data")}
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#setwd("./data")
#temp <- tempfile()
#download.file(url, temp)
#unzip(temp)
#setwd("./..")
power <- read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

# Select only the dates 2007-02-01 and 2007-02-02
data <- filter(power, Date=="1/2/2007" | Date=="2/2/2007")

# Add additional variable containing date and time
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"))

# To get weekdays in English
Sys.setlocale(category = "LC_TIME", locale="en_GB.UTF-8")

# Make the png file
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(5,4,4,1))
with(data, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power",xlab=""))
with(data, plot(DateTime, Voltage, type="l", ylab="Voltage",xlab="", sub="datetime"))
with(data, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering",xlab=""))
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), lty=c(1,1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")
with(data, plot(DateTime, Global_reactive_power, type="l", xlab="", sub="datetime"))
dev.off()