/*
=============================================================================

Creating database and schemas

=============================================================================
Purpose: 

this script creates a new database named 'DataWarehour' after checking if it altready exist
if it already exists then it will forst delete it and make new database. additionally , three new
schemas are created by this script :

bronze
silver
gold

WARNING: this script will permanently drop any database named "DataWarehouse" if it already present

*/

USE master;
GO

-- dropping existing database and creating new

IF EXISTS (SELECT 1 FROM sys.databases where name = 'DataWarehouse')

BEGIN 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;

GO

-- creating database
CREATE DATABASE DataWarehouse;
Go

--creating three schemas: bronze, silver, gold
USE DataWarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
