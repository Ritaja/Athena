-- define the file format for external table
CREATE EXTERNAL FILE FORMAT [SalesParquetFormat]
       WITH ( FORMAT_TYPE = PARQUET)
GO
-- define the data source for the external table
-- Replace the ADLS account name and the container name in the appropriate places below
CREATE EXTERNAL DATA SOURCE salesData WITH (    
       LOCATION   = 'https://<acccount-name>.dfs.core.windows.net/<container-name>/salesfact',
       CREDENTIAL = oaisharedsalesstar
        )
GO

-- create the external table
CREATE EXTERNAL TABLE dbo.salesfact ( [salesfact_key] varchar(100), [store_key] varchar(100), [customer_key] varchar(100), [product_key] varchar(100), [sales_price] decimal(9,2), [sales_units] int, [sales_month] varchar(100), [sales_day] varchar(100), [sales_year] int )
WITH ( LOCATION = './',
       DATA_SOURCE = [salesData],
       FILE_FORMAT = [SalesParquetFormat] )