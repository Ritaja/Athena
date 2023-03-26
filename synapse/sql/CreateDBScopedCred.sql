-- create DB scope credential that will be used to access (only required to create once per DB)
-- generate a shared access signature from the ADLS container where the gerated data is placed and paste in the SECRET below
CREATE DATABASE SCOPED CREDENTIAL [oaisharedsalesstar]
WITH IDENTITY='SHARED ACCESS SIGNATURE',  
SECRET = 'sp=<add-here>'
GO