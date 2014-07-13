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
#now building the plot
#set the png parameters first
png("plot4.png", width = 480, height = 480)
#build the plot
par(mfrow = c(2,2))
with(twodays, {
  #top left plot
  plot(DT, Global_active_power, type="l", ylab = "Global Active Power", xlab = "")
  #top right plot
  plot(DT, Voltage, type="l", xlab = "datetime", ylab = "Voltage")
  #bottom left plot
  plot (x= twodays$DT, y= twodays$Sub_metering_1,type ="l", xlab ="", ylab = "Energy sub metering")
  lines (x= twodays$DT, y= twodays$Sub_metering_2, col ="red")
  lines (x= twodays$DT, y= twodays$Sub_metering_3, col ="blue")
  legend("topright" , legend = c("Sub_metering_1 ","Sub_metering_2","Sub_metering_3"),
         cex = 0.9,lty=c(1,1,1), bty="n", col=c("black", "red","blue"))
  #bottom right plot  
  plot(DT, Global_reactive_power, type="l", xlab = "datetime")
})

#close the connection
dev.off()
