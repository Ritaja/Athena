-- create in master DB
CREATE LOGIN JohnDoe WITH PASSWORD = 'ThisIsNotVerySecure!'; 
CREATE USER JohnDoe FROM LOGIN JohnDoe; 