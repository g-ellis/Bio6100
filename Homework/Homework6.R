#### Homework 6 ####

library(ggplot2) # for graphics
library(MASS) # for maximum likelihood estimation
library(dplyr)


data <- read.csv("___.csv", sep=",", comment.char='#')
str(data) # structure of df
data <- na.omit(data) # remove any rows with NAs in the df
data$newname <- z$oldname # adding a new column that is the same content as an existing column