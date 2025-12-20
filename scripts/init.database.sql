/* 

===========================================================================================
Create Database and Schemas
===========================================================================================
This project is a pet project in the field of data engineering and advanced data analytics
using MySQL server.
*/
SHOW DATABASES;

USE Master;
-- Creating the database to be used
CREATE DATABASE DataWarehouse; 


USE DataWarehouse;
-- Creating three Schemas for data warehousing

-- Gold, SIlver and Bronze schemas as per medallion Architecture 
CREATE SCHEMA Gold;
CREATE SCHEMA Silver;
CREATE SCHEMA Bronze;
