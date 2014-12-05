
## Course Project One -- making simple graphs
## this is my entire project. I need to create separate R files for each of the individual plots. 

## There are a lot of annoying things about working with the graphs for this kind of project, I found.
## Many times what I was seeing in R Studio as my resulting graph would have tiny things off, like the
## way the axis was labeled or the setting of the legend. In the end, most of the time these things were
## just resolved by writing the file to the png. that wasted a lot of time. 

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

## for the other plots we need timestamp info. create a combined, normalized date for each data point
combo<-paste(x$Date,x$Time)
date<-strptime(combo,"%d/%m/%Y %H:%M:%S")

## plot 2 maps the global active power over the date range
## gets the signal type graph (type l) and automatically converts dates
png("plot2")
plot(date,x$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()

## plot 3 is three submeter graphs on single plot by date
png("plot3") ## open the png file

plot(date,x$sub_metering_1,type="s",xlab="",ylab="Energy sub metering") ## initial plot of data
points(date,x$sub_metering_2,type="s", col="red") ## this adds points for the 2nd set of data
points(date,x$sub_metering_3,type="s", col="blue") ## and more points for the 3rd set

## now add a legend to the whole thing. the lty=1 creates the solid lines for the legend. lty=2 gives dashed lines. pch=1 gave circles

legend("topright",lty=1, col=c("black","red","blue"),legend=c("Sub_metering1","Sub_metering2","Sub_metering3"))

dev.off() ## close the file


## plot 4

## make 2 by 2 set of graphs using the par() function to arrange them
## when I tried to use the R Studio export for the graph and adjust the size to 480x480 it messed
## up the legends. Instead, I use the png() to create a file from the plot directly and it puts it to 
## 480x480 automatically and seems to work fine. 

png("Plot4")
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

