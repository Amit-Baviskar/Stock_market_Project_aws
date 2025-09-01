-- models/curated_stock_prices.sql



WITH base AS (
    SELECT
        TRADE_DATE AS date,
        TICKER,
        OPEN_PRICE  AS open,
        CLOSE_PRICE AS close,
        HIGH_PRICE  AS high,
        LOW_PRICE   AS low,
        VOLUME,
        (CLOSE_PRICE - OPEN_PRICE) AS daily_return
    FROM STOCKS.RAW_staging.stg_stock_prices
)

SELECT
    *,
    AVG(daily_return) OVER (
        PARTITION BY TICKER 
        ORDER BY date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7d,
    AVG(daily_return) OVER (
        PARTITION BY TICKER 
        ORDER BY date 
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS moving_avg_30d
FROM base