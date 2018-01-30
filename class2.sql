/*
	Cascading effect/Snowball effect- checking stuff before transactions

	Control Flow-

	IF...ELSE
	BEGIN...END

	WHILE
	BREAK | CONTINUE

	WAITFOR
	TRY...CATCH
*/

IF EXISTS 
(SELECT * FROM tblEMPLOYEE WHERE EMPState <> 'WA')

/*
	if product type is alcohol, dob should be > 21 years age
*/

USE OTTER_gthay

CREATE FUNCTION fn_NoBoozeYounger21()
RETURNS INT 
AS
BEGIN
	DECLARE @Ret INT = 0
	IF EXISTS (
			SELECT * FROM tblPRODUCT_TYPE PT JOIN tblPRODUCT P ON PT.ProductTypeID = P.ProductTypeID
			JOIN tblORDER_PRODUCT OP ON P.ProductID = OP.ProductID
			JOIN tblORDER O ON OP.OrderID = O.OrderID
			JOIN tblCUSTOMER C ON O.CustomerID = C.CustomerID
		WHERE C.CustBirthDate > (SELECT GetDate() - (365.25 * 21))
		AND PT.ProductTypeName = 'Alcohol'
		)
	SET @Ret = 1
	RETURN @Ret
END

DECLARE @Num varchar(4) = '25'
WHILE @Num > 0
BEGIN
PRINT('Greg needs coffeee')
SET @Num = @Num - 1
END

/*
	Understanding SQL messages


	Message number 
	Severity Level
	State
	Procedure
	Line
	Message

*/

SELECT * 
FROM sys.messages