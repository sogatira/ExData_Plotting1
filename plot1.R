
# We download the data file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "temp.zip")

# IIf you unzip the data file manually you can have some info about the data file running the next comand 
# where we have the size of the unzip file too. The size is about 132960755 bytes.

file.info("household_power_consumption.txt")

# First we read few lines of the data file to know what is the class of each column and then we read the entire file using
# the argument colClasses to run it faster.

sampleData <- read.table(unz("temp.zip", "household_power_consumption.txt"),
                         na.strings = "?", header = T, sep = ";", nrows = 5, stringsAsFactors = F)
classes <- sapply(sampleData, class)

df <- read.table(unz("temp.zip", "household_power_consumption.txt"),
                 na.strings = "?", header = T, sep = ";", colClasses = classes)

# We select only the data with date between 1/2/2007 and 2/2/2007 and create the variable datetime

df <- subset(df, Date == "1/2/2007" | Date == "2/2/2007")
datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df <- cbind(df, datetime)

# PLOTS

# plot1.png

png(filename = "plot1.png")

hist(df$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()

file.remove("temp.zip")