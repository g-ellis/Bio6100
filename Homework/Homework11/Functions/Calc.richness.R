# --------------------------------------
# FUNCTION calc.richness
# required packages: none
# description: calculates unique number of species 
# inputs: cleaned csv
# outputs: count of unique species
########################################
calc.richness <- function(path=NULL){
  df <- read.csv(path, header=TRUE)
  return(length(unique(df$scientificName)))
}

# end of function calc.richness
# --------------------------------------
# calc.richness()

#calc.richness("CleanedData/new.csv")

