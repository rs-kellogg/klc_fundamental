# Project: Process Interest Rate Files

## Project Description
This project cleans up interest rate data files with python, R, or Stata code.  
The scripts are in the ./interest_rates/code folder, the original data is in the ./interest_rates/data/raw folder, and the output files are in the ./interest_rates/data folder.

## Follow the [instructions for processing SEC 10-K forms project](./proj_sec10k.md) to set up Mamba environment
If the environment has been created, you can activate the environment as follows:
```
module load micromamba
micromamba activate ~/envs/klc_fund_env
```

## Run the python script
```
cd interest_rates
python code/proc_ir.py
```
Check the first 11 lines of the "./data/ir_all.csv" output file vs the "./data/raw/ir2000.csv" file. Did you notice what has changed?
- Exercise:   
1. Remove the "# " string at the beginning of line 26-27 and 30-31  
2. Update your local git repo and make a commit (see common git commands [here](https://rs-kellogg.github.io/klc_fundamental/common_git_commands.html))
3. Rerun the code and check the first 3 lines of the "./data/ir_all.csv" output file. Did you notice what has changed?


## Run the R script
```
cd interest_rates
Rscript code/proc_ir.R
```
Check the first 11 lines of the "./data/ir_all.csv" output file vs the "./data/raw/ir2000.csv" file. Did you notice what has changed?
- Exercise:   
1. Remove the "# " string at the beginning of line 28, 29 and 32  
2. Update your local git repo and make a commit (see common git commands [here](https://rs-kellogg.github.io/klc_fundamental/common_git_commands.html))
3. Rerun the code and check the first 3 lines of the "./data/ir_all.csv" output file. Did you notice what has changed?


## Run the Stata script
```
module load stata
cd interest_rates
stata -b do code/proc_ir.do
```
Check the first 11 lines of the "./data/ir2000_new.csv" output file vs the "./data/raw/ir2000.csv" file. Did you notice what has changed?  
- Exercise:   
1. Remove the "* " string at the beginning of line 35-38
2. Update your local git repo and make a commit (see common git commands [here](https://rs-kellogg.github.io/klc_fundamental/common_git_commands.html))
3. Move the previous output file
```
mv ./data/ir2000_new.csv ./data/ir2000_new.csv.orig
```
4. Rerun the code and check the first 3 lines of the "./data/ir2000_new.csv" output file. Did you notice what has changed?