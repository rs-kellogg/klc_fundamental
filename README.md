# Sample script for classifying tweets with Gemini-Pro model

## Get an API Key
Retrieve one for free here: https://aistudio.google.com/app/apikey

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
source activate current_directory_output/gemini_chat_env
pip install -r requirements.txt
```

## Run the script
```
# Follow workshop instructions, download and transfer data file: tweets_AAPL.csv

# Set up .env file, write the following line starting with "GOOGLE_API_KEY"
# GOOGLE_API_KEY=api_key_from_https://aistudio.google.com/app/apikey
nano .env

# Run the python script
python classify_company_tweets.py
```
