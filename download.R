download_dataset<-function() {
    filename<-"./household_power_consumption.zip"
    fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl,destfile=filename,method="curl")
    print("downloaded")
    unzip(filename)
    print("unzipped")
    
    
}

read_dataset<-function(){
    library(plyr,warn.conflicts=FALSE)
    library(lubridate)
    filename="./household_power_consumption.txt"
    rowstoskip=66637
    rowstoread=2880
    dset<-read.csv(file=filename,header=FALSE,sep=";",skip=rowstoskip,nrows=rowstoread)
    colnames <- read.csv(filename, header = FALSE, sep =';', nrows = 1,,stringsAsFactors = FALSE)
    names(dset)<-colnames
    dset<-mutate(dset,Date=dmy(Date),Time=hms(Time))
    dset
    
}
plot1<-function(){
    x<-read_dataset()
    hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
    png(file = "plot1.png",width = 480, height = 480)
    hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
    #    dev.copy(png, file = "plot1.png") 
    dev.off()
}

plot2<-function(){
  x<-read_dataset()
  hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
  png(file = "plot1.png",width = 480, height = 480)
  hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
  #    dev.copy(png, file = "plot1.png") 
  dev.off()
}