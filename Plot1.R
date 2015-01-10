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

Sys.setlocale("LC_TIME", "English")



# Create the plot 1
windows()
with(data, hist(Global_active_power, col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power"))
dev.copy(png,file = "plot1.png", width=480, height = 480)
dev.off()
