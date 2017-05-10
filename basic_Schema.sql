-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2016-05-24 20:27:12.179

-- tables
-- Table: adm_Route
CREATE TABLE adm_Route (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    Admission_Source_Route varchar  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT mytable_pk PRIMARY KEY (Admission_Source_Route,Count)
);

-- Table: adm_Type
CREATE TABLE adm_Type (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    Admission_Type varchar  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT adm_Type_pk PRIMARY KEY (Admission_Type,Count)
);

-- Table: age_Group
CREATE TABLE age_Group (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    Age_Groups varchar  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT age_Group_pk PRIMARY KEY (Age_Groups,Count)
);

-- Table: discharge
CREATE TABLE discharge (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    Discharge_Days int  NOT NULL,
    CONSTRAINT discharge_pk PRIMARY KEY (Discharge_Days)
);

-- Table: disposition
CREATE TABLE disposition (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    disposition varchar  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT disposition_pk PRIMARY KEY (disposition,Count)
);

-- Table: facilities
CREATE TABLE facilities (
    Oshpd_ID int  NOT NULL,
    Facility_Name varchar  NOT NULL,
    County_Name varchar  NOT NULL,
    Type_Of_Control varchar  NOT NULL,
    CONSTRAINT facilities_pk PRIMARY KEY (Oshpd_ID)
);

-- Table: injury
CREATE TABLE injury (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    principal_Injury varchar  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT injury_pk PRIMARY KEY (principal_Injury,Count)
);

-- Table: principal_Diagnosis
CREATE TABLE principal_Diagnosis (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    Principal_Diagnosis varchar  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT principal_Diagnosis_pk PRIMARY KEY (Principal_Diagnosis,Count)
);

-- Table: procedure
CREATE TABLE "procedure" (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    "procedure" int  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT procedure_pk PRIMARY KEY ("procedure",Count)
);

-- Table: race
CREATE TABLE race (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    Race_Group varchar  NOT NULL,
    Count int  NOT NULL,
    CONSTRAINT race_pk PRIMARY KEY (Race_Group,Count)
);

-- Table: type_Of_Care
CREATE TABLE type_Of_Care (
    Year int  NOT NULL,
    Oshpd_ID int  NOT NULL,
    Type_Of_Care varchar  NOT NULL,
    Count int  NOT NULL,
    facilities_Oshpd_ID int  NOT NULL,
    CONSTRAINT type_Of_Care_pk PRIMARY KEY (Oshpd_ID)
);

-- foreign keys
-- Reference: adm_Route_facilities (table: adm_Route)
ALTER TABLE adm_Route ADD CONSTRAINT adm_Route_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: adm_Type_facilities (table: adm_Type)
ALTER TABLE adm_Type ADD CONSTRAINT adm_Type_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: age_Group_facilities (table: age_Group)
ALTER TABLE age_Group ADD CONSTRAINT age_Group_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: discharge_facilities (table: discharge)
ALTER TABLE discharge ADD CONSTRAINT discharge_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: disposition_facilities (table: disposition)
ALTER TABLE disposition ADD CONSTRAINT disposition_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: injury_facilities (table: injury)
ALTER TABLE injury ADD CONSTRAINT injury_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: principal_Diagnosis_facilities (table: principal_Diagnosis)
ALTER TABLE principal_Diagnosis ADD CONSTRAINT principal_Diagnosis_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: procedure_facilities (table: procedure)
ALTER TABLE "procedure" ADD CONSTRAINT procedure_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: race_facilities (table: race)
ALTER TABLE race ADD CONSTRAINT race_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: type_Of_Care_facilities (table: type_Of_Care)
ALTER TABLE type_Of_Care ADD CONSTRAINT type_Of_Care_facilities
    FOREIGN KEY (Oshpd_ID)
    REFERENCES facilities (Oshpd_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

