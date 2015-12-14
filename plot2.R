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

# Create Plot 2 - a time series 

# Conver the GlobalActivePower column to a time series object.  
# Choose frequency = 1440 = minutes in a day since  the data was collected each minute
# start = 1 will begin the count at 1.  These the major tickmarks are 1, 2, 3 which
# are where the "Thu" "Fri" "Sat" will go
Data$Global_active_power <- ts(Data$Global_active_power, frequency=1440, start=c(1,1))

# plot the time series object with appropriate ylab, suppress the x-axis so we can add it later
plot(Data$Global_active_power, ylab = "Global Active Power (kilowatts)", xaxt = "no")

# add the x-axis putting "Thu" "Fri" "Sat" at the tickmarks 1, 2, 3
axis(1, at = 1:3, labels = c("Thu", "Fri", "Sat") )

# save the plot to a file from the PNG device
dev.copy(png, file = "plot2.png" )
# if you don't turn of the PNG device, you can't access the plot
dev.off()