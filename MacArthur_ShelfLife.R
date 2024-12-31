##For File Organization Purposes
setwd("C:/Users/samab/OneDrive/Documents/MacDat")

##Loading Packages
library(haven)
library(tidyverse)
library(skimr)

##Reading in the data
##IDEA: perhaps want to do that Dr. Lucas pivot long/
##pivot short technique
macdat_baseline <- read_sav("baseline.sav")
macdat_commcoll <- read_sav("commcoll.sav")
macdat_follcoll <- read_sav("follcoll.sav")
macdat_follsubj <- read_sav("follsubj.sav")
macdat_violence <- read_sav("violence.sav")

##Filtering to Exclude Irrelevant Variables
macdat_baseline <- macdat_baseline %>%
  select(-c("STUDYID", ))

##Making a More Exact Age Variable Since the one included with the dataset is rounded to the nearest year
# Convert numeric components to Date objects
macdat_baseline$DOB <- make_date(year = macdat_baseline$YDOB, 
                                 month = macdat_baseline$MDOB, 
                                 day = macdat_baseline$DDOB)

macdat_baseline$ADM <- make_date(year = macdat_baseline$YADM, 
                                 month = macdat_baseline$MADM, 
                                 day = macdat_baseline$DADM)

# Calculate age at admission
macdat_baseline$exact_age <- as.numeric(difftime(macdat_baseline$ADM, macdat_baseline$DOB, units = "days")) / 365.25

# Remove unnecessary variables now that exact age has been calculated
##successfully calculated for all without any missing
macdat_baseline <- macdat_baseline %>%
  select(-c(MDOB, DDOB, YDOB, MADM, DADM, YADM, DOB, ADM))

##Skim the Dataset (FOR CLEANING/ANALYSIS TO FIGURE OUT CAN BE USED)
skim(macdat_baseline)

##FOR RUNNING AFTER DONE WORKING W/ THIS DATA
setwd("C:/Users/samab/OneDrive/Documents")
