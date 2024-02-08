### Atomic vectors II ###

## Creating empty vectors
# to create an empty vector, specify mode/type and length
z <- vector(mode="numeric",length=0)
print(z)
z <- c(z,5) # concatenate 5 to our vector z. This is called dynamic sizing. This slow, avoid it
print(z)

# A better way is to create a vector of whatever length you need filled with 0s
z <- rep(0,100) # has 100 0s in a numeric vector
length(z) #100
head(z)
tail(z)
z[c(50,51,52)] # return 50th, 51st, and 52nd element

# the best way to create a vector of whatever length filled with NAs
z <- rep(NA,100)
head(z)
typeof(z) # logical, starting from the bottom of the type hierarchy

# take advantage of coercion to change the type of the new vector
z[1] <- "Washington"
head(z) # [1] "Washington" NA           NA           NA           NA           NA    
typeof(z) # character

my_vector <- runif(100)
my_names <- paste("Species", seq(1:length(my_vector)),sep="") # paste function puts things together in a character string
my_names2 <- paste("Genus",seq(1:length(my_vector)),
                   "species",
                   sep="")
head(my_names)
names(my_vector) <- my_names
head(my_vector)
# Species1   Species2   Species3   Species4   Species5   Species6 
# 0.04257493 0.61265440 0.01996978 0.21660422 0.38640091 0.13863741 
str(my_vector)

# rep for repeating elements
rep(0.5,6) # give the element you want and how many times you want it repeated
rep(x=0.5,times=6) # using the argument names is preferred
rep(times=6,x=0.5) # when using argument names the order doesn't matter
my_vec <- c(1,2,3)
rep(x=my_vec,times=2) # applies to whole vectors, repeat the elements of the given vector twice
rep(x=my_vec,each=2) # repeat each element individually. This is the difference between the arguments each and times
rep(x=my_vec,times=my_vec) # vector to vector possible argument, so imagine them stacking for what is happening to each element 1 2 2 3 3 3 
rep(x=my_vec,each=my_vec) # R is only taking the first element of the each vector to apply since this argument only works with a single number

# use seq to create regular sequences
seq(from=2,to=4) 
2:4 # shortcut for saying the above
seq(from=2,to=4,by=0.5) # go from 2 to 4 and step by intervals of 0.5 (default is 1)
z <- seq(from=2,to=4,length=7) # if you don't want to say the actual intervals and do the math, you can define how many values you want with the length argument
print(z)
my_vec <- 1:length(z) # if you don't know the length that you want but know the length of the other vector it needs to match, you can do this. Can be slow though
print(my_vec)
seq_along(my_vec) # a faster way than doing the above, argument is looking for a vector
seq_len(5) # this is also a way to do 1:5, can only be given a number



# using rnorm and runif to create vectors of random variables
set.seed(2400)
runif(5) # 5 random numbers between 0 and 1
runif(n=3,min=100,max=101) # 3 random numbers between 100 and 101
rnorm(6) # 6 random normal values with a mean of 0 and a standard deviation of 1
rnorm(n=5,mean=100,sd=30) # 5 numbers with a mean of 100 and a sd of 30

# explore distributions by sampling and plotting
library(ggplot2)
z <- runif(1000) # default uniform 
qplot(x=z)
z <- rnorm(1000) # default normal
qplot(x=z)


# using sample to draw random values from an existing vector
long_vec <- seq_len(10)
typeof(long_vec) # integer
str(long_vec)

sample(x=long_vec) # without any other arguments, it returns the elements of the vector in a random order
sample(x=long_vec, size=3) # specifying a size pulls that number of elements - no numbers will repeat unless the number is repeated in the vector
sample(x=long_vec, size=11) # this will return an error since the vector length=10
sample(x=long_vec, size=16, replace=TRUE) # can now generate duplicate elements (default is false)
# by default, sampling pulls each element equally, but what if you want some elements more than others?
my_weights <- c(rep(20,5),rep(100,5)) # vector with 20 repeated 5 times and 100 repeated 5 times
print(my_weights)
my_weights <- c(rep(c(20,100),each=5)) # could also make the vector this way
print(my_weights)
sample(x=long_vec, replace=TRUE, prob=my_weights) # by giving the prob argument a vector with the same number elements, you can add weights to the random sampling
mean(sample(x=long_vec, size=100, replace=TRUE)) # Without weights, the mean is close to 5
mean(sample(x=long_vec, size=100, replace=TRUE, prob=my_weights)) # now the mean is greater than 5


## Techniques for subsetting atomic vectors
z <- c(3.1,9.2,1.3,0.4,7.5)

# positive index values
z[c(2,3)]

# negative index values to exclude elements
z[-c(2,3)]

# create a vector of elements based on given conditions, not on the basis of location in vector
z[z<3]
# the way this works is first coercing to a string of logical elements
tester <- z<3
print(tester)
z[tester] # and then those logical elements are used to subset the vector

# can also use which() to find specific elements
which(z<3) # returns the positions that meet the criteria
z[which(z<3)] # this will give the elements that fit the criteria

z[-(length(z):(length(z)-2))] # go from end of vector and go down 2 elements, but then exclude those. Therefore, this returns just the first two elements of z/ remove the last 3 elements

# can also subset using named vector elements
names(z) <- letters[1:5] # add names to vector z, letters is a built in vector of a-z (LETTERS is A-Z)
z[c("b","c")]


## Relational operators in R
# < less than
# > greater than
# <= less than or equal to
# >= greater than or equal to
# == equal to

# ! not
# & and (vector)
## | or (vector)
# xor(x,y) either x or y needs to be true

x <- 1:5
y <- c(1:3,7,7)
x == 2 # returns logical for each element
x != 2 # which elements do not equal 2?
x == 1 & y == 7 # is there an element in the same position in each vector where it equals 1 in x and 7 in y
# if one vector is longer than the other, it will start recycling elements from the shorter vector for comparison
x == 1 | y == 7 # is there a position where it's 1 in x OR 7 in y
x == 3 | y == 3 # [1] FALSE FALSE  TRUE FALSE FALSE
xor(x==3, y==3) # [1] FALSE FALSE FALSE FALSE FALSE now false in the third position because they're both 3, not just one of them


## subscripting with missing values
set.seed(90)
z <- runif(10)
print(z)

z < 0.5 # string of logicals
z[z<0.5] # use logicals as an index call
which(z<0.5) # positions for which the condition is true
z[which(z<0.5)] # does same as the above

zD <- c(z,NA,NA) # add missing values
zD[zD<0.5] # NA values are still carried along
zD[which(zD<0.5)] # using which() will not include the NA values
