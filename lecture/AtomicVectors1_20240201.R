# Using the assignment operator
x <- 5 # preferred method
y = 4 # legal, but not really used except in function defaults
y = y + 1.1
print(y)
y <- y + 1.1
print(y)

## naming conventions
z <- 3 # begin with lower case letter
plantHeight <- 10 # optional "camelCaseFormatting"
plant.height <- 4.2 # avoid periods
plant_height <- 3.3 # optimal "snake_case_formatting"
. <- 5.5 # reserve this for a generic temporary variable

## one dimensional atomic vectors
z <- c(3.2, 5, 5, 6) # the combine function c( )
print(z)
typeof(z) # returns data type
is.numeric(z) # returns true/false if the data is numeric or not

# c( ) always flattens to a single atomic vector
z <- c(c(3,4),c(5,6))
print(z)

# character strings with single or double quotes
z <- c("perch","bass",'trout')
print(z) # [1] "perch" "bass"  "trout"
# use both single and double quotes with an internal quote
z <- c("This is only 'one' character string",'a second')
print(z) # [1] "This is only 'one' character string" "a second" 
typeof(z)
is.character(z)

# building logicals
# Boolean, not used with quotes, done in all caps
z <- c(TRUE,TRUE,FALSE)
# avoid abbreviations, although T and F will work
print(z)
typeof(z)
is.logical(z)
is.integer(z)

# vector of character strings
dogs <- c("chow","pug","beagle","greyhound","akita")

# use number in brackets to refer to a single element in a vector. The first item is 1
dogs[1] # picks first element
dogs[5] # picks the fifth element
dogs[6] # returns NA, not an error

# pass the brackets a group of element (aka a vector) to subset the original vector
dogs[c(3,5)] # take just the third and fifth element as a new vector
# this also works if you want multiple copies of the same thing
dogs[c(1,1,1,4)]
my_dogs <- c(1,1,1,4)
dogs[my_dogs]

# grab the entire list/data by leaving the brackets empty, helpful for 2D objects
dogs[]

# pass function to calculate the length of the vector
length(dogs)
dogs[5]
dogs[length(dogs)] # this will grab the last element of the vector

# use negative numbers to exclude elements
dogs[-1] # return everything except for the first element
# its okay to use multiple negations
dogs[c(-2,-4)]
dogs[-c(2,4)]
# but you can't mix positive and negative elements in brackets
dogs[c(1,-5)] # returns an error


## three properties of vectors
# type
z <- c(1.1, 1.3, 3, 4.4)
typeof(z) # gives type
is.numeric(z) # is. gives logical
as.character(z) # as. coerces variable into another type
print(z)
typeof(z) # still returns original type because the as.character did not change the vector itself, could reassign it then it would

# length
length(z)
length(a) # throws error if variable doesn't exist

# names (optional)
z <- runif(5) # make a string of 5 numbers between 0 and 1
print(z)
# names are not initially assigned
names(z) # returns NULL
# add names later after the variable is created, this is now a property of the object, not something separate
names(z) <- c("chow","pug","beagle","greyhound","akita")
print(z)
#      chow       pug    beagle greyhound     akita 
# 0.2593360 0.8086696 0.7181790 0.6096232 0.2985708 
# add names when the variable is built (with or without quotes)
z2 <- c(gold=3.3,silver=10,lead=2)
print(z2)
# reset names
names(z2)=NULL
print(z2)
# names can be added for only a few elements
# names do not have to be distinct but often are
names(z2) <- c("copper","zinc")
print(z2)
# copper   zinc   <NA> 
#   3.3   10.0    2.0 


## special data types
# NA values for missing data
z <- c(3.2,3.3,NA)
typeof(z)
length(z)
typeof(z[3]) # what is the type of the third element, still a double

z1 <- NA
typeof(z1) # different types of NA, this returns "logical"

is.na(z) # logical operator to find missing values
mean(z) # won't work because of NA
!is.na(z) # use ! for NOT missing values (aka things that aren't NA)
mean(!is.na(z))
mean(z[!is.na(z)])
