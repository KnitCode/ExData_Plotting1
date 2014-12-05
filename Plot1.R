##
## Plot 1. Create a simple histogram using the global active power over all the data. 

setwd("/Users/Renee/GitRepos/ExploratoryAnalysis/project1/ExData_Plotting1")

## Read in the date using the fread() command from the data.table package. 
## install.packages("data.table")

library(data.table)

## Use a character skip argument to fread in order to get to the first date of interest. Then we want
## every line for every minute over 48 hours, or 2880 lines of data

x<-fread("/Users/Renee/GitRepos/ExploratoryAnalysis/project1/ExData_Plotting1/household_power_consumption.txt",
         nrows=2880, skip="1/2/2007")

## this way of reading the data skips the headers so you have to reattach them if you want to use those
## got warnings that you should use setnames(x,old,new) instead of colnames, but I couldn't get it to work

colnames(x)<-c("Date","Time","Global_active_power","global_reactive_power","voltage","global inensity","sub_metering_1","sub_metering_2","sub_metering_3")

## for every plot we are going to open up a png file, then do the plot, then close the plot with dev.off

## first histogram just maps the Global Active Power with red columns, title, and labeled axes
png("plot1")
hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
