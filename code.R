library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/dra_somalia_needs_assessment")
data <- read_excel("data.xlsx", 
                   col_types = c("text", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "numeric", "numeric", "text", 
                                "text"))

selectedKeyVars <- c('region',
                     'district',
                     'idpsettlement',
                     'respgender',
                     'respage',
                     'breadwinner',
                     'householdExpenditure',
                     'totalEhh', 'settlement',	
                     'personWithDisabilities'
                                          )

weightVars <- c('weightsGeneral')

#Convert variables into factors
cols =  c('region',
          'district',
          'idpsettlement',
          'respgender',
          'respage',
          'breadwinner',
          'householdExpenditure',
          'totalEhh',	'weightsGeneral',	'personWithDisabilities')

data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
subVars <- c(selectedKeyVars, weightVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars, weightVar = weightVars
                       )

print(objSDC, "risk")

#Generate an internal report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 
