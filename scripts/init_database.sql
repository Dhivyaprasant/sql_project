/*
======================================
create database and schemas
======================================

script purpose:
 this script create a new database name 'DataWarehouse' after checking if i already exists
 if the dab exists, it will be dropped and recreated. additionally,the script sets up three schemas
 within the database: 'bronze','silver','gold'


 WARNING:
 running this script will drop the entire db if ir existes.
 all data in the db will be permanently deleted.proceed with caution
 and sensure you have proper backups before running thi script
 */




IF EXISTS (SELECT 1 FROM sys.database_audit_specification_details WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO 

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;


--create the datawarehouse schema
create schema bronze;
go
create schema gold;
go
create schema silver;

 
