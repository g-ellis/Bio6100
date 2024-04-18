## Advanced function programming

z <- 1:10

# built-in functions
mean(z)

z + 100
'+'(z,100) # same as above

# user-defined functions

##############################
# function: my_fun
# description: calculate maximum of sin(x) + x
# input: a value or vector of x
# output: a single number
#-----------------------------

my_fun <- function(x=runif(5)) {
  z <- max(sin(x) + x)
  return(z)
}
###########################
my_fun()


# anonymous functions
# unnamed, used for simple calculations, usually has a single input called x

function(x) x + 3
# provide an input
(function(x) x + 3) (10) # wrap function in parentheses and then pass input


## First task: apply a function to each row (or column) of a matrix
m <- matrix(1:20, nrow=5, byrow=TRUE)
print(m)

# for loop solution
output <- vector("list",nrow(m)) # make a vector of lists that has the same number of slots as rows in m
str(output)
for (i in seq_len(nrow(m))) {
  output[i] <- my_fun(m[i,])
}
print(output)


# apply() solution
# apply(X, MARGIN, FUN, ...)
# X = vector or an array (in this case a matrix)
# MARGIN, 1=row, 2=column is it operating on rows or columns? c(1,2) is rows and columns
# FUN=function or what is being done

row_out <- apply(X=m,
                 MARGIN=1, # operate on columns
                 FUN=my_fun) # using this defined function
print(row_out) # returns a vector

apply(m, 2, my_fun) # do the same thing, but with columns

apply(m, c(1,2), my_fun) # apply to individual elements in matrix, returns a matrix


# apply with anonymous function, does the same as above
apply(m, 1, function(x) max(sin(x)+x))


# what happens to output of variable length?
# first, mod to reshuffle matrix using sample
apply(m,1,sample) # operating on rows, but output comes as reshuffled columns since this is the way matrices are constructed in R

t(apply(m,1,sample)) # transpose so rows and columns are flipped ans look the way we expected

# take a random number of elements from each row and reshuffle them
apply(m,1, function(x) x[sample(seq_along(x), size=sample(seq_along(x), size=1))]) # returns a list



## Second task: apply a function to every columnd of a data frame

df <- data.frame(x=runif(20), y=runif(20), z=runif(20))

# for loop solution
output <- vector("list", ncol(df))
for (i in seq_len(ncol(df))) {
  output[i] <- sd(df[,i])/mean(df[,i])
}
print(output)

# lapply() solution
# can't use apply since it only works on matrices, lapply works on lists (like data frames)
# lapply(X, FUN, ...)
# X is a vector (atomic or list)
# FUN in a function that is applied to each element of the list
# output is always a list!

summary_out <- lapply(X=df, 
                      FUN=function(x) sd(x)/mean(x))
print(summary_out) # returns a list, with named columns

# sapply tries to simplify output to a vector or matrix
# vapply requires specified output formats


## Challenge: what if not all data frame columns are of same type?
treatment <- rep(c("Control", "Treatment"), each=(nrow(df)/2))
df2 <- cbind(treatment, df)                

# for loop solution
output2 <- vector("list", ncol(df2))
for (i in seq_len(ncol(df2))) {
  if(is.numeric(df2[,i])) 
  output2[i] <- sd(df2[,i])/mean(df2[,i])
}
print(output2)

# lapply solution
lapply(df2, function(x) if(is.numeric(x)) sd(x)/mean(x))
unlist(lapply(df2, function(x) if(is.numeric(x)) sd(x)/mean(x))) # now a vector (does not include null items)



## Third task: split/apply/combine for groups in a data frame

# for loop solution
g <- unique(df2$treatment)
out_g <- vector("list", length(g))
names(out_g) <- g
for (i in seq_along(g)) {
  df_sub <- df2[df2$treatment==g[i],]
  out_g[i] <- sd(df_sub$x)/mean(df_sub$x)
}
print(out_g)

# tapply solution
# tapply(X, INDEX, FUN, ...)
# X is a vector
# INDEX is a list of factors (or character strings)
# FUN is the function to apply to each element of the subsetted groups

z <- tapply(X=df2$x,
       INDEX=df2$treatment,
       FUN= function(x) sd(x)/mean(x))
print(z)
