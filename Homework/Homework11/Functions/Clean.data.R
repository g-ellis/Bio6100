# --------------------------------------
# FUNCTION clean.data
# required packages: tidyverse
# description: remove observations where a bird was not identified
# inputs: path to csv
# outputs: clean csv in CleanedData folder
########################################
clean.data <- function(path=NULL) {
  data <- read.csv(path, header=TRUE, comment.char="#")
  cleaned_data <- filter(data, targetTaxaPresent == "Y")
  new_name <- paste0("BART_", str_extract(path, pattern="20\\d{2}"), "_countdata_clean.csv")
  new_path <- paste0("CleanedData/",new_name)
  write.csv(x=cleaned_data, file=new_path)
}
  
# end of function clean.data
# --------------------------------------
# clean.data()


clean.data(file_list[1])
