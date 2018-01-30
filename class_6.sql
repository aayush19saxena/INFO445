/*
	Disaster recovery review
	Lab 2 review
	CASE statement

	Preparing for disaster
		- Natural disaster
		- Outage ----------> Good people (80%) 
		- Corruption ------| Good people
		- Failure of hardware system
		- Hack --------- Malicious (2%)

	What's SLA?

	When to address disaster?
		- Reactive (After disaster)
		- Proactive (Predictable hours)


*/

DECLARE @Middle varchar(255)
DECLARE @Last varchar(255)
DECLARE @ID INT
DECLARE @Count INT 

SET @COUNT = (SELECT Count(*) FROM NewFix)
SET @ID = (SELECT MIN(RawID) FROM NewFix)

WHILE @COUNT > 0
	SET @Middle = (SELECT Mname FROM Shark WHERE RawID = @ID)
	SET @Last = (SELECT Lname FROM Shark WHERE RawID = @ID)

	....business logic
	SET @COUNT = @COUNT - 1
	SET @ID = @ID + 1
END

----------------------------------------------------------------

SELECT * FROM RAW_PetData

DECLARE @ID INT
DECLARE @PETTYPE  varchar(50)

WHILE @RUN > 0
	BEGIN 
		SET @ID = (SELECT MIN(PetID) FROM WorkingTable)
		SET @petName = (SELECT PetName FROM WorkingTable WHERE PetID = @ID)
		SET @Country = (SELECT Country FROM WorkingTable WHERE PetID = @ID)
		SET @GEnder = (SELECT Gender FROM WorkingTable WHERE PetID = @ID)
		SET @Temp = (SELECT Temp FROM WorkingTable WHERE PetID = @ID)
		SET @DOB = (SELECT DOB..)

		IF @PetName IS NULL
			BEGIN
				PRINT 'Cannot process pet with no name'
				RAISE ERROR ('No pet.. no processing..yo', 11, 1)
				RETURN
			END

		BEGIN Tran t1
			INSERT INTO tblPet (PetName, PetTypeID, TemperamentID, GenderID)
			VALUES (@pet, ...)

			IF @@ERROR <> 0
				ROLLBACK TRAN
			ELSE 
				COMMIT TRAN
		END



SELECT (
	CASE
		WHEN DateOfBith BETWEEN '1/1/1915' AND '12/31/1934'
		THEN 'SILENT GENERATION'
		WHEN DateOfBith BETWEEN '1/1/1935' AND '12/31/1944'
		THEN 'GREATEST GENERATION'
		WHEN DateOfBith BETWEEN '1/1/1945' AND '12/31/1963'
		THEN 'Baby Boomer Generation'
		WHEN DateOfBith BETWEEN '1/1/1964' AND '12/31/1983'
		THEN 'GEN X'
		ELSE 'Unknown'
	END) AS 'GenerationName', COUNT(*)
	FROM tblCustomer
	GROUP BY (
	CASE
		WHEN DateOfBith BETWEEN '1/1/1915' AND '12/31/1934'
		THEN 'SILENT GENERATION'
		WHEN DateOfBith BETWEEN '1/1/1935' AND '12/31/1944'
		THEN 'GREATEST GENERATION'
		WHEN DateOfBith BETWEEN '1/1/1945' AND '12/31/1963'
		THEN 'Baby Boomer Generation'
		WHEN DateOfBith BETWEEN '1/1/1964' AND '12/31/1983'
		THEN 'GEN X'
		ELSE 'Unknown'
	END) ORDER BY GenerationName


SELECT (
	CASE
		WHEN State IN ('California', 'Oregon', 'Idaho')
			THEN 'FRIENDLY'
		WHEN State IN ('Michigan', 'Ohio', 'Indiana')
			THEN 'BIG TEN'
		WHEN State IN ('Texas', 'Oklahoma')
			THEN 'BIG 12'
		ELSE 'Unknown'
	END
) AS 'Visited States', COUNT(*)
FROM tblStudent_STATE
GROUP BY (
	CASE
		WHEN State IN ('California', 'Oregon', 'Idaho')
			THEN 'FRIENDLY'
		WHEN State IN ('Michigan', 'Ohio', 'Indiana')
			THEN 'BIG TEN'
		WHEN State IN ('Texas', 'Oklahoma')
			THEN 'BIG 12'
		ELSE 'Unknown'
	END
) ORDER BY 'Visited State'