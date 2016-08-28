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

t_subset<-select(sample,Time_stamp,Global_active_power)
t_subset$Global_active_power<-as.numeric(t_subset$Global_active_power)

t2_subset<-select(sample,Time_stamp,Sub_metering_1,Sub_metering_2,Sub_metering_3)
t2_subset$Sub_metering_1<-(as.numeric(t2_subset$Sub_metering_1))
t2_subset$Sub_metering_2<-(as.numeric(t2_subset$Sub_metering_2))
t2_subset$Sub_metering_3<-(as.numeric(t2_subset$Sub_metering_3))


t3_subset<-select(sample,Time_stamp,Voltage)
t3_subset$Voltage<-as.numeric(t3_subset$Voltage)
t4_subset<-select(sample,Time_stamp,Global_reactive_power)
t4_subset$Global_reactive_power<-as.numeric(t4_subset$Global_reactive_power)

ts0<-zoo(t_subset$Global_active_power,t_subset$Time_stamp)

ts<-zoo(t2_subset$Sub_metering_1,t2_subset$Time_stamp)
ts1<-zoo(t2_subset$Sub_metering_2,t2_subset$Time_stamp)
ts2<-zoo(t2_subset$Sub_metering_3,t2_subset$Time_stamp)

z <- cbind( zoo(t2_subset$Sub_metering_1,t2_subset$Time_stamp),t2_subset$Sub_metering_2, t2_subset$Sub_metering_3)


ts3<-zoo(t3_subset$Voltage,t3_subset$Time_stamp)
ts4<-zoo(t4_subset$Global_reactive_power,t4_subset$Time_stamp)
#plot(ts3,xlab="datetime",ylab="Voltage")
#plot(ts4,xlab="datetime",ylab="Global_reactive_power")

png("plot4.png")
op <- par(mfrow=c(2,2))
plot(ts0,xlab="",ylab="Global Active Power(kilowatts)")
plot(ts3,xlab="datetime",ylab="Voltage")
plot(z, plot.type = "single", col =c("black","red","blue") ,xlab="",ylab="Energy sub mertering")

legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1 ,
       col =c("black","red","blue"),cex=0.5)
plot(ts4,xlab="datetime",ylab="Global_reactive_power")
par(op)

dev.off()

#par(mfrow=c(1,1))




