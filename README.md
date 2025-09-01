# Stock Price Data Pipeline with Snowflake & S3

## Project Overview

This project demonstrates how to build a simple data pipeline using Snowflake and AWS S3.
The pipeline extracts stock market data, stages it in Snowflake, and then exports curated datasets into S3 in Parquet format for downstream analytics.

## Tech Stack

 * Snowflake – Data warehouse for storing and transforming stock price data

 * AWS S3 – Storage for curated datasets in Parquet format

 * SQL / dbt – Data modeling (Staging & Curated layers)

 * Parquet – Columnar file format for optimized querying in Athena/Glue

## Project Structure
    models/
    │── staging/
    │   └── stg_stock_prices.sql         # Staging layer model
    │── curated/
    │   └── curated_stock_prices.sql     # Curated layer model (materialized table)
README.md

## Database Schema

    Column	      Data Type	   Description
    TRADE_DATE	  DATE	       Date of stock trade
    TICKER	      VARCHAR	   Stock ticker symbol
    OPEN_PRICE	  FLOAT	       Opening price
    HIGH_PRICE	  FLOAT	       Highest price of the day
    LOW_PRICE	  FLOAT	       Lowest price of the day
    CLOSE_PRICE	  FLOAT	       Closing price
    VOLUME	      FLOAT	       Trading volume


##  1.Steps to Export Data to S3

       --Create a Parquet file format in Snowflake
        CREATE OR REPLACE FILE FORMAT my_parquet_format
        TYPE = PARQUET
        COMPRESSION = SNAPPY;

##  2.Create an external stage linked to your S3 bucket
      
      CREATE OR REPLACE STAGE my_s3_stage
      URL = 's3://my-bucket-name/curated-stock-data/'
      CREDENTIALS = (
      AWS_KEY_ID = '<your-access-key-id>'
      AWS_SECRET_KEY = '<your-secret-access-key>'
      )
      FILE_FORMAT = my_parquet_format;

## 3.Copy curated data from Snowflake to S3 in Parquet format

      COPY INTO @my_s3_stage/curated_stock_prices_
      FROM (SELECT * FROM STOCKS.RAW_CURATED.CURATED_STOCK_PRICES)
      FILE_FORMAT = (TYPE = PARQUET COMPRESSION = SNAPPY)
      OVERWRITE = TRUE;

## Future Improvements

 * Partition data in S3 by year/month for faster queries in Athena/Glue

 * Automate pipeline using dbt Cloud or Airflow

 * Set up Snowpipe for continuous data ingestion

## Acknowledgements

Snowflake Documentation

AWS S3 & Athena Guides

dbt for data modeling
