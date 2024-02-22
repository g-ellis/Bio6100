#### Data Curation ####

my_data <- read.table("lecture/example_data.csv", header=TRUE,sep=",", comment.char="#") # can use read.table() to load in data, but need to give sep argument since its a more general function

csv <- read.csv("lecture/example_data.csv", header=TRUE, comment.char="#") # can also use read.csv() and not use sep argument since we know this is a CSV

str(my_data) # inspect the object

# now add a column
my_data$newVar <- runif(4) # make sure the new vector is the right length
head(my_data)

# exporting/saving a data file
write.table(x=my_data, file="lecture/save_mydata.csv", row.names=FALSE, sep=",") # use write.table(), however this isn't always the best way to save objects since these can just accumulate outside of R, write.csv() also exists

# saving objects when only working in R, more reproducible
saveRDS(my_data, file="lecture/my_data.RDS")
# to save multiple objects within a single line, make those objects into a list and pass that to the function

data_in <- readRDS("lecture/my_data.RDS") # now load the R object back in with readRDS()
