-- define the file format for external table
CREATE EXTERNAL FILE FORMAT [CustomerParquetFormat]
       WITH ( FORMAT_TYPE = PARQUET)
GO

-- define the data source for the external table
-- Replace the ADLS account name and the container name in the appropriate places below
CREATE EXTERNAL DATA SOURCE customerData
WITH (    
       LOCATION   = 'https://<acccount-name>.dfs.core.windows.net/<container-name>/customerdim',
       CREDENTIAL = oaisharedsalesstar 
)
GO

-- create the external table
CREATE EXTERNAL TABLE dbo.customerdim ( [customer_key] varchar(100), [customer_city] varchar(100), [customer_country] varchar(100), [customer_name] varchar(100) )
WITH ( LOCATION = './',
       DATA_SOURCE = [customerData],
       FILE_FORMAT = [CustomerParquetFormat] )
