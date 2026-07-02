#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Job Postings Data Analysis Script

Description:
This script loads a CSV dataset, performs data cleaning, exploratory data analysis (EDA),
basic visualization, and saves a cleaned dataset for further use.

Usage:
    python analysis.py

Requirements:
    pandas
    matplotlib
    seaborn
    nltk
"""

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import re
from collections import Counter
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize


# ==============================
# 1. Load Data
# ==============================
def load_data(file_path: str) -> pd.DataFrame:
    """Load CSV file safely."""
    return pd.read_csv(file_path, on_bad_lines='skip', engine='python')


# ==============================
# 2. Basic Exploration
# ==============================
def explore_data(df: pd.DataFrame):
    print("\n--- Data Preview ---")
    print(df.head())

    print("\n--- Data Info ---")
    print(df.info())

    print("\n--- Missing Values ---")
    print(df.isnull().sum())


# ==============================
# 3. Handle Missing Values
# ==============================
def clean_missing_data(df: pd.DataFrame) -> pd.DataFrame:
    """Remove columns with high missing values and fill others."""

    # Calculate missing percentage
    missing_percentage = df.isnull().sum() / len(df) * 100
    high_missing_columns = missing_percentage[missing_percentage > 50].index.tolist()

    # Drop high-missing columns
    df = df.drop(columns=high_missing_columns)

    # Fill categorical columns
    categorical_cols = df.select_dtypes(include='object').columns
    for col in categorical_cols:
        df[col] = df[col].fillna('Unknown')

    # Fill numerical columns
    for col in ['company_id', 'views']:
        if col in df.columns:
            df[col] = df[col].fillna(df[col].median())

    for col in ['zip_code', 'fips']:
        if col in df.columns:
            df[col] = df[col].fillna(-1)

    return df


# ==============================
# 4. Convert Time Columns
# ==============================
def convert_timestamps(df: pd.DataFrame) -> pd.DataFrame:
    timestamp_columns = ['original_listed_time', 'expiry', 'listed_time']

    for col in timestamp_columns:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col] / 1000, unit='s', errors='coerce')

    return df


# ==============================
# 5. Visualization
# ==============================
def plot_numeric_distributions(df: pd.DataFrame):
    num_cols = ['views', 'company_id']

    plt.figure(figsize=(10, 6))
    for i, col in enumerate(num_cols):
        if col in df.columns:
            plt.subplot(1, 2, i + 1)
            sns.histplot(df[col], kde=True)
            plt.title(col)

    plt.tight_layout()
    plt.show()


# ==============================
# 6. Text Processing
# ==============================
def setup_nltk():
    nltk.download('stopwords')
    nltk.download('punkt')


def clean_text(text: str) -> str:
    if not isinstance(text, str):
        return ""
    text = text.lower()
    text = re.sub(r'[^a-z\s]', '', text)
    words = word_tokenize(text)
    stop_words = set(stopwords.words('english'))
    words = [w for w in words if w not in stop_words]
    return " ".join(words)


def analyze_text(df: pd.DataFrame):
    if 'title' not in df.columns:
        return

    df['cleaned_title'] = df['title'].apply(clean_text)

    all_words = ' '.join(df['cleaned_title']).split()
    word_counts = Counter(all_words)

    print("\n--- Top Words in Titles ---")
    print(word_counts.most_common(20))


# ==============================
# 7. Main Function
# ==============================
def main():
    file_path = 'postings1.csv'

    df = load_data(file_path)
    explore_data(df)

    df = clean_missing_data(df)
    df = convert_timestamps(df)

    plot_numeric_distributions(df)

    setup_nltk()
    analyze_text(df)

    # Save cleaned data
    df.to_csv('cleaned_postings.csv', index=False)
    print("\nCleaned data saved to cleaned_postings.csv")


if __name__ == "__main__":
    main()
