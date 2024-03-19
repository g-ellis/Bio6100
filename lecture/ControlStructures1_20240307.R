
## Control Structures 1 ##
##########################

## set operations ##

# boolean algebra on sets of atomic vectors
a <- 1:7
b <- 5:10

union(a,b) # returns all of the contents, no repeats
c(a,b) # just puts the two vectors together
unique(c(a,b)) # what are the unique elements of the vector?

intersect(a,b) # what is the intersection between two vectors? What elements do they have in common?

setdiff(a,b) # setdiff() to get distinct elements in a 
setdiff(b,a) # distinct elements of b

setequal(a,b) # setequal() to check for identical vectors/items

# more generally compare any two objects
z <- matrix(1:12, nrow=4, byrow=TRUE)
z1 <- matrix(1:12, nrow=4, byrow=FALSE)

z==z1 # compare element by element in the matrices
identical(z,z1) # identical() compare the entire matrices to each other, returns just one value (TRUE/FALSE)
z1 <- z
identical(z,z1) # TRUE

# most useful for if statements is %in% or is.element()
d <-12
d %in% union(a,b) # is d present in the union vector of a and b? infix version
is.element(d, union(a,b)) # same as above, function version

d <- c(10,12)
d %in% union(a,b) # go by each element of d for presence in union(a,b)
d %in% a



## if statements ##
# general format: if (condition) {expression1}

x <- 5
if (x==5) {print("met the condition")} # will print
x <- 6
if (x==5) {print("met the condition")} # won't do anything
x <- 5
if (x==5) {print("met the condition")
  print("do something further")
  }

x <- 4
if (x==3|5) {print("met the condition") # don't do this! Putting the | there tells R that 5=5 and this is TRUE
  print("do something further")
}

x <- 4
if (x==3|x==5) {print("met .the condition") # the proper way to do a compound statement
  print("do something further")}
if (x %in% c(3,5)) {print("met the condition") # maybe an easier way to write the above
  print("do something further")}

x <- 4
if (x %in% c(3,5)) {print("met the condition") 
  print("do something further")
} else print("condition not met") # adding a fork in the road

x <- 4
if (x %in% c(3,5)) {print("met the condition") 
  print("do something further")
} else if (x==6) {print("found a 6!") # else if for more options
  } else print("not 3, 5, or 6")

z <- signif(runif(1), digits=2)
print(z)
z > 0.5
if (z>0.5) cat(z, "is a bigger than average number", "\n")

if (z > 0.5) {cat(z, "is a bigger than average number", "\n")
  } else if (z > 0.8) {cat(z, "is a large number", "\n")
    } else {cat(z, "is a number of typical size", "\n")
    cat("z^2 =", z^2, "\n")}

# if statements require a single number, if you give R a vector, it will return an error
z <- 1:10
if (z > 7) print(z) # returns error
if (z[1] > 7) print(z)
if (z[9] > 7) print(z) # prints the whole vector
print(z[z>7]) # subsetting might just be easier



## ifelse ##
# format: ifelse(test, when true, when false)
# helpful for filling vectors

# example: suppose we have an insect population where females lay on average 10.2 eggs following a Poisson distribution with lambda=10.2. However, there is a 35% chance of parasitism in which case no eggs are laid. (zero inflated Poisson)
tester <- runif(1000) # start w/ random uniform elements
eggs <- ifelse(tester > 0.35, rpois(n=1000, lambda=10.2), 0) # if the number from tester is greater than 0.35, then draw from a poisson distribution, otherwise generate a 0
hist(eggs)


pvals <- runif(1000)
z <- ifelse(pvals <= 0.025, "lower tail", "non-significant")
z[1:50]
z[pvals >= 0.975] <- "upper tail"
table(z) # tallying up counts

# another way to write the above
z1 <- rep("non significant", 1000)
z1[pvals <= 0.025] <- "lower tail"
z1[pvals >= 0.975] <- "upper tail"
table(z1)