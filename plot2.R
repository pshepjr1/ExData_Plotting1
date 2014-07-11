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

## opend the device and plot the histogram
png(file="plot2.png")
with(data.subset, plot(Global_active_power ~ DateTime, type="l",main=" ", ylab="Global Active Power (kilowatts)",xlab=" "))
dev.off()

