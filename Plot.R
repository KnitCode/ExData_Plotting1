setwd("/Users/Renee/GitRepos/ExploratoryAnalysis/project1/")

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

## for the other plots we need timestamp info. create a combined, normalized date for each data point
combo<-paste(x$Date,x$Time)
date<-strptime(combo,"%d/%m/%Y %H:%M:%S")

## plot 3 is three submeter graphs on single plot by date
png("plot3") ## open the png file

plot(date,x$sub_metering_1,type="s",xlab="",ylab="Energy sub metering") ## initial plot of data
points(date,x$sub_metering_2,type="s", col="red") ## this adds points for the 2nd set of data
points(date,x$sub_metering_3,type="s", col="blue") ## and more points for the 3rd set

## now add a legend to the whole thing. the lty=1 creates the solid lines for the legend. lty=2 gives dashed lines. pch=1 gave circles

legend("topright",lty=1, col=c("black","red","blue"),legend=c("Sub_metering1","Sub_metering2","Sub_metering3"))

dev.off() ## close the file

