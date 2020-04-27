#  this function plot the "Global Active Power" histogram
#  as week1 assignment for Exploratory Data Analysis 
#  based on weekdays
#  
plot3 <- function()
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
  
  #convert the data into double data type
  df$Sub_metering_3 <- as.double(as.character(df$Sub_metering_3))
  df$Sub_metering_2 <- as.double(as.character(df$Sub_metering_2))
  df$Sub_metering_1 <- as.double(as.character(df$Sub_metering_1))
  
  df$timestamp <- paste(df$Date, df$Time)

  # for testing on the screen
  g <- ggplot(df, aes(x=timestamp))
  g <- g + geom_line(aes(y=Sub_metering_1, col="grey", group=1))
  g <- g + geom_line(aes(y=Sub_metering_2, col="blue", group=1))
  g <- g + geom_line(aes(y=Sub_metering_3, col="red", group=1))
  g

  # set the png format
  png(filename = "plot3.png", width = 480, height = 480)
  
  # plot the histogram into the graph
  g <- ggplot(df, aes(x=timestamp))
  g <- g + geom_line(aes(y=Sub_metering_1, col="grey", group=1))
  g <- g + geom_line(aes(y=Sub_metering_2, col="blue", group=1))
  g <- g + geom_line(aes(y=Sub_metering_3, col="red", group=1))
  g
  
  #turn off the graphic device
  dev.off()
  
  head(df)
}