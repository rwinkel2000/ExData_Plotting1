#===== start of data read-in ===========

my_source_file<-"C:/Data/Data_Mining/coursera_johns_hopkins_data_sci/Exploratory_Course/github/household_power_consumption.txt"
initial<-read.table(my_source_file, sep = ";", header = TRUE, stringsAsFactors = FALSE, nrows=100, quote="", strip.white = TRUE, na.strings ='?')
classes<-sapply(initial,class)
df_power<-read.table(my_source_file, sep = ";", header = TRUE, stringsAsFactors = FALSE,  quote="", colClasses=classes,strip.white = TRUE, na.strings ='?')
df_power$DateTime<-with(df_power, as.POSIXlt(strptime(paste(Date," ",Time), "%d/%m/%Y %H:%M:%S"))   )


# Just 2007-02-01 and 2007-02-02 
date_lowest  <- as.Date(as.POSIXlt(strptime('2007-02-01', "%Y-%m-%d")))
date_highest <- as.Date(as.POSIXlt(strptime('2007-02-02', "%Y-%m-%d")))
df<-subset(df_power, date_lowest <= as.Date(DateTime) & as.Date(DateTime) <= date_highest, select = c(-Date,-Time))   

rm(df_power)

#===== end of data read-in ========== =

# -------- plot 2
# My working directory, but unlikely to be yours! 
#setwd("C:/Data/Data_Mining/coursera_johns_hopkins_data_sci/Exploratory_Course/github/ExData_Plotting1")

png(file="plot2.png",width=480,height=480)
 
# x expressed in hours
x_values<-with(df, DateTime$wd*24+DateTime$hour+DateTime$min/60) 
with(df,plot(x= x_values,  y=Global_active_power, ylab="Global Active Power (kilowatts)", type="n", xaxt="n", xlab=""))
with(df,lines(x= x_values,  y=Global_active_power))


Aat = seq(from = min(x_values),  by=24, length.out=2)

x_axis_labels <- weekdays(df$DateTime[which(x_values %in% Aat)])
axis(1, labels=x_axis_labels, at = Aat)

dev.off()