{{ config(materialized='view') }}

select
    cast(TRADE_DATE as date) as trade_date,
    TICKER as ticker,
    OPEN_PRICE as open_price,
    HIGH_PRICE as high_price,
    LOW_PRICE as low_price,
    CLOSE_PRICE as close_price,
    VOLUME as volume
from {{ source('STOCKS', 'STOCK_PRICES') }}
