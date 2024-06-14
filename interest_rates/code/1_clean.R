###################################
### Automate Cleaning a Dataset ###
###################################
# Clear Workspace
rm(list=ls())

# Set Working Directory
setwd("~/workshop_2022/Session4_Automate/interest_rates/data/raw")

# Install and load necessary libraries
if(!require("dplyr")) install.packages("dplyr")
if(!require("fs")) install.packages("fs")
if(!require("stringr")) install.packages("stringr")

#load packages
library(dplyr)
library(fs)
library(stringr)


#########################################
# Individualized Fixes

# Read in one File
ir2000 <- read.csv("ir2000.csv", encoding="UTF-8", header=TRUE)

# Change one Value - The interest rate in April 2021 is off by a decimal
print(ir2000[11,4])
ir2000$Prime_Rate <- as.numeric(ir2000$Prime_Rate)
ir2000[11,4] <- 7.8

# Remove an Extra Header Row
print(ir2000[7,])
ir2000 <- ir2000[-7,]

# Change NDs to NAs
print(ir2000[23,5])
ir2000[23,5] <- NA

# Save Results
#setwd("~/workshop_2022/Session4_Automate/interest_rates/data")
#write.csv(ir2000, file="ir2000_new.csv", row.names=FALSE)
rm(ir2000)

########################
# Generalizing Changes

# read in all data files
filenames <- dir_ls(glob = "*.csv") %>% as.character() %>% sort()
filenames

# combine datasets
ir <- data.frame()
for (filename in filenames){
  ir_add <- read.table(filename, header = FALSE, sep = ",", quote = "\"", comment.char = "")
  ir <- rbind(ir, ir_add)
}
rm(ir_add, filename, filenames)

# add header row
names(ir) <- as.vector(t(ir)[1,])


# Remove all rows with header values
ir <- ir[ir$Month != "Month",] 


# check all prime rates for errors at once
class(ir$Prime_Rate)
ir$Prime_Rate <- as.numeric(as.character(ir$Prime_Rate))
ir$Prime_Rate <- ifelse(((lead(ir$Prime_Rate)/ir$Prime_Rate)-1) > 1, 
                         ir$Prime_Rate*10,
                         ir$Prime_Rate)

print(ir[10,4]) # check if error is corrected

# replace NDs with NAs
ir$Treasury_Rate_3_Month <- ifelse(ir$Treasury_Rate_3_Month=="ND",
                                   NA,
                                   ir$Treasury_Rate_3_Month)

# Save Results
setwd("~/workshop_2022/Session4_Automate/interest_rates/data")
write.csv(ir, file="interest_rate_update.csv", row.names=FALSE)

# Return a Message when file is run to completion
print("Sucessfully cleaned interest rate data.")

######################
# In Class Exercise: 
######################
# Use regex to automate separating the year and month from the "Month" variable.
# Then sort the dataset by year and month before saving. 
# HINT: I like the "stringr" library.












######################
# Potential Solution: 
######################
ir$Year <- str_extract(ir$Month, "\\d{4}")
ir$Month <- str_match(ir$Month, "-(\\d{2})")[,2]
ir <- ir[order(ir$Year, ir$Month),]
write.csv(ir, file="interest_rate_update.csv", row.names=FALSE)




library(readr)
library(dplyr)
library(stringr)

clean_form2000 <- function(filename, output_file) {
  # Read in one file
  df_ir <- read_csv(filename)
  
  # Change one Value - The interest rate in April 2021 is off by a decimal
  print(df_ir[11, 4])
  df_ir[11, 4] <- 7.8
  print(df_ir[11, 4])
  
  # Remove an Extra Header Row
  print(df_ir[7, ])
  df_ir <- df_ir[-7, ]
  print(df_ir[7, ])
  
  # Change NDs to NAs
  print(df_ir[23, 5])
  df_ir[23, 5] <- NA
  print(df_ir[23, 5])
  
  # Save Results to another file
  write_csv(df_ir, output_file)
  
  return(invisible())
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
  
  # Split the Month and Year into separate columns
  df_ir <- df_ir %>%
    separate(Month, into = c("Year", "Month"), sep = "-")
  
  # Reorder column names to start with Year and Month
  df_ir <- df_ir[, c("Year", setdiff(names(df_ir), "Year"))]
  
  # Save Results to another file
  if (file.exists(output_file)) {
    write_csv(df_ir, output_file, append = TRUE)
  } else {
    write_csv(df_ir, output_file)
  }
  
  return(invisible())
}

# Example usage
workdir <- "../data/raw"
file <- paste0(workdir, "/ir2000.csv")
output_file <- paste0("./", strsplit(file, "/")[[1]][[3]], "_new.csv")
clean_form2000(file, output_file)

file_list <- list.files(workdir, pattern = "*.csv", full.names = TRUE)
file_list <- sort(file_list)
output_file <- "./ir_all.csv"
for (file in file_list) {
  clean_form(file, output_file)
}