
library(stringr)
colNames<-as.character(str_split(readLines("household_power_consumption.txt",n=1),";")[[1]])
# Set number of rows to skip by reading the first value of vector returned by grep()
# -1 at the end skips the header as well
skip <-grep("1/2/2007",readLines("household_power_consumption.txt"))[1]-1

# We will read only Sep 1st and Sep2nd data by skipping the # of  rows
# and reading 2880 rows which equals number of minutes in two days.
energy_data<- read.table("household_power_consumption.txt",sep = ";",na.strings = "?",skip=skip,nrows = 2880,col.names = colNames)
rm("colNames","skip") # cleanup unnecessary variables

# Load needed packages
library(dplyr)
library(lubridate)

# Transform Date and Time variables from string to Date and Time classes
energy_data<-mutate(energy_data,Date=dmy(Date)+hms(Time),Time=hms(Time))
#energy_data<-mutate(energy_data,Date=dmy(Date),Time=hms(Time))

png(file="plot1.png", width = 480,height = 480,units = "px")
hist(energy_data$Global_active_power,main="Global Active Power",xlab = "Global Active Power(kilowatts",col = "red")


