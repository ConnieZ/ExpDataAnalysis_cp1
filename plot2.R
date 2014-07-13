#Please unzip the file into your working directory 
#and set the working directory to the final location of the file
#Read the file in from the working directory 
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec=".", na.string="?")
#change the format of the date column
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
twodays <- subset(hpc, hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02")
#create new datetime variable
twodays$DT <- paste(twodays$Date, twodays$Time)
twodays$DT <- strptime(twodays$DT, "%Y-%m-%d %H:%M:%S")
#prepare the png parameters
png("plot2.png", width = 480, height = 480)
#build the plot
with(twodays, plot(DT, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)"))
#close the connection
dev.off()
