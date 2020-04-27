#  this function plot the "Global Active Power" histogram
#  as week1 assignment for Exploratory Data Analysis 
#  based on weekdays
#  
plot4 <- function()
{
  # Read the content file from the zip file downloaded from the website
  # https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
  # "household_power_consumption.txt" is the content
  
  inputFile <- "household_power_consumption.txt"
  #inputFile <- "a.txt"
  
  # read the data into data table
  df <- read.table(inputFile, sep=";", header=T)
  
  #subset the data based on dates 01 Feb 2007 to 02 Feb 2007
  st <- strptime("01/02/2007", format = "%d/%m/%Y") #2007-02-01
  et <- strptime("02/02/2007", format = "%d/%m/%Y") #2007-02-02
  df$Date <- strptime(df$Date,format = "%d/%m/%Y")
  df <- subset(df, df$Date <= et & df$Date >= st)
  
  #filter out the bad data
  df <- subset(df, df$Sub_metering_3 != '?' & df$Sub_metering_2 != '?' & df$Sub_metering_1 != '?')
  
  #convert the data into double data type
  df$Global_active_power <- as.double(as.character(df$Global_active_power))
  
  df$Sub_metering_3 <- as.double(as.character(df$Sub_metering_3))
  df$Sub_metering_2 <- as.double(as.character(df$Sub_metering_2))
  df$Sub_metering_1 <- as.double(as.character(df$Sub_metering_1))
  
  df$Voltage <- as.double(as.character(df$Voltage))  
  
  df$Global_reactive_power <- as.double(as.character(df$Global_reactive_power))    
  
  df$timestamp <- paste(df$Date, df$Time)

  # set up multigraph 2 x 2 on the same plot
  source("multiplot.R")

  # set the png format
  png(filename = "plot4.png", width = 480, height = 480)
  
  # plot 1
  g1 <- ggplot(df, aes(x=timestamp, y=Global_active_power, group=1)) + geom_line()

  
  # plot 2
  g2 <- ggplot(df, aes(x=timestamp, y=Voltage, group=1)) + geom_line()

  
  # plot 3
  g3 <- ggplot(df, aes(x=timestamp, y=Voltage, group=1)) + geom_line()
  g3 <- g3 + geom_line(aes(y=Sub_metering_1, col="grey", group=1))
  g3 <- g3 + geom_line(aes(y=Sub_metering_2, col="blue", group=1))
  g3 <- g3 + geom_line(aes(y=Sub_metering_3, col="red", group=1))
  
  # plot 4
  g4 <- ggplot(df, aes(x=timestamp, y=Global_reactive_power, group=1)) + geom_line()

  multiplot(g1,g2,g3,g4, cols=2)   
  
  #turn off the graphic device
  dev.off()
  
  head(df)
}