###################################
### Automate Cleaning a Dataset ###
###################################
# Clear Workspace
rm(list=ls())

library(readr)
library(dplyr)
library(stringr)

clean_form2000 <- function(filename, output_file) {
  # Read in one file
  df_ir <- read_csv(filename)
  
  # Change one Value - The interest rate in April 2021 is off by a decimal
  print(df_ir[11, 4])
  df_ir[11, 4] <- "7.8"
  print(df_ir[11, 4])
  
  # Remove an Extra Header Row
  print(df_ir[7, ])
  df_ir <- df_ir[-7, ]
  print(df_ir[7, ])
  
  # Change NDs to NAs
  print(df_ir[23, 5])
  df_ir[23, 5] <- ""
  print(df_ir[23, 5])
  
  # Save Results to another file
  write_csv(df_ir, output_file)
  
}


clean_form <- function(filename, output_file) {
  # Read in one File
  df_ir <- read_csv(filename)
  
  # Remove an Extra Header Row
  df_ir <- df_ir[df_ir$Month != 'Month', ]
  
  # Change one Value - The interest rate in April 2021 is off by a decimal
  df_ir$Prime_Rate <- as.numeric(df_ir$Prime_Rate)
  df_ir$Prime_Rate[df_ir$Prime_Rate < 1] <- df_ir$Prime_Rate[df_ir$Prime_Rate < 1] * 10
  
  # Change NDs to NAs
  df_ir$Treasury_Rate_3_Month[df_ir$Treasury_Rate_3_Month == "ND"] <- NA
  
  # # Split the Month and Year into separate columns
  # df_ir$Year <- str_extract(df_ir$Month, "\\d{4}")
  # df_ir$Month <- str_match(df_ir$Month, "-(\\d{2})")[,2]
  
  # # Reorder column names to start with Year and Month
  # df_ir <- df_ir[, c("Year", setdiff(names(df_ir), "Year"))]
  
  # Save Results to another file
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
filename <- "/ir2000.csv"
file <- paste0(workdir, filename)
output_file <- paste0(outdir, gsub("[.]csv", "_new.csv", filename))
clean_form2000(file, output_file)

file_list <- list.files(workdir, pattern = "*.csv", full.names = TRUE)
file_list <- sort(file_list)
output_file <- "./data/ir_all.csv"
for (file in file_list) {
  clean_form(file, output_file)
}