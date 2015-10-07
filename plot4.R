
library(stringr)
library(dplyr)
library(lubridate)

colNames<-as.character(str_split(readLines("household_power_consumption.txt",n=1),";")[[1]])
skip <-grep("1/2/2007",readLines("household_power_consumption.txt"))[1]-1

energy_data<- read.table("household_power_consumption.txt",sep = ";",na.strings = "?",skip=skip,nrows = 2880,col.names = colNames)
energy_data<-mutate(energy_data,Date=dmy(Date)+hms(Time),Time=hms(Time))

png(file="plot4.png", width = 480,height = 480,units = "px")
par(mfrow=c(2,2))

#1
plot(energy_data$Date,energy_data$Global_active_power,type="l",xlab='',ylab = "Global Active Power")

#2
plot(energy_data$Date,energy_data$Voltage,type="l",xlab='datetime',ylab = "Voltage")

#3. Note: bty="n" removes box around legend
plot(energy_data$Date,energy_data$Sub_metering_1,type="n",xlab='',ylab = "Energy sub meetering")
points(energy_data$Date,energy_data$Sub_metering_1,col="black",type="l")
points(energy_data$Date,energy_data$Sub_metering_2,col="red",type="l")
points(energy_data$Date,energy_data$Sub_metering_3,col="blue",type="l")
legend("topright",pch="_",bty="n",col=c("black","red","blue"),legend=names(energy_data)[7:9])

#4
plot(energy_data$Date,energy_data$Global_reactive_power,type="l",xlab='datetime',ylab = "Global_reactive_power")
dev.off()

