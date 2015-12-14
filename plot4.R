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

# Create Plot 4 - a multivariate time series - in a grid

# cover columns to time series GlobalActivePower, GlobalReactivePower, Voltage and 
# and the 3 submetering columns
# Choose frequency = 1440 = minutes in a day since
# the data was collected each minute
# start = 1 will begin the count at 1.  These the major tickmarks are 1, 2, 3 which
# are where the "Thu" "Fri" "Sat" will go
for (i in c(4, 5, 6, 7, 8, 9)) 
        Data[,i] <- ts(as.matrix(Data[,i]), frequency = 1440, start = c(1,1))


# set the plot to two rows and two columns (run plot.new() just in case)
plot.new()
par(mfrow=c(2,2))

# plot the Global_active_power
# time series object with appropriate ylab, suppress the x-axis so we can add it later
plot(Data$Global_active_power, ylab = "Global Active Power (kilowatts)", xaxt = "no")

# add the x-axis putting "Thu" "Fri" "Sat" at the tickmarks 1, 2, 3
axis(1, at = 1:3, labels = c("Thu", "Fri", "Sat") )


# plot the Voltage
# time series object with appropriate ylab, suppress the x-axis so we can add it later
plot(Data$Voltage, ylab = "Voltage", xaxt = "no")

# add the x-axis putting "Thu" "Fri" "Sat" at the tickmarks 1, 2, 3
axis(1, at = 1:3, labels = c("Thu", "Fri", "Sat") )

# plot the sub_metering time series
# Use ts.plot to superimpose time series
# gpars is how to pass the graphical parameters (such as turning the x-axis off) thru ts.plot
ts.plot(Data[,7], Data[,8], Data[,9], col=plotcols,  
        gpars=list(xaxt="no",ylab = "Energy sub metering"),xlab = NULL )

# add the x-axis putting "Thu" "Fri" "Sat" at the tickmarks 1, 2, 3
axis(1, at = 1:3, labels = c("Thu", "Fri", "Sat") )

# add a legend in the topright corner using the names of the sub_metering columns
# create solid lines (lty = 1) of the same colors as the time series
# the cex parameter helps in eliminating chopped legends when saved to the png file
legend('topright', legend = names(Data[,7:9]), lty=1, col=plotcols,
       lwd = 2, cex = 0.8)



# plot the Global_reactive_power
# time series object with appropriate ylab, suppress the x-axis so we can add it later
plot(Data$Global_reactive_power, ylab = "Global Reactive Power (kilowatts)", xaxt = "no")

# add the x-axis putting "Thu" "Fri" "Sat" at the tickmarks 1, 2, 3
axis(1, at = 1:3, labels = c("Thu", "Fri", "Sat") )


dev.copy(png, file = "plot4.png")
dev.off()
