### dplyr and SQLR ###

library(tidyverse)
library(sqldf) # integration of SQL into R

# load in data
species_clean <- read.csv("/Users/gwen/Documents/site_by_species.csv")
var_clean <- read.csv("/Users/gwen/Documents/site_by_variables.csv")

# let's take a look!
head(species_clean)
head(var_clean)

# start using operations with only 1 option

# subsetting rows
# dplyr: filter()
species <- filter(species_clean, Site < 30)
var <- filter(var_clean, Site < 30)

# SQL: creating a query first where data set, function, and conditions is specified. Query is applied to sqldf()
query="SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE Site <'30'"
# ACTION on what variable, what columns to keep FROM what df, WHERE a certain parameter is met
sqldf(query)

# subset columns
# dplyr: select() column #s or name
edit_species <- species %>% 
  select(Site, Sp1, Sp2, Sp3)

edit_species2 <- species %>%
  select(1, 2, 3, 4) # same as 1:4

# query entire table
query="SELECT * FROM species"
sqldf(query)

# reordering columns with SQL
query = "SELECT Sp1, Sp3, Sp2, Site FROM species"
sqldf(query)


# pivoting tables 
# pivot_longer (gather) lengthens data, decreases number of columns + increases number of rows
species_long <- pivot_longer(edit_species, cols=c(Sp1, Sp2, Sp3), names_to="ID")

# pivot_wider (spread)
species_wide <- pivot_wider(species_long, names_from=ID)


# SQL 
# aggregrate to give counts of Objecttypes
query = "SELECT SUM(Sp1+Sp2+Sp3) 
FROM species_wide 
GROUP BY Site"
sqldf(query)

query = "SELECT SUM(Sp1+Sp2+Sp3) 
AS Occurence  
FROM species_wide 
GROUP BY Site"
# AS similar to mutate()
sqldf(query)

# mutate in SQL - create a column
query = "ALTER TABLE species_wide
ADD new_column VARCHAR"
sqldf(query)


# working with 2 files
# joins: gathering data into usable format. different from binding

# let's get the data into a nicer format
edit_species <- species_clean %>% 
  filter(Site < 30) %>% 
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)

edit_var <- var_clean %>%
  filter(Site < 40) %>%
  select(Site, Longitude.x., Latitude.y., BIO1_Annual_mean_temperature, BIO12_Annual_precipitation)


# Left joins: match rows from b to a and stitch those columns from b
left <- left_join(edit_species, edit_var, by="Site") # we know the sites are the same values in both df so we'll use that for grouping

# Right join: match rows from a to b and stitch those columns from a
right <- right_join(edit_species, edit_var, by="Site")

# Inner join: keeping rows that exist in both a and b
inner <- inner_join(edit_species, edit_var, by="Site")

# full join: opposite of inner, retains all values and rows and fills in NA where needed
full <- full_join(edit_species, edit_var, by="Site")


# SQL method
query="
SELECT BIO1_Annual_mean_temperature,
BIO12_Annual_precipitation
FROM edit_var
INNER JOIN edit_species 
ON edit_var.Site=edit_species.Site"
sqldf(query)
