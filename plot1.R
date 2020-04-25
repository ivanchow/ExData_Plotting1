#  this function plot the "Global Active Power" histogram
#  as week1 assignment for Exploratory Data Analysis
#  
plot1 <- function()
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
  df <- subset(df, df$Global_active_power != '?')
  
  #convert the data into double data type
  df$Global_active_power <- as.double(as.character(df$Global_active_power))

  # for testing on the screen
  hist(df$Global_active_power, col="red", xlab = "Global active power (kilowatts)",
            main = "Global active power") 

  # set the png format
  png(filename = "plot1.png", width = 480, height = 480)
  
  # plot the histogram into the graph
  hist(df$Global_active_power, col="red", xlab = "Global active power (kilowatts)",
       main = "Global active power")
  
  #turn off the graphic device
  dev.off()
  
  head(df)
}