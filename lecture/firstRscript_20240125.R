# The first comment is to usually explain what the script is doing
# Be expansive and describe it in great detail. This may seem trivial, but will become increasingly important as you create complex programs

# This one: a simple script to examine the distributio of the product of two uniform variables
# 2024-01-25
# Gwen



### Preliminaries ###
library(ggplot2)
set.seed(100) 

# use this to set the random number seed from a character string, instead of a random number
library(TeachingDemos)
char2seed("green tea")
char2seed("green tea", set=FALSE) #this just prints the seed number, doesn't generate and store


### Global variables ###
nRep <- 10000

# Create or read in data
ranVar1 <- rnorm(nRep)
# print(ranVar1)
head(ranVar1)
tail(ranVar1)
ranVar2 <- rnorm(nRep)

# visualize data
qplot(x=ranVar1)

# create product vector
ranProd <- ranVar1*ranVar2
length(ranProd)
str(ranProd)
head(ranProd)
