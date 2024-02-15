### Matrices, lists, and data frames ###



# a matrix is an atomic vector that's organized into rows and columns

my_vec <- 1:12

m <- matrix(data=my_vec, ncol=12, nrow=4) # what data are you using and how many rows is it. Based on how many elements are in the data, it will dimensionalize for you, goes by columns first
print(m)

m <- matrix(data=my_vec, ncol=3, byrow=TRUE) # by adding byrow argument, it will fill slots by row
print(m)

my_m_data <- c(1,2,3,
               4,5,6,
               7,8,9)
my_manual_m <- matrix(data=my_m_data, nrow=3, byrow=TRUE)
print(my_manual_m)


## Lists

# lists are atomic vectors but each element can hold things of different types and sizes
my_list <- list(1:10, matrix(1:8,nrow=4,byrow=TRUE), letters[1:3],pi)
str(my_list)
print(my_list)
typeof(my_list)

# using [ ] gives you a single item, but the type = list, so you can't index it
my_list[4]
my_list[4] - 3 # so this doesn't work, returns an error
# to grab the element in the list itself and use it, use double brackets [[ ]]
my_list[[4]] 
my_list[[4]] - 3

# one way to think of lists, is that if a list has 10 elements, it is like a train with 10 cars
# [[5]] gives to the contents of car 5
# [5] creates a train with just car 5
## [c(4,5,6)] makes another little train with cars 4, 5, and 6

my_list[[2]] # this second element is a matrix
my_list[[2]][4,1] # take the second element (a matrix) and take the element at row 4 column 1 of the matrix. By using the double brackets, you can treat it as a you normally would

# can name components of a list in the same way you would do for an atomic vector
my_list2 <- list(Tester=FALSE, littleM = matrix(1:9,nrow=3)) # can name components using name=component
# $Tester
# [1] FALSE
# 
# $littleM
# [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

# named elements can be called with $
my_list2$littleM # show whole matrix
my_list2$littleM[2,3] # in my_list2, take the littleM component and its element in the 2nd row 3rd column
my_list2$littleM[2,] # show second row
my_list2$littleM[2] # gives the second item of the matrix (organized by column by default)

# the unlist() function strings everything back into a single atomic vector, coercion is used if there are mixed data types
unrolled <- unlist(my_list2)
print(unrolled)

# the most common use of a list is as the output from a linear model
library(ggplot2)
y_var <- runif(10)
x_var <- runif(10)
my_model <- lm(y_var~x_var) # this is making a list
qplot(x=x_var, y=y_var)
print(my_model)
print(summary(my_model)) # summary() will give more detail about the model, but how do we put this into a pipeline?

str(summary(my_model)) # what is the structure of the summary of the model, it's a list! and it's a lot
summary(my_model)$coefficients # the coefficients element of the summary list is what I want, with the matrix rows and columns labeled
summary(my_model)$coefficients["x_var","Pr(>|t|)"] #I want the value in the x_var row in the Pr(>|t|) column, this is the test statistic for the null hypothesis 
summary(my_model)$coefficients[2,4] # could do it this way if you remember where the value is

# or use unlist() instead
u <- unlist(summary(my_model))
print(u) # now a very long atomic vector
slope <- u$coefficients2 # find the values you want and use the element names to call it
pval <- u$coefficients8


## data frames 
# a data frame is a list of equal-length atomic vectors, each of which is a column

# let's make a data frame!
varA <- 1:12 # unique identifier for each row (like sample ID)
varB <- rep(c("Con","LowN","HighN"), each=4) # treatment groups
varC <- runif(12) # make some data

df <- data.frame(varA, varB, varC) # make a data frame! will return an error if the vectors aren't all the same length
print(df)
str(df)
head(df)
View(df)

# How do we add more data to the df?
# add another row with rbind. make sure you add a list (not an atomic vector!), with each item corresponding to a column
# new_data <- data.frame(list(varA=13, varB="HighN", varC=runif(1)))
new_data <- list(varA=13, varB="HighN", varC=runif(1)) # make sure you're using the original df column names
# list(varA=(length(df$varA)+1), varB=sample(df$varB, size=1), varC=runif(1))
print(new_data)
str(new_data)

df <- rbind(df, new_data) # use rbind() to add the new data to the end of the df
str(df)
tail(df)

# adding columns is a little easier (just an atomic vector of one type)
varD <- runif(13)
df <- cbind(df, varD) # cbind()
head(df)


# create a matrix and data frame with the same structures
zMat <- matrix(data=1:30,ncol=3,byrow=TRUE)
zdf <- as.data.frame(zMat)
str(zMat) # an atomic vector with 2 dimensions
str(zdf) # 10 observations of 3 variables
head(zMat)
head(zdf) # automatic variable names

# element referencing is the same in both formats
zMat[3,3]
zdf[3,3]
zMat[3,]
zdf[3,] # note that this brings the column names with it
zMat[,3]
zdf[,3]
zdf$V3 # we can do this with data frames though
# what happens if we reference only one dimension?
zMat[2] # takes the second element in the atomic vector (doesn't care that we filled matrix by row)
zdf[2] # takes the second atomic vector/column from list
zdf["V2"] # does the same as above
zdf$V2 # and the same again

# eliminating missing values
# use complete.cases() with atomic vectors
print(zdf)
zdf[2,2]<- NA
complete.cases(zdf$V2) # returns logicals based on if there are actually values in each element position
zdf$V2[complete.cases(zdf$V2)] # will keep only the values in the df that returned true from complete.cases
which(!complete.cases(zdf$V2)) # find NA slots/row numbers

# use with a matrix
m <- matrix(1:20,nrow=5)
m[1,1] <- NA
m[5,4] <- NA
print(m)

m[complete.cases(m),] # take the matrix and subset to keep only the rows with no NA and all the columns

# complete.cases for only certain columns
m[complete.cases(m[,c(1,2)]),] # look at only the 1st and second columns of the matrix to perform complete.cases on for which rows to keep (eliminate rows with NA in column 1 or 2) 
m[complete.cases(m[,c(2,3)]),] # no dropped rows
m[complete.cases(m[,c(3,4)]),] # drops row 5
m[complete.cases(m[,c(1,4)]),] # drops row 1 and 5


## Techniques for assignments and subsetting matrices and dfs
m <- matrix(1:12, nrow=3)
# assign matrix row and column names with dimnames()
# needs a list with 2 things: the row names and the column names
dimnames(m) <- list(paste("Species",
                          LETTERS[1:nrow(m)], # Species with a letter tacked on up to the number of rows
                          sep=""),
                    paste("Site",1:ncol(m),sep="")) # Site with a number tacked on up to the number of columns
# can now use the dimension names to subset
m["SpeciesA","Site1"]
m[c("SpeciesA", "SpeciesB"), c("Site3", "Site4")]

# use logicals for more complex subsetting

# select all columns for which the total are >15
colSums(m)
colSums(m) > 15 # returns logicals for if the sum of each column is greater than 15
m[,colSums(m)>15] # keep all the rows, but only keep the columns where the sum is greater than 15

# select all the rows for which the row total is = 22
m[rowSums(m)==22,] # keeps only the first row
m[rowSums(m)!=22,] # don't keep the first row

# choose all rows for which numbers for site1 are less than 3 AND choose all columns for which the numbers for speciesA are less than 5
m[,"Site1"] <3 # what rows have less than 3 for Site1
m["SpeciesA",] <5 # what columns have less than 5 for SpeciesA
m[m[,"Site1"] <3, m["SpeciesA",] <5]

# caution! simple subsetting to a vector changes the data type
z <- m[1,]
print(z)
str(z) # now only one dimension, a vector

z2 <- m[1, ,drop=FALSE] # maintains dimensionality
print(z2)
str(z2)

# caution! always use both dimensions when subsetting, otherwise you'll just get a single element
m2 <- matrix(data=runif(9), nrow=3)
print(m2)
m2[,2]
m2[2,]
m2[2]
m2[2,1]

# also use logicals for assigning values
m2[m2>0.6] <- NA
print(m2)
