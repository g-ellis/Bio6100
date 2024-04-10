# --------------------------------------
# FUNCTION extract.year
# required packages: tidyverse, stringr
# description:
# inputs: x which is a cleaned data frame
# outputs:
########################################
extract.year <- function(path=NULL) {
  year <- str_extract(path, pattern="20\\d{2}")
  return(year)
}



# end of function extract.year
# --------------------------------------
# extract.year()

#extract.year(file_list[1])
