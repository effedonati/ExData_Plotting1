##
## plot3.R
## a script for plotting Energy sub metering vs Time (Electric power consumption dataset) 
## in a .png file or to video

## plot3
## USAGE:
## plot3()               # create a file plot3.png with the plot
##
## plot3(FALSE)          # or
## plot3(tofile=FALSE)   # draw the plot to video
##
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

## read_dataset
## this function is used by plot3() to read the data to plot
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
    #dset<-mutate(dset,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(Time,format="%H:%M:%S"))
    dset<-mutate(dset,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(paste(Date,Time),format="%Y-%m-%d %H:%M:%S"))
    dset
    
}
