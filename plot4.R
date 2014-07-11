myzip = "exdata_data_household_power_consumption.zip"

#if data file has not yet been downloaded, fetch it
if (!file.exists(myzip)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile=myzip,mode="wb")
  unzip(myzip)
}

household_power_consumption <- read.csv("C:/Users/Paul/Desktop/R Programming Stuff/exploratory analysis week 1/exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

##select the data with the dates we want
data.subset <- subset(household_power_consumption, Date=='1/2/2007'| Date=='2/2/2007')

## create the date time stamp from the data to allow ordering by date time
data.subset$DateTime <- paste(data.subset$Date, data.subset$Time, sep=" ")
data.subset$DateTime <- as.POSIXct(data.subset$DateTime,format="%d/%m/%Y %H:%M:%S")

## opend the device and plot the 4 graphs
png(file="plot4.png")

par(mfrow = c(2, 2))

with(data.subset, hist(Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)"))

with(data.subset, plot(Global_active_power ~ DateTime, type="l",main=" ", ylab="Global Active Power (kilowatts)",xlab=" "))

plot(range(data.subset$DateTime), range(c(data.subset$Sub_metering_1, data.subset$Sub_metering_2, data.subset$Sub_metering_3)), type='n',ylab="Energy Sub Metering", xlab=" ")
lines(data.subset$DateTime, data.subset$Sub_metering_1, col="black")
lines(data.subset$DateTime, data.subset$Sub_metering_2, col="red")
lines(data.subset$DateTime, data.subset$Sub_metering_3, col="blue")
legend("topright",lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

with(data.subset, plot(Global_reactive_power ~ DateTime, type="l",main=" ",xlab="datetime"))

dev.off()