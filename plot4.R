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
GAP<-hHold$Global_active_power
GRP<-hHold$Global_reactive_power
V<-hHold$Voltage 
a<-with(hHold,ftn(Sub_metering_1)) 
b<-with(hHold,ftn(Sub_metering_2)) 
c<-with(hHold,ftn(Sub_metering_3))

dev.copy(png,"plot4.png")
par(mfcol=c(2,2)) 
#plot4.1
with(hHold,plot(Date,ftn(GAP),type = "l"
                ,ylab = "Global Active Power (kilowatts)",xlab=""))

#plot4.2
with(hHold,plot(Date,a,type="n",xlab="",ylab="Energy sub metering"))
with(hHold,points(Date,a,type ="l"))
with(hHold,points(Date,b,type ="l",col="red"))
with(hHold,points(Date,c,type ="l",col="blue"))
legend("topright",lwd = 2, col = c("black","red","blue"),bty = "n", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#plot4.3
with(hHold,plot(Date,ftn(V),type = "l"
                ,ylab = "Voltage",xlab="datetime"))

#plot4.4
with(hHold,plot(Date,ftn(GRP),type = "l"
                ,ylab = "Global_reactive_power",xlab="datetime"))
dev.off()