-- create in specific db
CREATE USER Vicky FROM LOGIN JohnDoe;
EXEC sp_addrolemember 'db_owner', 'JohnDoe'; 
