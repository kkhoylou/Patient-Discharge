#libraries
library(dplyr)
library(plyr)
library(readr)
library(ggplot2)
library(stringr)
library(psych)
library(doBy)
library(quantreg)
library(calibrate)

county <- "SAN DIEGO"

#load in data frames
injury <- data.frame(read.csv("injury copy.csv",header = TRUE))
admission_Route <- data.frame(read.csv("admission_Route copy.csv",header = TRUE))
admission_Type <- data.frame(read.csv("admission_Type copy.csv",header = TRUE))
age <- data.frame(read.csv("age_Group copy.csv",header = TRUE))
fac <- data.frame(read.csv("facilities.csv",header = TRUE))
d_Days <- data.frame(read.csv("discharge_Days copy.csv",header = TRUE))
disposition <- data.frame(read.csv("disposition copy.csv",header = TRUE))
diagnosis <- data.frame(read.csv("diagnosis copy.csv",header = TRUE))
procedure <- data.frame(read.csv("procedure copy.csv",header = TRUE))
race <- data.frame(read.csv("race_Group copy.csv",header = TRUE))
care_Type <- data.frame(read.csv("type_Of_Care copy.csv",header = TRUE))

#filter out unknown data
care_Type <- subset(care_Type,Type.Of.Care!="Unknown")
admission_Route <- subset(admission_Route,Admission_Source_Route!="Unknown")
admission_Type <- subset(admission_Type,Admission_Type!="Unknown")
age <- subset(age,Age.Groups!="Unknown" & Age.Groups!="9-Jan" & Age.Groups!="19-Oct")
injury <- subset(injury,Principal.Injury.Group!="Other Accidents" & Principal.Injury.Group!="Other Vehicle/Transport")

fac$OSHPD.ID <- as.factor(fac$OSHPD.ID)

frame <- procedure
value <- .(Year,Principal_Procedure_Group)


#Set frame values by year for any frame
frame_By_Year <- ddply(subset(merge(fac, frame),County.Name==county),value, colwise(sum,"Count"))

#Change ttle and 
ggplot(frame_By_Year,
       aes(x=Year,y=Count, color=Principal_Procedure_Group))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by disposition days in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)

#Script to check county v cal death rate
cal_Death_Rate <- ddply(subset(merge(fac, frame),Disposition=="Died"),.(Year,Disposition), colwise(sum,"Count")) 
county_Death_Rate <- ddply(subset(merge(fac, frame),Disposition=="Died" & County.Name==county),.(Year,Disposition), colwise(sum,"Count"))
cal_Death_Rate$Rate <- cal_Death_Rate$Count/ddply(subset(merge(fac, frame)),.(Year), colwise(sum,"Count"))$Count
county_Death_Rate$Rate <- county_Death_Rate$Count/ddply(subset(merge(fac, frame),County.Name==county),.(Year), colwise(sum,"Count"))$Count

ggplot(cal_Death_Rate, aes(x=Year,y=Rate))+
  geom_point(color='green')+
  geom_point(data=county_Death_Rate,aes(y=Rate),color='red')
#Can do this for every county

#Now I will look at the deadliest hospitals in SD
county_Hospitals_DR <- ddply(subset(merge(fac, frame),Disposition=="Died" & County.Name==county),.(OSHPD.ID), colwise(sum,"Count")) 
total_Hospitals_Count <- ddply(subset(merge(fac, frame),County.Name==county),.(OSHPD.ID), colwise(sum,"Count"))
#Now have number of death and total patients
county_Hospitals_DR <- merge(county_Hospitals_DR, total_Hospitals_Count,by="OSHPD.ID")
county_Hospitals_DR$rate <- county_Hospitals_DR$Count.x/county_Hospitals_DR$Count.y
#Plot info
ggplot(county_Hospitals_DR,aes(rate, OSHPD.ID))+
  geom_point()
#Now get graph on info
summary(county_Hospitals_DR$rate)

#all hospitals
all_Hospitals_DR <- ddply(subset(merge(fac, frame),Disposition=="Died"),.(OSHPD.ID), colwise(sum,"Count")) 
all_Hospitals_Count <- ddply(merge(fac, frame),.(OSHPD.ID), colwise(sum,"Count"))
#Now have number of death and total patients
all_Hospitals_DR <- merge(all_Hospitals_DR, all_Hospitals_Count,by="OSHPD.ID")
all_Hospitals_DR$rate <- all_Hospitals_DR$Count.x/all_Hospitals_DR$Count.y



