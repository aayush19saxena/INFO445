CREATE PROCEDURE uspGetCustomerTypeID
@Customer_Type_Name varchar(50),
@Customer_Type_ID INT OUTPUT 
AS
SET @Customer_Type_ID = (SELECT CustomerTypeID FROM tblCustomer_TYPE WHERE CustomerTypeName = @CustomerTypeName)


CREATE PROCEDURE uspPopulateCustomer
@Customer_FName varchar(25),
@Customer_LName varchar(25),
@Customer_BirthDate DATE,
@Customer_Type_Name varchar(50)
AS
DECLARE @Customer_Type_ID INT

EXEC uspGetCustomerTypeID @Customer_Type_Name = @Customer_Type_Name, @Customer_Type_ID = @Customer_Type_ID OUTPUT

IF @Customer_Type_ID IS NULL
BEGIN
RAISERROR('ID is null')
END

BEGIN TRAN 
INSERT INTO tblCustomer(CustFName, CustLame, CustBirthDate, CustomerTypeID) 
VALUES (@Customer_FName, @Customer_LName, @Customer_BirthDate, @Customer_Type_Name)
IF @@ERROR<>0
	ROLLBACK TRAN

ELSE 
	COMMIT TRAN

GO
