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

png(filename = "plot1.png", width = 480, height = 480)

# Converted Global_active_power from factor to numeric using as.numeric
hist(as.numeric(levels(electricDataFeb$Global_active_power))[electricDataFeb$Global_active_power], col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()
                                  
