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

## opend the device and plot the histogram
png(file="plot1.png")
with(data.subset, hist(Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()