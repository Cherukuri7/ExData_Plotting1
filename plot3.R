
library(stringr)
library(dplyr)
library(lubridate)

colNames<-as.character(str_split(readLines("household_power_consumption.txt",n=1),";")[[1]])
skip <-grep("1/2/2007",readLines("household_power_consumption.txt"))[1]-1


energy_data<- read.table("household_power_consumption.txt",sep = ";",na.strings = "?",skip=skip,nrows = 2880,col.names = colNames)
energy_data<-mutate(energy_data,Date=dmy(Date)+hms(Time),Time=hms(Time))


png(file="plot3.png", width = 480,height = 480,units = "px")
plot(energy_data$Date,energy_data$Sub_metering_1,type="n",xlab='',ylab = "Energy sub meetering")
points(energy_data$Date,energy_data$Sub_metering_1,col="black",type="l")
points(energy_data$Date,energy_data$Sub_metering_2,col="red",type="l")
points(energy_data$Date,energy_data$Sub_metering_3,col="blue",type="l")
legend("topright",pch="_",col=c("black","red","blue"),legend=names(energy_data)[7:9])
dev.off()


