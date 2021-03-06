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

## Plot2

## Output the result to a PNG
## Open the PNG device
png(filename="Plot2.png")
## Plot the graph
plot(Data1$DateTime,Data1$Global_active_power, type="l",xlab="",ylab="Global Active Power (Kilowatts)")
## Close the device
dev.off()
