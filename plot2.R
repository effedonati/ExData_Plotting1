##
## plot2.R
## a script for plotting Global Active Power vs Time (Electric power consumption dataset) 
## in a .png file or to video

## plot2
## USAGE:
## plot2()               # create a file plot2.png with the plot
##
## plot2(FALSE)          # or
## plot2(tofile=FALSE)   # draw the plot to video
##
plot2<-function(tofile=TRUE){
    Sys.setlocale("LC_TIME", "C")
    x<-read_dataset()
    if(tofile)
        png(file = "plot2.png",width = 480, height = 480)
    with(x,plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
    if(tofile)
        dev.off()
}

## read_dataset
## this function is used by plot2() to read the data to plot
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
