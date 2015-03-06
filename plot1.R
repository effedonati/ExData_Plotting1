##
## plot1.R
## a script for plotting frequency of Global Active Power (Electric power consumption dataset)
## in a .png file or to video

## plot1
## USAGE:
## plot1()               # create a file plot1.png with the plot
##
## plot1(FALSE)          # or
## plot1(tofile=FALSE)   # draw the plot to video
##
plot1<-function(tofile=TRUE){
    x<-read_dataset()
    if(tofile)
        png(file = "plot1.png",width = 480, height = 480)
    hist(x$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
    if(tofile)
        dev.off()
}

## read_dataset
## this function is used by plot1() to read the data to plot
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
