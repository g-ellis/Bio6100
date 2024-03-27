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
  n <- rep(NA, times) # create output vector filled with NA the length of the number of generations
  n[1] <- n1 # initialize output vector with starting population size
  noise <- rnorm(n=times, mean=0, sd=noise_sd) # create noise vector
  for (i in 1:(times-1)){ # this function calculate what comes next so we need to stop before the last point
    n[i+1] <- lambda*n[i] + noise[i] # population size at next step
    if(n[i+1] <= 0) {
      n[i+1] <- NA 
      cat("population extinction at time", i-1, "\n")
      break} # stop the loop if this happens
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
# this is a lot of lines to test our function, how can we make this more efficient?


### using double for loops! ###

m <- matrix(round(runif(20), digits=2), nrow=5)
# loop over rows
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i # take row i and add to the elements in that row the value of i
}
print(m)

# loop over columns  
m <- matrix(round(runif(20), digits=2), nrow=5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j # take column j and add to the elements in that column the value of j
}
print(m)

# let's put these together in a double for loop
m <- matrix(round(runif(20), digits=2), nrow=5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j
  } # end of column loop
} # end of row loop
print(m)


## writing functions for equations and sweeping over parameters
# S = cA^z species area function -- what does this look like?

#####################################################
# function: sac (species area curve)
# creates power function relationship for S and A
# input: A is a vector of island areas
#        c is the intercept constant
#        z is the slope constant
# output: vector of species richness values
# ----------------------------------------------------
sac <- function(A=1:5000, c=0.5, z=0.26) {
  S <- c*(A^z)
  return(S)
}
#####################################################
head(sac())

# let's plot the species area curve results
#####################################################
# function: sac_plot
# creates plot for species area curve
# input: A is a vector of island areas
#        c is the intercept constant
#        z is the slope constant
# output: smoothed curve with parameters in graph
# ----------------------------------------------------
sac_plot <- function(A=1:5000, c=0.5, z=0.26) {
  plot(x=A, y=sac(A,c,z), type="l", 
       xlab = "Island area",
       ylab = "S",
       ylim = c(0,2500))
  mtext(paste("c =", c, "z =", z), cex = 0.7)
}
#####################################################
sac_plot()


# build a grid of plots

# global variables
c_pars <- c(100, 150, 175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

par(mfrow=c(3,4)) # base graphics plotting to have 3 rows and 4 columns
for (i in seq_along(c_pars)) {
  for (j in seq_along(z_pars)) {
    sac_plot(c=c_pars[i], z=z_pars[j])
  }
}

par(mfrow=c(1,1))

## looping with while or repeat ##

# looping with for
cut_point <- 0.1
z <- NA
ran_data <- runif(100)
for (i in seq_along(ran_data)) {
  z <- ran_data
}

# looping with while
z <- NA
cycle_number <- 0
while (is.na(z) | z >= cut_point) {
  z <- runif(1)
  cycle_number <- cycle_number + 1
}



## using expand.grid
expand.grid(c_pars, z_pars) # lists every combination of the elements in the given vectors
expand.grid(c_pars=c_pars, z_pars=z_pars)
str(expand.grid(c_pars=c_pars, z_pars=z_pars)) # it's a data frame!


#############
# function: sa_output
# Summary stats for species-area power function
# input: vector of S values
# output: list with max-min and coefficient of variation

sa_output <- function(S=runif(1:10)) {
  sum_stats <- list(s_gain=max(S)-min(S), s_cv=sd(S)/mean(S))
  return(sum_stats)
}
#############
sa_output()



# building program body
# global variables, can edit these to change all downstream code
area <- 1:50
c_pars <- c(100,150,175)
z_pars <- c(0.10,0.16,0.26,0.3)

# set up model frame
model_frame <- expand.grid(c=c_pars, z=z_pars)
model_frame$s_gain <- NA # add new empty columns that we can add to later
model_frame$s_cv <- NA
print(model_frame)

# cycle through model calculations
for (i in 1:nrow(model_frame)) {
  temp1 <- sac(A=area, c=model_frame[i, 1], z=model_frame[i,2]) # generate S vector
  temp2 <- sa_output(temp1) # calculate output stats
  model_frame[i,c(3,4)] <- temp2 # pass results to the df
}
print(model_frame)



## parameter sweeping redux with ggplot
library(ggplot2)

# global var
area <- 1:5
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

# model frame
model_frame <- expand.grid(c=c_pars, z=z_pars, A=area)
model_frame$S <- NA
print(model_frame)

# loop through parameters to fill SAC function
for (i in 1:length(c_pars)) {
  for (j in 1:length(z_pars)) {
    model_frame[model_frame$c==c_pars[i] & model_frame$z==z_pars[j], "S"] <- sac(A=area, c=c_pars[i], z=z_pars[j])
  }
}
model_frame

# probably an easier way to do it
for (i in 1:nrow(nodel_frame)) {
  model_frame[i, "S"] <- sac(A=model_frame$A[i],
                             c=model_frame$c[i],
                             z=model_frame$z[i])
}
