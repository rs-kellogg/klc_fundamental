import os
import time
from pathlib import Path

import pandas as pd 
from dotenv import load_dotenv
import google.generativeai as genai

# get API key from .env file
# .env file:
# GOOGLE_API_KEY=api_key_from_https://aistudio.google.com/app/apikey
load_dotenv() 
api_key=os.getenv("GOOGLE_API_KEY")
genai.configure(api_key=api_key)
gemini_model = "gemini-pro"
model=genai.GenerativeModel(gemini_model)

# Function to get response
def get_gemini_response(prompt):
    response = model.generate_content(prompt)
    return response.text


def classify_tweets(df, output_file):
    for idx, row in df.iterrows():
        tweet_text = row['body']
        prompt=f"You are a stock trader. Here is a tweet on the Apple company: {tweet_text}. Please classify the sentiments of the tweet on AAPL stock as either good, neutral or bad. Your response should be just one word."
        output = get_gemini_response(prompt)
        print(tweet_text)
        print(output)
        time.sleep(5)

        # Add logging information to the output file
        # tweet_id, tweet, sentiment, llm, processed_date


# Original data source:
# https://www.kaggle.com/datasets/omermetinn/tweets-about-the-top-companies-from-2015-to-2020/data
# Pre-filter to AAPL tweets between 2018-12-01 and 2018-12-31
df = pd.read_csv('tweets_AAPL.csv')

output_file = "tweets_AAPL_sentiment.csv"
classify_tweets(df[:4], output_file)


