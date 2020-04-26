plot1c <- function()
{
  
  inputFile <- "household_power_consumption.txt"
  #inputFile <- "a.txt"
  
  df <- read.table(inputFile, sep=";", header=T)
  st <- strptime("01/02/2007", format = "%d/%m/%Y") #2007-02-01
  et <- strptime("02/02/2007", format = "%d/%m/%Y") #2007-02-02
  df$Date <- strptime(df$Date,format = "%d/%m/%Y")
  
  df <- subset(df, df$Date <= et & df$Date >= st)
  df <- subset(df, df$Global_active_power != '?')
  #df$Global_active_power <- as.numeric(df$Global_active_power)
  
  # add timestamp column
  df$timestamp <- paste(df$Date, df$Time)
  
  df
  
}