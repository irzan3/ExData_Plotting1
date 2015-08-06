
## Create data folder if it doesn't exist
if(!file.exists("./data")){dir.create("./data")}

## Download the zip file into the data folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/household_power_consumption.zip")

## Unzip the downloaded zip file
unzip(zipfile="./data/household_power_consumption.zip",exdir="./data")

## Read the downloaded text file
Data  <- read.csv("./data/household_power_consumption.txt", header=T, sep=";", na.strings="?", 
                  nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Get only data from 2007-02-01 until 2007-02-02 (2 days)
subData <- Data[Data$Date %in% c("1/2/2007","2/2/2007"), ]

## Convert the dates
subData$Date <- as.Date(subData$Date, format="%d/%m/%Y")
## datetime <- paste(as.Date(subData$Date), subData$Time)
datetime <- paste(subData$Date, subData$Time)
subData$Datetime <- as.POSIXct(datetime)

## Plot graph for Global_active_power vs Datetime
with(subData, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving the histograms to PNG file device
dev.copy(png, file="plot3.png", height=480, width=480)

## Close the PNG file device
dev.off()
