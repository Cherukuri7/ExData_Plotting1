
library(stringr)
library(dplyr)
library(lubridate)

colNames<-as.character(str_split(readLines("household_power_consumption.txt",n=1),";")[[1]])
skip <-grep("1/2/2007",readLines("household_power_consumption.txt"))[1]-1


energy_data<- read.table("household_power_consumption.txt",sep = ";",na.strings = "?",skip=skip,nrows = 2880,col.names = colNames)
energy_data<-mutate(energy_data,Date=dmy(Date)+hms(Time),Time=hms(Time))


png(file="plot1.png", width = 480,height = 480,units = "px")
hist(energy_data$Global_active_power,main="Global Active Power",xlab = "Global Active Power (kilowatts)",col = "red")
dev.off()

