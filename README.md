# Sample script for classifying tweets with Gemini-Pro model

## Get an API Key
Retrieve one for free here: https://aistudio.google.com/app/apikey

## Download this repo
git clone https://github.com/rs-kellogg/klc_fundamental
cd klc_fundamental

## Create a Conda environment using the requirements.txt file
conda create -p gemini_chat_env python==3.10   
conda activate gemini_chat_env  
pip install -r requirements.txt   

## Run the script
python classify_company_tweets.py
