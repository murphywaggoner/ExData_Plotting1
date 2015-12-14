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


# Create Plot 3 - a multivariate time series

# Convert the sub_metering columns (7:9) to time series in Data
# Choose frequency = 1440 = minutes in a day since the data was collected each minute
# start = 1 will begin the count at 1.  These the major tickmarks are 1, 2, 3 which
# are where the "Thu" "Fri" "Sat" will go
for (i in c(7, 8, 9)) 
        Data[,i] <- ts(as.matrix(Data[,i]), frequency = 1440, start = c(1,1))

# set up a vector for the colors used for the three plots
# since it is used in multiple commands
plotcols <- c("black", "red","blue")

# save the plot to a file from the PNG device
# The purpose is to get a plot that matches what we see in RStudio
# However, the plot won't show up in RStudio unless you comment the
# png() line out
png(filename = "plot3.png" )

# Use ts.plot to superimpose time plots
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

# if you don't turn of the PNG device, you can't access the plot
dev.off()

