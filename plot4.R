# Set the working directory
setwd("C:/Users/jeffk_000/Dropbox/Work Files/BI/Information Management/07. Data Scientist Toolbox/04. Exploratory Data Analysis/Week 1")


## load library data.table

library(data.table)
library(dplyr)
library(lubridate)

## Add Headings

## get the headings of the data frame data
## read in one row of the master file to get the headings

headings<-read.csv("household_power_consumption.txt", nrows=1, sep=";")

## get the column names and save in the cnames vector

cnames<-colnames(headings)

## read in the number of rows corresponding to 2007-02-01 to 2007-02-02 
data<-read.csv("household_power_consumption.txt", nrows=2879, skip =66636, sep=";")

## get the column names and of the subset data in the data frame data

cname0<-colnames(data)



## use the data.table function to rename the headings in the 'data' frame to be correct

setnames(data, old = cname0, new = cnames)

## Convert Date and time string into a new column DateTime using lubridate library and dplyr and create new data set Data1 

Data1 = mutate(data,DateTime = dmy_hms(paste(Date, Time, sep = ' ')))
## Output the result to a PNG
## Open the PNG device
png(filename="Plot4.png")
## Plot the graph

par(mfrow=(c(2,2)))

plot(Data1$DateTime,Data1$Global_active_power, type="l",xlab="",ylab="Global Active Power (Kilowatts)")
plot(Data1$DateTime,Data1$Voltage, type="l",xlab="DateTime",ylab="Voltage")

plot(Data1$DateTime,Data1$Sub_metering_1, type="l",xlab="",ylab="Sub Metering")
with (Data1, lines(Data1$DateTime,Data1$Sub_metering_2,col="red"))
with (Data1, lines(Data1$DateTime,Data1$Sub_metering_3,col="blue"))
legend("topright",pch="-",col=c("black","red","blue"),legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),xjust=0,lwd=2,bty="n",cex=0.8)

plot(Data1$DateTime,Data1$Global_reactive_power, type="l",xlab="DateTime",ylab="Global_reactive_power")
## Close the device
dev.off()