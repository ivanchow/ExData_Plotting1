plot1b <- function()
{
  #inputFile <- "a.txt"
  inputFile <- "household_power_consumption.txt"
  con  <- file(inputFile, open = "r")
  # open(con)
  df <- data.frame()
  #ecdfList <- list()
  oneLine <- readLines(con, n = 1, warn = FALSE)
  n <- strsplit(oneLine, ";")
  dl <- list()
  i <- 1
  st <- strptime("01/02/2007", format = "%d/%m/%y") #2007-02-01
  et <- strptime("02/02/2007", format = "%d/%m/%y") #2007-02-02
  while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
    v <- strsplit(oneLine, ";")
    #print(v[1])
    if ( (strptime(v[[1]],format = "%d/%m/%y") >= st) && (strptime(v[[1]], format = "%d/%m/%y") <= et)) 
    {
      #v[,3] <- as.numeric(v[,3])
      dl <- append(dl, v)
    }
  } 
  
  close(con)
  #print(dl)
  #df <- as.data.frame(t(dl))
  df <- data.frame(matrix(unlist(dl), ncol = 9, byrow = TRUE))
  nnn <- c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_Intensity",
           "Sub_metering_1", "Sub metering_2", "Sub metering_3")
  names(df) <- nnn
  #png(filename="plot1.png")
  hist(as.numeric(df$Global_Active_Power), col = "red", 
       xlab = "Global Active Power (kilowatts)", main="Global Active Power")
  #dev.off()
  df
}