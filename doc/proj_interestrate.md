# Project: Process Interest Rate Files

## Project Description
This project cleans up interest rate data files with python, R, or Stata code.  
The scripts are in the ./interest_rates/code folder, the original data is in the ./interest_rates/data/raw folder, and the output files are in the ./interest_rates/data folder.

## Follow the [instructions for processing SEC 10-K forms project](./proj_sec10k.md) to set up Mamba environment

## Run the python script
```
cd interest_rates
python code/proc_ir.py
```
- Exercise:   
1. Remove the "# " string at the beginning of line 26-27 and 30-31  
2. Update your local git repo and make a commit
3. Rerun the code and check the first few lines of the "./data/ir_all.csv" output file. Did you notice what has changed?


## Run the R script
```
cd interest_rates
Rscript code/proc_ir.R
```
- Exercise:   
1. Remove the "# " string at the beginning of line 28, 29 and 32  
2. Update your local git repo and make a commit
3. Rerun the code and check the first few lines of the "./data/ir_all.csv" output file. Did you notice what has changed?


## Run the Stata script
```
module load stata
cd interest_rates
stata -b do code/proc_ir.do
```
- Exercise:   
1. Remove the "* " string at the beginning of line 35-38
2. Update your local git repo and make a commit
3. Move the previous output file
```
mv ./data/ir2000_new.csv ./data/ir2000_new.csv.orig
```
4. Rerun the code and check the first few lines of the "./data/ir2000_new.csv" output file. Did you notice what has changed?