USE master;
GO

-- ================================================================================
-- DATABASE
-- ================================================================================
IF EXISTS (SELECT * FROM sys.databases WHERE name = N'PythonDatabase')
BEGIN
	ALTER DATABASE PythonDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE PythonDatabase;
END;
GO

CREATE DATABASE PythonDatabase
ON
(
	NAME		= PythonDatabase,
	FILENAME	= '/var/opt/mssql/data/PythonDatabase.mdf',
	SIZE		= 16 MB,
	MAXSIZE		= UNLIMITED,
	FILEGROWTH	= 8 MB
)
LOG ON
(
	NAME		= PythonDatabaseLog,
	FILENAME	= '/var/opt/mssql/data/PythonDatabase.ldf',
	SIZE		= 16 MB,
	MAXSIZE		= UNLIMITED,
	FILEGROWTH	= 8 MB
)
GO

-- ================================================================================
-- SCHEMA
-- ================================================================================
USE PythonDatabase;
GO

CREATE TABLE dbo.Company
(
	Id								uniqueidentifier	NOT NULL,
	Name							nvarchar(120)		NOT NULL,

	CONSTRAINT pk_Company
		PRIMARY KEY CLUSTERED (Id)
		WITH FILLFACTOR = 90
		ON [PRIMARY]
);
GO

/*
CREATE TABLE dbo.SalesTransaction
(
)
GO
*/

-- ================================================================================
-- DATA
-- ================================================================================
MERGE INTO
	dbo.Company AS dst

USING
(
	VALUES
		('20CFA9D5-5DB3-4D30-8A8C-481BC3017F59', 'Becton, Dickinson and Company'),
		('0945541C-D50B-48CD-B2BD-47EBC78AF654', 'Microsoft Corporation')
)
AS src
(
	Id,
	Name
)
ON
	src.Id = dst.Id

WHEN MATCHED THEN

	UPDATE
	SET
		Name = src.Name

WHEN NOT MATCHED THEN

	INSERT
	(
		Id,
		Name
	)
	VALUES
	(
		src.Id,
		src.Name
	);
GO
