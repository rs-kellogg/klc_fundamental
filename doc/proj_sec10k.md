# Project: Clean Up SEC 10-K Forms 

## Project description
We have various SEC forms downloaded at /kellogg/data/EDGAR on KLC. However, they are not in clean text format. Before doing research with these files, some removal of XML/HTML tags are needed. The python code in this project cleans up a 10-K text file and save a section of "Discussion and Analysis of Financial Condition" text.  
The python code is in the ./sec_10k/code folder, the original data is in the ./sec_10k/data/raw folder, and the output files are in the ./sec_10k/data folder.


## Download this repo
```
git clone https://github.com/rs-kellogg/klc_fundamental
cd klc_fundamental
```

## Create a Mamba environment using the klc_fund_env.yml file
```
# Load micromamba module
module load micromamba

########################################################
# Run this line once to create environment 
micromamba create -p ~/envs/klc_fund_env -f klc_fund_env.yml 
########################################################

micromamba activate ~/envs/klc_fund_env

# Optional: to export an existing environment to .yml file
micromamba env export >> klc_fund_env_export.yml
```

## Run the script
```
cd sec_10k
# Run the python script
python ./code/process_sec10k.py
```

## Modify script and check out output files
```
# Copy current output to a new file
cp data/1716324_2_0001477932-23-002626_cleaned.txt data/1716324_2_0001477932-23-002626_cleaned.txt.orig
```
- Check what regular expression in line 31 of ./code/process_sec10k.py do
- Use nano editor to open file and remove "# " at the beginning of line 31 of code/process_sec10k.py 
```
nano ./code/process_sec10k.py
# Go to line 31 and edit
    # cleaned = re.sub(r"\n\s{1,}\n", "\n", cleaned)
# To
    cleaned = re.sub(r"\n\s{1,}\n", "\n", cleaned)
```
```
python ./code/process_sec10k.py
```
- Update your local git repo and make a commit (see common git commands [here](https://rs-kellogg.github.io/klc_fundamental/common_git_commands.html))
```
# Basic git commands
# Add new file for git tracking
git add new file
# Adds all changes to existing files to the Staging Area
git add -u
# Commit changes to repo
git commit -m "message"
# Check current status
git status
# Check log of commit
git log
```
- Execute the following commands
```
# "diff" command prints out difference between text files
# "head -10" command prints out the first 10 lines of output
diff ./data/1716324_2_0001477932-23-002626_cleaned.txt ./data/1716324_2_0001477932-23-002626_cleaned.txt.orig | head -10
# "wc -l" command prints out line counts of text files
wc -l ./data/1716324_2_0001477932-23-002626_cleaned.txt*
```
