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

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2), mar = c(4, 4, 2, 2))
x4 <- electricDataFeb$DtTm

y41 <- as.numeric(levels(electricDataFeb$Global_active_power))[electricDataFeb$Global_active_power]
plot(x4, y41, type = "l", ylab = "Global Active Power", xlab = "")

y42 <- as.numeric(levels(electricDataFeb$Voltage))[electricDataFeb$Voltage]
plot(x4, y42, type = "l", ylab = "Voltage", xlab = "datetime")

y431 <- as.numeric(levels(electricDataFeb$Sub_metering_1))[electricDataFeb$Sub_metering_1]
y432 <- as.numeric(levels(electricDataFeb$Sub_metering_2))[electricDataFeb$Sub_metering_2]
y433 <- as.numeric(electricDataFeb$Sub_metering_3)
plot(x4, y431, type = "l", ylab = "Energy sub metering", xlab = "")
lines(x4, y432, col="red")
lines(x4, y433, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), box.lwd = 0, box.col = "white")

y44 <- as.numeric(levels(electricDataFeb$Global_reactive_power))[electricDataFeb$Global_reactive_power]
plot(x4, y44, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()