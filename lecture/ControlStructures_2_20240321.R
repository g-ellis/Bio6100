### For loops ###

# a nice, simple for loop
for (i in 1:5) { # loop through 5 times
  cat("stuck in a loop", "\n") # \n line return (reg ex!)
  cat(3+2, "\n")
  cat(runif(1), "\n")
}

# let's make the difference between var and seq a little more obvious
my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
for (i in 1:length(my_dogs)){
  cat("i=", i, "my_dogs[i] =", my_dogs[i], "\n")
}

# beware! what happens if the vector is empty?
bad_dogs <- NULL
for (i in 1:length(bad_dogs)){ # length of bad_dogs is 0
  cat("i=", i, "bad_dogs[i] =", bad_dogs[i], "\n")
} # this returns 2 lines of results for i=1 and i=0


# a safer alternative to using 1:length() is seq_along()
for (i in seq_along(my_dogs)){
  cat("i=", i, "my_dogs[i] =", my_dogs[i], "\n")
} # works the same as the earlier version

for (i in seq_along(bad_dogs)){
  cat("i=", i, "bad_dogs[i] =", bad_dogs[i], "\n")
} # now has no output

# what about NA instead of NULL?
bad_dogs <- NA
for (i in seq_along(bad_dogs)){
  cat("i=", i, "bad_dogs[i] =", bad_dogs[i], "\n")
} # has one output/runs once


# what if the seq is a constant? use seq_len()
zz <- 5
for (i in seq_len(zz)){
  cat("i=", i, "my_dogs[i] =", my_dogs[i], "\n")
} # works as desired


# don't do things in loops that you don't need to
for (i in 1:length(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i]) # convert to upper case
  cat("i=", i, "my_dogs[i] =", my_dogs[i], "\n")
}
my_dogs <- tolower(my_dogs) # most functions work on vectorized objects and gives the same as the loop
print(my_dogs)


# don't resize objects inside a loop
my_dat <- runif(1)
for (i in 2:10){
  temp <- runif(1)
  my_dat <- c(my_dat, temp)
  cat("loop number =", i, "vector element =", my_dat[i], "\n")
}
# always vectorize when possible
my_dat <- 1:10
for (i in seq_along(my_dat)){
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number =", i, "vector element =", my_dat[i], "\n")
}
# this basically does the same thing as the loop and is more efficient
z <- 1:10
z <- z + z^2
print(z)

# careful about the counter variable and the vector element
z <- c(10, 2, 4)
for (i in seq_along(z)){
  cat("i =", i, "z[i] = ", z[i], "\n")
}
# what is the value of the counter at the end of the loop?
print(i)


# use nect to skip certain elements of a loop
z <- 1:20
# what if we only want to work with odd value in z?
for (i in seq_along(z)){
  if(i %% 2==0) next # if the remainder after dividing by 2=0, skip that counter
  print(i)
}
# might be faster to not put in a loop though
z <- 1:20
zsub <- z[z %% 2!=0] # subsetting to include where the remainder after dividing by 2 doesn't =0
print(zsub)
# subset before the for loop 
for (i in seq_along(zsub)){
  cat("i =", i, "zsub[i]", zsub[i], "\n")
}



## use break to leave a loop early ##

# create a simple random growth population model function
#################################################################
# Function: ran_walk
# packages required: none
# stochastic random walk
# input: times = number of time steps
#         n1 = initial population size (= n[1])
#         lambda = finite rate of increase
#         noise_sd = sd of a normal distribution with mean 0
# output: vector n with population sizes > 0 until extinction, then NA
# -----------------------------------------------------------
ran_walk <- function(times=100, n1=50, lambda=1.00, noise_sd=10){
  n <- rep(NA, times) # create output vector
  n[1] <- n1 # initialize output vector with starting population size
  noise <- rnorm(n=times, mean=0, sd=noise_sd) # create noise vector
  for (i in 1:(times-1)){ # this function calculate what comes next so we need to stop before the last point
    n[i+1] <- lambda*n[i] + noise[i] # population size
    if(n[i+1] <= 0) {
      n[i+1] <- NA 
      cat("population extinction at time", i-1, "\n")
      break}
  }
  return(n)
}
############################################################

# explore parameters in plot function
library(ggplot2)
qplot(x=1:100, y=ran_walk(), geom="line")
qplot(x=1:100, y=ran_walk(noise_sd=0), geom="line", ylim=c(0,75))
qplot(x=1:100, y=ran_walk(noise_sd=0.1), geom="line",ylim=c(0,75))
qplot(x=1:100, y=ran_walk(noise_sd=15), geom="line",ylim=c(0,75))
qplot(x=1:100, y=ran_walk(noise_sd=0, lambda=0.98), geom="line", ylim=c(0,75))
