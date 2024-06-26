###################################
### Clean up a Dataset          ###
###################################
# Clear Workspace
rm(list=ls())

library(readr)
library(dplyr)
library(stringr)


# Write a funciton to apply fixes to data files
clean_form <- function(filename, output_file) {
  # Read in one file
  df_ir <- read_csv(filename)
  
  # Remove any extra header row
  df_ir <- df_ir[df_ir$Month != 'Month', ]
  
  # Change values in the Prime_Rate column - in the case that the interest rate is off by a decimal
  df_ir$Prime_Rate <- as.numeric(df_ir$Prime_Rate)
  df_ir$Prime_Rate[df_ir$Prime_Rate < 1] <- df_ir$Prime_Rate[df_ir$Prime_Rate < 1] * 10
  
  # Change NDs to NAs
  df_ir$Treasury_Rate_3_Month[df_ir$Treasury_Rate_3_Month == "ND"] <- NA
  
  # # Split the Month and Year into separate columns
  # df_ir$Year <- str_extract(df_ir$Month, "\\d{4}")
  # df_ir$Month <- str_match(df_ir$Month, "-(\\d{2})")[,2]
  
  # # Reorder column names to start with Year and Month
  # df_ir <- df_ir[, c("Year", setdiff(names(df_ir), "Year"))]
  
  # Save results to another file
  if (file.exists(output_file)) {
    write_csv(df_ir, output_file, na = "", append = TRUE)
  } else {
    write_csv(df_ir, output_file, na = "")
  }
  
}

###################################
# Example usage
###################################
workdir <- "./data/raw"
outdir <- "./data"

file_list <- list.files(workdir, pattern = "*.csv", full.names = TRUE)
file_list <- sort(file_list)
output_file <- "./data/ir_all.csv"
for (file in file_list) {
  clean_form(file, output_file)
}
