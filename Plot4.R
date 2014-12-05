## 
## Plot4. Create a 2x2 set of plots that express the energy usage of the household over two days. 

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

## for the other plots we need timestamp info. create a combined, normalized date for each data point
combo<-paste(x$Date,x$Time)
date<-strptime(combo,"%d/%m/%Y %H:%M:%S")

## plot 4

## make 2 by 2 set of graphs using the par() function to arrange them
## when I tried to use the R Studio export for the graph and adjust the size to 480x480 it messed
## up the legends. Instead, I use the png() to create a file from the plot directly and it puts it to 
## 480x480 automatically and seems to work fine. 

png("plot4")
par(mfrow=c(2,2))  ## set 2 x 2 arrangement 

## this approach lets you map several subgraphs all in one command

with(x,{  ## using the data frame x do these things
     plot(date,Global_active_power,type="l",xlab="",ylab="Global Active Power")
     
     plot(date, voltage,type="l",ylab="Voltage",xlab="datetime")
     
     plot(date,x$sub_metering_1,type="s",xlab="",ylab="Energy sub metering")
     points(date,x$sub_metering_2,type="s", col="red")
     points(date,x$sub_metering_3,type="s", col="blue")
     legend("topright",lty=1,cex=0.5,bty="n", col=c("black","red","blue"),
            legend=c("Sub_metering1","Sub_metering2","Sub_metering3"))
     
     plot(date,global_reactive_power,type="l")
})
dev.off()
