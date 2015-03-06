download_dataset<-function() {
    filename<-"./household_power_consumption.zip"
    fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl,destfile=filename,method="curl")
    print("downloaded")
    unzip(filename)
    print("unzipped")
    
    
}
