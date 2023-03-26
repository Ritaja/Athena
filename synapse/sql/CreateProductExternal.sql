-- define the file format for external table
CREATE EXTERNAL FILE FORMAT [ProductParquetFormat]
       WITH ( FORMAT_TYPE = PARQUET)
GO

-- define the data source for the external table
-- Replace the ADLS account name and the container name in the appropriate places below
CREATE EXTERNAL DATA SOURCE productData WITH (    
       LOCATION   = 'https://<acccount-name>.dfs.core.windows.net/<container-name>/productdim',
       CREDENTIAL = oaisharedsalesstar  
       )
GO

-- create the external table
CREATE EXTERNAL TABLE dbo.productdim ( [product_key] varchar(100), [product_name] varchar(100), [product_base_price] decimal(8,2) )
WITH ( LOCATION = './',
       DATA_SOURCE = [productData],
       FILE_FORMAT = [ProductParquetFormat] )
