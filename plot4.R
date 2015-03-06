##
## plot4.R
## a script to create 4 plotting from Electric power consumption dataset 
## in a .png file or to video

## plot4
## USAGE:
## plot4()               # create a file plot4.png with the plots
##
## plot4(FALSE)          # or
## plot4(tofile=FALSE)   # draw the plots to video
##
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

## read_dataset
## this function is used by plot4() to read the data to plot
## USAGE:
## x<-read_dataset()  # read the data to data frame x
##
## REQUIRED:
## the file household_power_consumption.txt must be in the current directory
##
read_dataset<-function(){
    library(plyr,warn.conflicts=FALSE)
    filename="./household_power_consumption.txt"
    rowstoskip=66637
    rowstoread=2880
    dset<-read.csv(file=filename,header=FALSE,sep=";",skip=rowstoskip,nrows=rowstoread)
    colnames <- read.csv(filename, header = FALSE, sep =';', nrows = 1,,stringsAsFactors = FALSE)
    names(dset)<-colnames
    dset<-mutate(dset,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(paste(Date,Time),format="%Y-%m-%d %H:%M:%S"))
    dset
    
}
