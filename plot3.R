# Converted the text file to csv before reading it
electricData <- read.csv("household_power_consumption.csv", header = TRUE, sep = ";")

# Created subsets corresponding to the two dates used for analysis: Feb 1, 2007 and Feb 2, 2007
electricDataFeb1 <- subset(electricData, Date == "1/2/2007")
electricDataFeb2 <- subset(electricData, Date == "2/2/2007")

# Combined the two subsets
electricDataFeb <- rbind.data.frame(electricDataFeb1, electricDataFeb2)

# Extracted the Date and Time columns into a new data frame and created a new column called DtTm using strptime() to convert factor into DateTime
DT <- cbind.data.frame(electricDataFeb$Date, electricDataFeb$Time)
electricDataFeb$DtTm <- strptime(paste(DT[,1],DT[,2]), "%d/%m/%Y %H:%M:%OS")

png(filename = "plot3.png", width = 480, height = 480)

x <- electricDataFeb$DtTm
# Converted Sub_metering_1, Sub_metering_2, Sub_metering_3 from factor to numeric using as.numeric
y1 <- as.numeric(levels(electricDataFeb$Sub_metering_1))[electricDataFeb$Sub_metering_1]
y2 <- as.numeric(levels(electricDataFeb$Sub_metering_2))[electricDataFeb$Sub_metering_2]
y3 <- as.numeric(electricDataFeb$Sub_metering_3)
plot(x, y1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(x, y2, col="red")
lines(x, y3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

dev.off()