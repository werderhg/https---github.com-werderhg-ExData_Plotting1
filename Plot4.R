# Download data to working dir
rm(list=ls())
setwd("H:/Eigene Dateien/A-Coursera/Stat Kurs/4- Exploratory Data Analysis/Project 1")
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

library(downloader)
download(url, "dataset.zip", mode="wb")
unzip("dataset.zip")
unlink(url)

raw_data<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")


### Selecting the data needed for two dates
library(dplyr)
raw_data<- tbl_df(raw_data) #make a dplyr object
data<-filter(raw_data, Date == "2/2/2007" | Date == "1/2/2007")
rm(raw_data) #free memory

# Cleaning data
### set date to date formate
data$Fulldate<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

Sys.setlocale("LC_TIME", "English")  #adjust language


#### Create Plot 4
    windows()
    par(mfrow = c(2,2))
#plot 1
    with(data, plot(Fulldate,Global_active_power,ylab="Global Active Power", xlab="", type="n"))
    with(data, lines(Fulldate,Global_active_power))
#plot 2
    with(data, plot(Fulldate,Voltage,xlab="datetime",type="n"))
    with(data, lines(Fulldate,Voltage))
#plot 3
    with( data, plot(Fulldate,Sub_metering_1, ylab = "Energy sub metering", type="n",xlab=""))
    with(data, lines(Fulldate,Sub_metering_1))
    with(data, lines(Fulldate, Sub_metering_2, col="red"))
    with(data, lines(Fulldate,Sub_metering_3,col="blue"))
    legend("topright", lty= c(1,1,1), col = c("black","red","blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex = 0.95,bty="n")
#plot 4
    with(data, plot(Fulldate,Global_reactive_power,type="n", xlab = "datetime"))
    with(data,lines(Fulldate,Global_reactive_power))

    dev.copy(png,file = "plot4.png", width=480, height = 480)
    dev.off()