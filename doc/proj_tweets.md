# Project: Classify Tweets with Gemini-Pro Model

## Follow the instructions for processing SEC 10-K forms project to set up Conda environment

## Get an API Key and set it up in a .env file
Retrieve one for free here: https://aistudio.google.com/app/apikey
```
cd klc_fundamental/tweets
# Set up .env file, write the following line starting with "GOOGLE_API_KEY"
# GOOGLE_API_KEY=api_key_from_https://aistudio.google.com/app/apikey
nano .env
```

## Download data
Download and transfer data file: [tweets_AAPL.csv](https://nuwildcat-my.sharepoint.com/:x:/g/personal/plu781_ads_northwestern_edu/ESBUwvqhMV9IlaZ_OOQH7HcB_bcaRtbfq0kIbmeFuNFoYA?e=pgfUdz) to the tweets/ folder

## Run the python script
```
python classify_company_tweets.py
```

## Add logging to the python script
Follow lines 33-34 in classify_company_tweets.py, write a .csv table with columns "tweet_id, tweet, sentiment, llm, processed_date" to an output file
