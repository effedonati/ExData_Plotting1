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
    #dset<-mutate(dset,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(Time,format="%H:%M:%S"))
    dset<-mutate(dset,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(paste(Date,Time),format="%Y-%m-%d %H:%M:%S"))
    dset
    
}
plot1<-function(tofile=TRUE){
    x<-read_dataset()
    if(tofile)
      png(file = "plot1.png",width = 480, height = 480)
    hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
    hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
    if(tofile)
      dev.off()
}

plot2<-function(tofile=TRUE){
  Sys.setlocale("LC_TIME", "C")
  x<-read_dataset()
  if(tofile)
    png(file = "plot2.png",width = 480, height = 480)
  with(x,plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
  if(tofile)
    dev.off()
}

plot3<-function(tofile=TRUE){
  Sys.setlocale("LC_TIME", "C")
  x<-read_dataset()
  if(tofile)
    png(file = "plot3.png",width = 480, height = 480)
  with(x,plot(Time,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
  with(x, lines(Time, Sub_metering_2, col = "red"))
  with(x, lines(Time, Sub_metering_3, col = "blue"))
  legend("topright", col = c("black","red","blue"),lty=c(1,1,1),
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
  )
  if(tofile)
    dev.off()
}

plot4<-function(tofile=TRUE){
  Sys.setlocale("LC_TIME", "C")
  x<-read_dataset()
  if(tofile)
    png(file = "plot4.png",width = 480, height = 480)
  par(mfrow = c(2, 2))
  with(x,plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
  with(x,plot(Time,Voltage,type="l",xlab="datetime",ylab="Voltage"))
  
  with(x,plot(Time,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
  with(x, lines(Time, Sub_metering_2, col = "red"))
  with(x, lines(Time, Sub_metering_3, col = "blue"))
  legend("topright", col = c("black","red","blue"),lty=c(1,1,1),bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
  )
  with(x,plot(Time,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
  if(tofile)
    dev.off()
  par(mfrow=c(1,1))
}