### dplyr ###

library(tidyverse)

# core verbs/functions to use:
# filter
# arrange
# select
# summarize and group_by
# mutate


# load in a base R dataset
data("starwars") 
class (starwars) # what is the structure?
# [1] "tbl_df"     "tbl"        "data.frame"
# tibbles (tbl) do less as a trade-off to make code similar and less prone to crashing

glimpse(starwars) # get a small preview of the df (similar to head())


# cleaning our data

# complete.cases() is not part of dyplr but is useful
starwars_clean <- starwars[complete.cases(starwars[,1:10]),] # what rows have complete info in the first 10 columns?

# check for NAs
is.na(starwars_clean[,1]) # useful for only a few observations since it returns a list of logicals
anyNA(starwars_clean[,1:10]) # returns a single TRUE/FALSE


# filter function: subset based on values
# uses all the normal and logical operators
# automatically excludes NAs

filter(starwars_clean, gender=="masculine" & height < 180)
filter(starwars_clean, gender=="masculine" & height < 180, height >100) # can add bounds this way

# %in% can also be used to filter
filter(starwars_clean, eye_color %in% c("blue", "brown"))


# arrange() reorders rows
arrange(starwars_clean, by=height) # default is in ascending order
arrange(starwars_clean, by=desc(height)) # change to descending order
arrange(starwars_clean, by=height, desc(mass)) # consider mass as the second variable to order by
starwars1 <- arrange(starwars, by=height) # missing values will be stacked at the bottom of the df


# select() choose variables by their names
# all of these do the same thing, subset the df
starwars_clean[,1:10] # first 10 columns
select(starwars_clean, 1:10) # based on numbers
select(starwars_clean, name:species) # based on names
select(starwars_clean, -(films:starships)) # exclude last columns
select(starwars_clean, homeworld, name, gender, species) # rearrange and subset
select(starwars_clean, homeworld, name, gender, species, everything()) # use everything() to get the rest
select(starwars_clean, contains("color")) # only column names that have "color" in it
# ends_with, start_with, matches (reg ex), num_range can be used in a similar way
select(starwars_clean, haircolor=hair_color) # can use it to rename variables (new=old), but will only return that single column

# rename()
rename(starwars_clean, haircolor=hair_color) # keeps all the variables


# mutate() add new variables based on existing values in the df
# create a new column with height/mass
x <- mutate(starwars_clean, ratio=height/mass) # using arithmetic operators
starwars_lb <- mutate(starwars_clean, mass_lb=mass*2.2) # convert kg to lb
select(starwars_lb, 1:3, mass_lb, everything()) # take starwars_lb df, then the first three columns, then the new mass_lb column, then everything else

transmute(starwars_clean, mass_lb=mass*2.2) # keeps just the single new column instead of adding it to the existing df.
transmute(starwars_clean, mass, mass_lb=mass*2.2) #  Can also mention the variables you want in it


# summarize() and group_by(), collapsing many values to a single summary
summarize(starwars_clean, meanHeight=mean(height)) # returns single summary statistic
summarize(starwars, meightHeight=mean(height)) # doesn't work when NAs are present
summarize(starwars, meightHeight=mean(height, na.rm=TRUE)) # add na.rm argument within the function to exclude NAs in calculation
summarize(starwars_clean, meightHeight=mean(height), number=n()) # n() to return how many rows the function applies to

# using group_by() with summarize()
starwars_genders <- group_by(starwars, gender)
summarize(starwars_genders, meanHeight=mean(height, na.rm=TRUE), number=n())


# pipe statements %>% 
# used to create a sequence of actions by passing intermediate results onto the next functions ("and then")
# formatting: space before %>% and new line after it

starwars_clean %>% 
  group_by(gender) %>% 
  summarize(meanheight=mean(height), number=n()) # same as above!

# use the case_when() when you have multiple ifelse statements
starwars_clean %>% 
  mutate(sp=case_when(species=="Human" ~ "Human", TRUE ~ "Non-human")) %>% # subsetting when species is human or non-human
  select(name, sp, everything())

test <- starwars_clean %>% 
  group_by(films) %>% 
  mutate(sp=case_when(species=="Human" ~ "Human", TRUE ~ "Non-Human"), status=case_when(str_detect(films, "A New Hope") ~ "OG", TRUE ~ "Later")) %>% # if species is human, sp=human, if species is anything else sp=non-human. when the film matches the character string "A new hope" then status=OG, any other than character string status=Later, This adds two new columns
  select(name, sp, status, everything()) %>% 
  arrange(status) # put the Later films first (alphabetical)


# converting datasets from long to wide format and vice versa
glimpse(starwars_clean)

wide_sw <- starwars_clean %>% 
  select(name, sex, height) %>% 
  pivot_wider(names_from=sex, values_from=height, values_fill=NA) # now giving height for each individual and variables are male and female

pivot_sw <- starwars %>% 
  select(name, homeworld) %>%
  group_by(homeworld) %>% 
  mutate(rn=row_number()) %>% 
  ungroup() %>% 
  pivot_wider(names_from=homeworld, values_from=name, values_fill=NA) %>% 
  select(-rn) # giving names of each character from the different homeworlds 

# make dataset longer
glimpse(wide_sw)
wide_sw %>% 
  pivot_longer(cols=male:female, names_to="sex", values_to="height", values_drop_na=TRUE) # taking columns names to new observation of variable sex and fill in value from original df to height variable
