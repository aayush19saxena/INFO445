CREATE DATABASE OTTER_as
USE OTTER_as

CREATE TABLE tblCUSTOMER_TYPE(
CustomerTypeID INT IDENTITY(1,1) primary key not null,
CustomerTypeName varchar(50) not null,
CustomerTypeDescr varchar(500) NOT NULL)
GO
CREATE TABLE tblCUSTOMER
(
	CustomerID INT IDENTITY(1,1) primary key not null,
	CustFName varchar(25) not null,
	CustLName varchar(25) not null,
	CustBirthDate Date NOT NULL,
	CustomerTypeID INT FOREIGN KEY REFERENCES tblCUSTOMER_TYPE (CustomerTypeID) NOT NULL)
)
GO
CREATE TABLE tblORDER
(
	OrderID INT IDENTITY(1,1) primary key not null,
	OrderDate Date DEFAULT GetDate() NOT NULL,
	CustomerID INT FOREIGN KEY REFERENCES tbleCUSTOMER (CustomerID) not null
)
 GO	
 CREATE TABLE tblPRODUCT
 (
 	ProductID INT IDENTITY(1,1) primary key not null,
 	ProductName varchar(100) not null,
 	ProductPrice numeric(10, 2) not null,
 	ProductDescr varchar(500) NULL
 )
 GO
 CREATE TABLE tblORDER_PRODUCT
 (
 	OrderProdID INT IDENTITY(1,1) primary key not null,
 	OrderID INT FOREIGN KEY REFERENCES tblORDER(OrderID) not null,
 	ProductID INT FOREIGN KEY REFERENCES tblPRODUCT(ProductID) not null
 	Quantity INT not null
 )
 GO
 CREATE TABLE tblPRODUCT_TYPE
 (
 	ProductTypeID INT IDENTITY(1,1) NOT NULL,
 	ProductTypeName varchar(100) not null,
 	ProductTypeDescr varchar(500) NULL
 )
 GO

 CREATE PROCEDURE uspGetProdTypeID
 @P_Type_Name varchar(100), 
 @PT_ID2 INT OUTPUT
 AS
 SET @PT_ID2 = (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = @P_Type_Name)
 
CREATE PROCEDURE uspADDProduct
@ProdName varchar(100),
@Price Numeric(10,2),
@P_TYPE_NAME varchar(100),
@ProdDescr varchar(500)
AS 
DECLARE @PT_ID INT

/*DECLARE @PT_ID INT  = (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = @P_Type_Name)*/
EXEC uspGetProdTypeID @P_Type_Name2 = @P_Type_Name, @PT_ID2 = @PT_ID OUTPUT


IF @PT_ID IS NULL
	BEGIN 
	PRINT 'Hey.. your lookup value for ProductTypeID has no value'
	RAISERROR ('@PT_ID cannot be NULL; session terminating', 11, 1)
	RETURN 
	END

BEGIN TRAN
INSERT INTO tblPRODUCT (ProductName, ProductPrice, ProductTypeID, ProductDesc)
VALUES (@ProdName, @Price, @PT_ID, @ProdDescr)
IF @@ERROR <> 0
	ROLLBACK TRAN
ELSE 
	COMMIT TRAN
GO

EXEC uspADDProduct 
@ProdName = 'Special Deluxe Wool Snowboard hat',
@Price= '24.99',
@P_Type_Name = 'Accessory',
@ProdDescr = 'This is a great hat'

DECLARE @PTID INT

BEGIN TRAN
INSERT INTO tblPRODUCT_TYPE (ProductTypeName, ProductTypeDescr)
VALUES('Helmet', 'Anything that keeps a noggin in one piece')
SET @PTID = (SELECT scope_identity())

