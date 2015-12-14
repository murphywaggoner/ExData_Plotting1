# Before running, set working directory with setwd() command
# to be the folder that contains the household_power_consumption.txt file

# read in the data, parsing by semicolons, counting the header
# and setting na.strings to a question mark.
rawdata <- read.table("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

# take only the rows where the date is 2007-2-1 and 2007-2-2
Data <- rawdata[as.Date(rawdata[,1], "%d/%m/%Y") == as.Date('2007-02-01') | 
                        as.Date(rawdata[,1], "%d/%m/%Y") == as.Date('2007-02-02'),]

# Create a new DateTime column with POSIX formatting 
Data$DateTime <- as.POSIXct(paste(Data$Date, as.character(Data$Time)))
  
# Create Plot 1 - a histogram with red bars
# and Main title (at top), x title (xlab)
# Vertical title is 'Frequency' by default
hist(Data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")

# save the plot to a file from the PNG device
dev.copy(png, file = "plot1.png" )

# if you don't turn of the PNG device, you can't access the plot
# this also clears the plot
dev.off() 

