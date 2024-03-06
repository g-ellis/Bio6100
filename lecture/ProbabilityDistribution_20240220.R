### Probability distributions ###


library(ggplot2)
library(MASS)


######### discrete distributions ########

## Poisson distribution
# Discrete x >= 0
# Random events with a constant random lambda (observations per time or per unit area)
# Parameter: lambda > 0

# "d" function generates probability density
hits <- 0:10
my_vec <- dpois(x=hits, lambda=1) # probability of how many observations will happen based on poisson distribution
qplot(x=hits, y=my_vec, geom="col", color=I("black"), fill=I("goldenrod"))

my_vec <- dpois(x=hits, lambda=2) # events happen twice per sampling
qplot(x=hits, y=my_vec, geom="col", color=I("black"), fill=I("goldenrod"))

hits <- 0:15
my_vec <- dpois(x=hits, lambda=6)
qplot(x=hits, y=my_vec, geom="col", color=I("black"), fill=I("goldenrod"))

# don't have to have an integer value for labmda
hits <- 0:15
my_vec <- dpois(x=hits, lambda=0.2) # smaller lambda, not likely to see many events
qplot(x=hits, y=my_vec, geom="col", color=I("black"), fill=I("goldenrod"))

sum(my_vec) # equals 1, all the probabilities of seeing how many events will total one (total area under the curve)

# for a poisson distribution with lambda=2, what is the probability that a single draw will yield x=0?
dpois(x=0, lambda=2)

# "p" function generates cumulative probability density, aka the lower tail cumulative area under the curve of the distribution
hits <- 0:10
my_vec <- ppois(q=hits, lambda=2)
qplot(x=hits, y=my_vec, geom="col", color=I("black"), fill=I("goldenrod"))

# for a poisson distribution with lambda=2, what is the probability of getting 1 or fewer hits?
ppois(q=1, lambda=2)
# could also get thisthrough dpois
p_0 <- dpois(x=0, lambda=2)
p_1 <- dpois(x=1, lambda=2)
p_0 + p_1

# the "q" function is the inverse of "p"
# what is the number of hits corresponding to 50% of the prob mass?
qpois(p=0.5, lambda=2.5)
qplot(x=0:10, y=dpois(x=0.1, lambda=2.5), geom="col", color=I("black"), fill=I("goldenrod"))
# but the distribution is discrete, so this is not exact
ppois(q=2, lambda = 2.5)

# we can simulate individual values from a poisson
ran_pois <- rpois(n=1000, labmda=2.5)
qplot

# for real or simulated data, we can use the quantile
# function to find the emperical 95% confidence interval on the data
#quantile(x=ran_pois,probs=c(
  
  
  
## Binomial distribution
# size = number of trials
# x = possible outcomes
# outcome x is bounded by 

# use "d" for density function
hits <- 0:10
my_vec <- dbinom(x=hits, size=10, prob=0.5)

# how does this compare to a simulation of "coin tosses?"
my_coins <- rbinom(n=50, size=100,prob=0.5)
#qplot(
#quantile(x



## negative binomial
# what is the distribution of failures?
# How many failures will you get before you get the number of successes you want?

hits <- 0:40
my_vec <- dnbinom(x=hits, size=5, prob=0.5)
qplot(x=hits, y=my_vec, geom="col", color=I("black"), fill=I("goldenrod"))

hits <- 0:40
my_vec <- dnbinom(x=hits, size=5, prob=0.2)
qplot(x=hits, y=my_vec, geom="col", color=I("black"), fill=I("goldenrod"))                  

# geometric series is a special case where N= 1 success
# each bar is a constant fraction 1 - "prob" of the bar before it
myVec <- dnbinom(x=hits, size=1, prob=0.1)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


# alternatively specify mean = mu of distribution and size, 
# the dispersion parameter (small is more dispersed)
# this gives us a poisson with a lambda value that varies
# the dispersion parameter is the shape parameter in the gamma
# as it increases, the distribution has a smaller variance
# just simulate it directly

nbiRan <- rnbinom(n=1000,size=10,mu=5)
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))

nbiRan <- rnbinom(n=1000,size=0.1,mu=5)
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))




########## Continuous distributions ###########


# uniform distribution, parameters are the minumum and maximum
qplot(x=runif(n=100, min=0, max=5), color=I("black"), fill=I("goldenrod")) 
qplot(x=runif(n=1000, min=0, max=5), color=I("black"), fill=I("goldenrod")) 

# normal
my_norm <- rnorm(n=100, mean=100, sd=2) # specify number of samples, mean, and sd
qplot(x=my_norm, color=I("black"), fill=I("goldenrod")) 

my_norm <- rnorm(n=100, mean=2, sd=2)
qplot(x=my_norm, color=I("black"), fill=I("goldenrod")) 
summary(my_norm) # summary mean is close to desired mean
no_zeroes <- my_norm[my_norm>0]
qplot(x=no_zeroes, color=I("black"), fill=I("goldenrod")) # this now looks skewed, not great since a lot of the time in science we don't have zeroes
summary(no_zeroes) # summary mean is now higher than desired mean

# gamma distribution
# generates continuous positive values bounded at zero

my_gamma <- rgamma(n=100, shape=1, scale=10) # with shape=1 is an exponential where the scale equals the mean
qplot(x=my_gamma, color=I("black"), fill=I("goldenrod"))

my_gamma <- rgamma(n=100, shape=0.1, scale=10) # with shape<1 gives a mode very close to zero, small shape and rounds to zero
qplot(x=my_gamma, color=I("black"), fill=I("goldenrod"))

my_gamma <- rgamma(n=100, shape=10, scale=10) # with a larger shape value, it shifts to more of a normal distribution
qplot(x=my_gamma, color=I("black"), fill=I("goldenrod"))

# scale parameter changes the mean and the variance
qplot(rgamma(n=100, shape=2, scale=0.1), color=I("black"), fill=I("goldenrod"))
qplot(rgamma(n=100, shape=2, scale=1), color=I("black"), fill=I("goldenrod"))
qplot(rgamma(n=100, shape=2, scale=10), color=I("black"), fill=I("goldenrod"))
qplot(rgamma(n=100, shape=2, scale=100), color=I("black"), fill=I("goldenrod"))
# mean = shape * scale
# variance = shape * scale^2


## Beta distribution
# bounded at 0 and 1
# similar to a binomial but the result is continuous rather than discrete
# parameter shape1 = similar to number of successes +1
# parameter shape2 = similar to number of failures +1

# shape1=1, shape2=1, basically no data
my_beta <- rbeta(n=1000, shape1=1, shape2=1)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod"))

# shape1=2, shape2=1, "1 coin toss and it was successful"
my_beta <- rbeta(n=1000, shape1=2, shape2=1)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod")) # probability between .5 and 1

# two tosses, 1 head and 1 tail
my_beta <- rbeta(n=1000, shape1=2, shape2=2)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod")) # probability is now centered around .5

# two tosses, both heads
my_beta <- rbeta(n=1000, shape1=3, shape2=1)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod")) # probability is skewed towards 1

# more data
my_beta <- rbeta(n=1000, shape1=20, shape2=20)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod")) # much narrower around .5 since we have more data

my_beta <- rbeta(n=1000, shape1=500, shape2=500)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod")) # very narrow

# shape parameters less thn 1 gives us bimodial distribution
my_beta <- rbeta(n=1000, shape1=0.1, shape2=0.1)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod"))

my_beta <- rbeta(n=1000, shape1=1, shape2=0.1)
qplot(x=my_beta, xlim=c(0,1), color=I("black"), fill=I("goldenrod"))

