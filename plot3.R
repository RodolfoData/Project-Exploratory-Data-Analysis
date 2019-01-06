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
#plot3
a<-with(hHold,ftn(Sub_metering_1)) 
b<-with(hHold,ftn(Sub_metering_2)) 
c<-with(hHold,ftn(Sub_metering_3))
max<-c(max(a),max(b),max(c)) 
min<-c(min(a),min(b),min(c))
d<-paste(max,min,sep=",")
d
#[1] "38,0" "2,0"  "19,0"
dev.copy(png,"plot3.png") 
with(hHold,plot(Date,a,type="n",xlab="",ylab="Energy sub metering"))
with(hHold,points(Date,a,type ="l"))
with(hHold,points(Date,b,type ="l",col="red"))
with(hHold,points(Date,c,type ="l",col="blue"))
legend("topright",lwd = 2, col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()