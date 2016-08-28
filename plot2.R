library(zoo)
library(dplyr)
library(devtools)
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

#b<-select(sample,Date,Global_active_power)
t_subset<-select(sample,Time_stamp,Global_active_power)

#b<-filter(b,!is.na(Global_active_power) )
#b$Date<-as.Date(b$Date,"%d/%m/%Y")
#b$Time_stamp<-as.Date(b$Time_stamp)
t_subset$Global_active_power<-as.numeric(t_subset$Global_active_power)
#b$weekofday <-weekdays(b$Date)

#c<-select(b,Global_active_power,weekofday)
#match date and value
ts0<-zoo(t_subset$Global_active_power,t_subset$Time_stamp)
png("plot2.png")
plot(ts0,xlab="",ylab="Global Active Power(kilowatts)")
#table(b$Date)
dev.off()

