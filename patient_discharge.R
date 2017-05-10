#load in libraries
library(dplyr)
library(readr)
library(ggplot2)
library(stringr)
library(psych)
library(doBy)

#load in data frames
injury <- data.frame(read.csv("injury copy.csv",header = TRUE))
admission <- data.frame(read.csv("admission_Type copy.csv",header = TRUE))
age <- data.frame(read.csv("age_Group copy.csv",header = TRUE))
fac <- data.frame(read.csv("facilities.csv",header = TRUE))
d_Days <- data.frame(read.csv("discharge_Days.csv"))
disposition <- data.frame(read.csv("disposition.csv"))
diagnosis <- data.frame(read.csv("Patient_Discharge_Data_By_Principal_Diagnosis.csv"))
procedure <- data.frame(read.csv("Patient_Discharge_Data_By_Principal_Procedure.csv"))
race <- data.frame(read.csv("Patient_Discharge_Data_by_Race_Groups__2009_-_2014.csv"))
care_Type <- data.frame(read.csv("Patient_Discharge_Data_by_Type_Of_Care__2009_-_2014.csv"))

#check several data frames
head(injury)

#check unique injury
unique(injury$Principal.Injury.Group)
head(diagnosis)
unique(diagnosis$Principal.Diagnosis.Group)

#different sum values between files
sum(injury$Count)
sum(diagnosis$Count)

head(admission)
#check unique types of admission
unique(admission$Admission_Type)

#look at scheduled vs unscheduled for each hospitals by year
#Unscheduled much higher, Non profit organizations have large bulk of apoointments

head(age)
#regression models
fit1 <- lm(Count ~ County.Name + Age.Groups + Year, data=age)
fit <- lm(Count ~ County.Name + Year, data=age)
anova(fit1,fit)

describe.by(age)

mytable <- xtabs(~Year+Count, data=age)
ftable(mytable) # print table 
summary(mytable) # chi-square test of indepedence


