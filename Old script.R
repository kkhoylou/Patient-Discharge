#List factors by amount count by year in injury
injury_By_Year <- ddply(subset(merge(fac, injury),County.Name==county),.(Year,Principal.Injury.Group), colwise(sum,"Count"))


#Got rid of of one value which threw off data
injury_By_Year <- subset(injury_By_Year,Count!=2895)
injury_By_Year

#Now I will attempt to put a fit line through
ggplot(injury_By_Year,
       aes(x=Year,y=Count,color=Principal.Injury.Group))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Injury in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)
#Using linear regression I was able to create fitted lines to create approximations
#The data for Misadventures seems it would be better fit by a non linear model
#will create a seperate non linear model for it
mis_Data <- subset(injury_By_Year,Principal.Injury.Group=="Misadventures/Complications")
x=mis_Data$Year

y=mis_Data$Count

a_start=12200
b_start=2*log(2)/a_start
exponential.model <- lm(log(y)~ x)
summary(exponential.model)
Counts.exponential2 <- exp(predict(exponential.model,list(x=x)))
plot(x, y)
lines(x, Counts.exponential2,lwd=2, col = "red", xlab = "Time (s)", ylab = "Counts")



cor(y,predict(m))
plot(x,y)
lines(x,predict(m),col="red",lty=2,lwd=3)
m

#Now let's graph by age
age_By_Year <- ddply(subset(merge(fac, age),County.Name==county),.(Year,Age.Groups), colwise(sum,"Count"))
age_By_Year <- subset(age_By_Year,Age.Groups!="Unknown" & Age.Groups!="19-Oct" & Age.Groups!="9-Jan")

ggplot(age_By_Year,
       aes(x=Year,y=Count,color=Age.Groups))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Age in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)
#Graph by care type
care_Type_By_Year <- ddply(subset(merge(fac, care_Type),County.Name==county),.(Year,Type.Of.Care), colwise(sum,"Count"))
care_Type_By_Year <- subset(care_Type_By_Year,Type.Of.Care!="Unknown")
str(care_Type_By_Year)
ggplot(care_Type_By_Year,
       aes(x=Year,y=Count,color=Type.Of.Care))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Type of Care in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)
#Exclude Acute becasue it is much larger than the rest of the values
care_Type_By_Year <- subset(care_Type_By_Year,Type.Of.Care!="Acute")
ggplot(care_Type_By_Year,
       aes(x=Year,y=Count,color=Type.Of.Care))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Type of Care in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)
#Can see Psychiatric is not linear

#check diagnosis
diagnosis_By_Year <- ddply(subset(merge(fac, diagnosis),County.Name==county),.(Year,Principal.Diagnosis.Group), colwise(sum,"Count"))

ggplot(diagnosis_By_Year,
       aes(x=Year,y=Count,color=Principal.Diagnosis.Group))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Diagnosis in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)
#large number of visits include birthing and all pregnancies
#second is circulatory followed by digestive, respiratory, and injuries
#most diagnoses seems steady other than resipratory and infections. 
#infections is on rise and respiratory is a bell curve effect

#check procedure
procedure_By_Year <- ddply(subset(merge(fac, procedure),County.Name==county),.(Year,Principal_Procedure_Group), colwise(sum,"Count"))

ggplot(procedure_By_Year,
       aes(x=Year,y=Count,color=Principal_Procedure_Group))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Age in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)

#Admission Route
admission_Route_By_Year <- ddply(subset(merge(fac,admission_Route),County.Name==county),.(Year,Admission_Source_Route),colwise(sum,"Count"))
admission_Route_By_Year <- subset(admission_Route_By_Year,Admission_Source_Route!="Unknown")
ggplot(admission_Route_By_Year,
       aes(x=Year,y=Count,color=Admission_Source_Route))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Route in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)
#Test is clear

#Admission Type
admission_Route_By_Year <- ddply(subset(merge(fac,admission_Route),County.Name==county),.(Year,Admission_Source_Route),colwise(sum,"Count"))
admission_Route_By_Year <- subset(admission_Route_By_Year,Admission_Source_Route!="Unknown")
ggplot(admission_Route_By_Year,
       aes(x=Year,y=Count,color=Admission_Source_Route))+
  geom_point(stat="identity",
             position="identity")+ 
  labs(title="Number of Hospital Visits by Route in San Diego",
       x="Year",
       y="Number of Cases")+
  xlim(2009,2016)+
  geom_smooth(method='lm',
              fullrange=TRUE)
