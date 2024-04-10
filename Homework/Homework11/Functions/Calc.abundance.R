# --------------------------------------
# FUNCTION calc.abundance
# required packages: none
# description: calculating species abundance for a cleaned dataframe
# inputs: cleaned csv
# outputs: count of abundance
########################################
calc.abundance <- function(path=NULL) {
  data <- read.csv(path, header=TRUE)
  return(length(data[,1]))
}

 # end of function calc.abundance
# --------------------------------------
# calc.abundance()

# calc.abundance("CleanedData/new.csv")
