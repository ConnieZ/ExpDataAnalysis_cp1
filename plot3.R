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
png("plot3.png", width = 480, height = 480)
# build the plot with 3 lines
plot (x= twodays$DT, y= twodays$Sub_metering_1,type ="l", xlab ="", ylab = "Energy sub metering")
lines (x= twodays$DT, y= twodays$Sub_metering_2, col ="red")
lines (x= twodays$DT, y= twodays$Sub_metering_3, col ="blue")
# add legend in the top right corner
legend("topright" , legend = c("Sub_metering_1 ","Sub_metering_2","Sub_metering_3"), 
       cex = 0.9, lty=c(1,1,1), col=c("black", "red","blue")) 
#close the connection
dev.off()