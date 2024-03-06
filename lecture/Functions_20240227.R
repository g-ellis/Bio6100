#### Functions #### 

library(ggplot2)


sum(3,2) # a "prefix" function
3+2 # an operator, but it is actually a function
`+`(3,2) # the operator is an "infix" function

y <- 3 # this is even a function
print(y)
`<-`(y,3) # in infix form

# to see contents of a function, print it
print(read.table)
read.table # can also see contents this way, no parantheses with function

sd(c(3,2)) # calls function with parameters
sd() # call function with default values, doesn't work in this case because there are no default values for this function



### write a function for HWE ###

#########################################################
# function: hwe
# calculates Hardy-Weinberg equilibrium values
# input: an allele freq p (0,1)
# output: p and the freq of the 3 genotypes AA, AB, and BB
# ---------------------------------------------------------
hwe <- function(p=runif(1)) {
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA, AB=f_AB, BB=f_BB), digits=3)
  return(vec_out)
}
#########################################################

hwe() # try with just the default values
hwe(p=0.5) # pass value to the input parameter
print(p) # cannot print p, it is local to just the function


# write functions with multiple return values

#########################################################
# function: hwe2
# calculates Hardy-Weinberg equilibrium values
# input: an allele freq p (0,1)
# output: p and the freq of the 3 genotypes AA, AB, and BB
# ---------------------------------------------------------
hwe2 <- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    return("Function not valid: p must be >= 0 and <= 1")
  } # end of if statement
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA, AB=f_AB, BB=f_BB), digits=3)
  return(vec_out)
} # end of HWE function
#########################################################

# when the if statement is not met, just skips over what is in { }

hwe2() # run with default
hwe2(p=2) # returns the message from the if statement
z <- hwe2(2) # this hides the message in z because the function itself still executes fine


# how do we implement an actual error? Use stop() instead of return()

#########################################################
# function: hwe3
# calculates Hardy-Weinberg equilibrium values
# input: an allele freq p (0,1)
# output: p and the freq of the 3 genotypes AA, AB, and BB
# ---------------------------------------------------------
hwe3 <- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    stop("Function not valid: p must be >= 0 and <= 1")
  } # end of if statement
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA=f_AA, AB=f_AB, BB=f_BB), digits=3)
  return(vec_out)
} # end of HWE function
#########################################################

hwe3(2) # this gives us an error now!
x <- hwe3(2) 




# explore scoping and local variables
##################################
my_func <- function(a=3, b=4) {
  z <- a + b
  return(z)
}
##################################
my_func() # works fine


##################################
my_func_bad <- function(a=3) {
  z <- a + b
  return(z)
}
##################################
my_func_bad() # returns an error, because b was never defined in the function or in the global environment
b <- 100
my_func_bad() # this will work now because we defined b in the global environment, but this probably isn't a good idea to do


##################################
my_func_ok <- function(a=3) {
  b <- 1000
  z <- a + b
  return(z)
}
##################################
my_func_ok()




#########################################################
# function: fit_linear
# fits a single linear regression line
# inputs: numeric vector of predictor(x) and response(y)
# outputs: slope and p-value
#------------------------------------------------
fit_linear <- function(x=runif(20), y=runif(20)) {
  my_model <- lm(y~x)
  my_out <- c(slope=summary(my_model)$coefficients[2,1],
              pval=summary(my_model)$coefficients[2,4])
 # plot(x=x, y=y) # quick plot to check output
  z <- ggplot2::qplot(x=x, y=y) # package:: to use functions from that package
  plot(z)
  return(my_out)
}
#########################################################
fit_linear()



#########################################################
# function: fit_linear2
# fits a single linear regression line
# inputs: numeric vector of predictor(x) and response(y)
# outputs: slope and p-value
#------------------------------------------------
fit_linear2 <- function(p=NULL) {
  if(is.null(p)) {
    p <- list(x=runif(20), y=runif(20))
  }
  my_model <- lm(p$y~p$x)
  my_out <- c(slope=summary(my_model)$coefficients[2,1],
              pval=summary(my_model)$coefficients[2,4])
  z <- ggplot2::qplot(x=p$x, y=p$y) 
  plot(z)
  return(my_out)
}
#########################################################
fit_linear2() # using default
pars <- list(x=1:10, y=runif(10))
fit_linear2(pars)

z <- c(runif(99), NA)
mean(z) # doesn't work because of NA, mean function doesn't default remove it
mean(z, na.rm=TRUE)
mean(z, na.rm=TRUE, trim=0.05) # adding trim parameter to remove outlier data points, 5% of tails
pars <- list(x=z, na.rm=TRUE, trim=0.05)
do.call(mean,pars) # works for a function and a list of parameters
