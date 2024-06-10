# Project: Processing SEC 10-K Forms with Gemini-Pro model

## Download this repo
```
git clone https://github.com/rs-kellogg/klc_fundamental
cd klc_fundamental
```

## Create a Conda environment using the requirements.txt file
```
# Load miniconda module
module purge
module load python-miniconda3/4.12.0
module list

conda create -p gemini_chat_env python==3.10
# this will print out the current directory
pwd
# copy the previous output and use as "current_directory_output" below
source activate current_directory_output/gemini_chat_env
pip install -r requirements.txt
```

## Run the script
```
cd sec_10k
# Run the python script
python proc_sec10k.py
```

## Modify script and check out output files
- Check what regular expression in line 31 of proc_sec10k.py do
```
cp  1716324_2_0001477932-23-002626_cleaned.txt.orig
```
Comment out line 31 of proc_sec10k.py by adding a "#" symbol, # cleaned = re.sub(r"\n\s{1,}\n", "\n", cleaned)
```
python proc_sec10k.py
```
Use editor to open file to check
Try the following commands
```
diff 1716324_2_0001477932-23-002626_cleaned.txt 1716324_2_0001477932-23-002626_cleaned.txt.orig
wc -l 1716324_2_0001477932-23-002626_cleaned.txt*
```