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

# using [ ] gives you a single item, but the type = list
my_list[4]
my_list[4] - 3 # so this doesn't work
# to grab the object itself and use it, do this:
my_list[[4]] 
my_list[[4]] - 3
