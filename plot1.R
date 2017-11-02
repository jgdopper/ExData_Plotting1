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

# Make the png file
png(filename="plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()