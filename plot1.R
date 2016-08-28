setwd("F:\\R_Work")

#import relevant libraries
library(dplyr)
library(devtools)

#read in raw data and assign colnames
houseHoldConsumption <- 
  read.csv("I:\\Coursera\\Exploratory data analysis\\exdata-data-household_power_consumption\\household_power_consumption.txt",sep = ";", skip=1,header = F)

houseHoldConsumption <- 
  read.csv("F:\\R_Work\\exdata-data-household_power_consumption\\household_power_consumption.txt",sep = ";", skip=1,header = F)

colNamesH <- 
  c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

colnames(houseHoldConsumption) <- colNamesH

head(houseHoldConsumption)

#combine Date and Time, change column type with strptime
houseHoldConsumption$Time_stamp <- as.POSIXct(strptime(paste(houseHoldConsumption$Date,houseHoldConsumption$Time),"%d/%m/%Y %H:%M:%S"))  

#select data from 2007-02-01 to 2007-02-02

sample <- filter(houseHoldConsumption,Time_stamp >= '2007-02-01 00:00:00' & Time_stamp <= '2007-02-02 23:59:59')

png("plot1.png")

hist(as.numeric(sample$Global_active_power)/500,col="red",main ="Global Active Power",xlab="Global Active Power(kilowatts)")

dev.off()

