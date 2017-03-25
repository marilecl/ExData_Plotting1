# Exploratory Data Analysis
# Peer-graded Assignment: Course Project 1
# plot3

library(lubridate)

zipfilename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download and unzip the dataset
if (!file.exists(zipfilename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, zipfilename, mode = "wb")
}  
filename <- "household_power_consumption.txt"
if (!file.exists(filename)) { 
  unzip(zipfilename) 
}

# get dataset for 2-day period for 1/2/2017 & 2/2/2017 
headerNames <- c("Date","Time","Global_active_power","Global_reactive_power",
                 "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                 "Sub_metering_3")
df <- read.table(filename,skip = grep("31/1/2007;23:59:00", readLines(filename)),
                 nrows=2880,sep=";",col.names=headerNames)

df$DateTime <- dmy_hms(paste(df$Date, df$Time))

# construct a plot and save it in png file
png(filename="plot3.png",width=480, height=480)
plot(df$DateTime, df$Sub_metering_1,type ="l", col = "black", xlab = "", 
     ylab = "Energy sub metering")
lines(df$DateTime,df$Sub_metering_2, col="red")
lines(df$DateTime,df$Sub_metering_3, col="blue")
legend("topright",legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black", "red", "blue"),lwd=c(1,1,1))
dev.off()
