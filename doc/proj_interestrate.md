# Project: Process Interest Rate Files

## Project Description
This project cleans up interest rate data files with python, R, or Stata code.  
The scripts are in the ./interest_rates/code folder, the original data is in the ./interest_rates/data/raw folder, and the output files are in the ./interest_rates/data folder.

## Follow the [instructions for processing SEC 10-K forms project](./proj_sec10k.md) to set up Mamba environment

## Run the python script
```
cd interest_rates
python code/1_clean.py
```


## Run the R script
```
cd interest_rates
Rscript code/1_clean.R
```



## Run the Stata script
```
module load stata
cd interest_rates
stata -b do code/1_clean.do
```