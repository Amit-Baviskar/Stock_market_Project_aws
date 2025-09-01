
  create or replace   view STOCKS.RAW_staging.stg_stock_prices
  
  
  
  
  as (
    

select
    cast(TRADE_DATE as date) as trade_date,
    TICKER as ticker,
    OPEN_PRICE as open_price,
    HIGH_PRICE as high_price,
    LOW_PRICE as low_price,
    CLOSE_PRICE as close_price,
    VOLUME as volume
from STOCKS.RAW.STOCK_PRICES
  );

