# Homework 11
# Gwen Ellis
# University of Vermont
# 2024 April 10
#
# load packages ----
library(log4r)
library(TeachingDemos)
library(tidyverse)
library(pracma)
library(ggmosaic)


# source function files ----
source("../../StrategicCodingPractices/barracudar/DataTableTemplate.R")
source("../../StrategicCodingPractices/barracudar/AddFolder.R")
source("../../StrategicCodingPractices/barracudar/BuildFunction.R")
source("../../StrategicCodingPractices/barracudar/MetaDataTemplate.R")
source("../../StrategicCodingPractices/barracudar/CreatePaddedLabel.R")
source("../../StrategicCodingPractices/barracudar/InitiateSeed.R")
source("../../StrategicCodingPractices/barracudar/SetUpLog.R")
source("../../StrategicCodingPractices/barracudar/SourceBatch.R")


# set up log files ----
initiate_seed()
set_up_log()

# 1. Folder creation ----
# add_folder()


# 2. Gather list of needed files ----
years <- list.files(path="OriginalData/NEON_count-landbird/", pattern = "BART")
file_list <- c()

for (i in seq_along(years)) {
  path_temp <- paste0("OriginalData/NEON_count-landbird/", years[i])
  file_list[i] <- list.files(path=path_temp, pattern="countdata", full.names=TRUE)
}


# 3. Building functions ----
# write pseudocode: 
# clean data to remove any missing observations
# extra year from file name
# calculate abundance for each year
# calculate species richness for each year

# list functions:
# clean.data()
# extract.year()
# calc.abundance()
# calc.richness()

# batch make function templates:
# build_function(c("Clean.data","Extract.year","Calc.abundance","Calc.richness"))

# write the functions

# source the new functions
source("Functions/Clean.data.R")
source("Functions/Extract.year.R")
source("Functions/Calc.abundance.R")
source("Functions/Calc.richness.R")


# 4. Make empty data frame ----

df <- data.frame(File=NULL, Year=NULL, Abundance=NULL, Richness=NULL)


# 5. Batch process to fill data frame ----
for (i in seq_along(file_list)) {
  clean.data(path=file_list[i])
}

clean_list <- list.files("CleanedData", full.names=TRUE)

for (i in seq_along(clean_list)) {
  df <- rbind(df, list(File=clean_list[i],
                       Year=extract.year(path=clean_list[i]),
                       Abundance=calc.abundance(path=clean_list[i]),
                       Richness=calc.richness(path=clean_list[i])))
}

  