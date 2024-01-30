## -------------------------------------------------------------------------------------------------
# first chunk of code in rmd file
print(pi)
pi + 3



## ----eval=TRUE, echo=TRUE-------------------------------------------------------------------------
# use comments extensively in all of your coding!
Pred <- seq(1,10) # make a vector of integers from 1 to 10
Res <- runif(10) # generate 10 draws from a random uniform (0,1) distribution

# print the random numbers
print(Res)

# plot the graph
plot(x=Pred,y=Res,type="b")


