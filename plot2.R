ftn<-function(x){
  as.double(as.character(x[x != "?"]))
}
hHold<-read.table(file.path("project1","household.txt"),
                  skip = 40000,nrow=60000,header = F,sep=";")
names<-as.character(gsub(";",",","Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3"))
names<-strsplit(names,split=",")
names<-unlist(names)
names(hHold)<-names
head(hHold)
hHold<-subset(hHold,Date == "1/2/2007" | Date == "2/2/2007")
head(hHold)
library(lubridate) 
hHold$Date<-with(hHold,dmy_hms(paste(Date,Time,sep=",")))
#plot2
GAP<-hHold$Global_active_power
dev.copy(png,"plot2.png") 
with(hHold,plot(Date,ftn(GAP),type = "l"
,ylab = "Global Active Power (kilowatts)",xlab=""))
dev.off()