-- we will do AD cred passthrough for user (user needs to be storage blob contributor), 
CREATE EXTERNAL FILE FORMAT [StoreParquetFormat]
       WITH ( FORMAT_TYPE = PARQUET)
GO
-- define the data source for the external table
-- Replace the ADLS account name and the container name in the appropriate places below
CREATE EXTERNAL DATA SOURCE storeData WITH (    
       LOCATION   = 'https://<acccount-name>.dfs.core.windows.net/<container-name>/storedim',
       CREDENTIAL = oaisharedsalesstar  
       )
GO

-- create the external table
CREATE EXTERNAL TABLE dbo.storedim ( [store_key] varchar(100), [store_city] varchar(100), [store_country] varchar(100) )
WITH ( LOCATION = './',
       DATA_SOURCE = [storeData],
       FILE_FORMAT = [StoreParquetFormat] )