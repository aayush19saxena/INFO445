USE aayush19_Lab2

CREATE TABLE PET_TYPE (
  PetTypeID   INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
  PetTypeName VARCHAR(50)                     NOT NULL
)

CREATE TABLE COUNTRY (
  CountryID   INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
  CountryName VARCHAR(50)                     NOT NULL
)

CREATE TABLE TEMPERAMENT (
  TempID   INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
  TempName VARCHAR(50)                     NOT NULL
)

CREATE TABLE GENDER (
  GenderID   INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
  GenderName VARCHAR(50)                     NOT NULL
)

ALTER TABLE Gender
  ALTER COLUMN GenderName VARCHAR(255)

ALTER TABLE Country
  ALTER COLUMN CountryName VARCHAR(255)

ALTER TABLE Gender
  ALTER COLUMN GenderName VARCHAR(255)

INSERT INTO PET_TYPE (PetTypeName)
  SELECT DISTINCT (PET_TYPE)
  FROM RAW_PetData

INSERT INTO GENDER (GenderName)
  SELECT DISTINCT (GENDER)
  FROM RAW_PetData

INSERT INTO TEMPERAMENT (TempName)
  SELECT DISTINCT (TEMPERAMENT)
  FROM RAW_PetData

SELECT *
FROM TEMPERAMENT

CREATE TABLE [dbo].[RAW_PetData_PK] (
  [PK_ID]       INT IDENTITY (1, 1) NOT NULL,
  [PETNAME]     [nvarchar](255)     NULL,
  [PET_TYPE]    [nvarchar](255)     NULL,
  [TEMPERAMENT] [nvarchar](255)     NULL,
  [COUNTRY]     [nvarchar](255)     NULL,
  [DATE_BIRTH]  [datetime]          NULL,
  [GENDER]      [nvarchar](255)     NULL
) ON [PRIMARY]
GO

INSERT INTO PET_TYPE (PetTypeName)
  SELECT DISTINCT (PET_TYPE)
  FROM RAW_PetData

INSERT INTO RAW_PetData_PK (PETNAME, PET_TYPE, TEMPERAMENT, COUNTRY, DATE_BIRTH, GENDER)
  SELECT
    PETNAME,
    PET_TYPE,
    TEMPERAMENT,
    COUNTRY,
    DATE_BIRTH,
    GENDER
  FROM RAW_PetData

CREATE PROCEDURE uspGetPetTypeID
    @PetTypeName  VARCHAR(255),
    @Pet_Type_ID2 INT OUTPUT AS
  SET @Pet_Type_ID2 = (SELECT PetTypeID
                       FROM PET_TYPE
                       WHERE PetTypeName = @PetTypeName)
GO

CREATE PROCEDURE uspGetCountryID
    @CountryName VARCHAR(255),
    @Country_ID2 INT OUTPUT AS
  SET @Country_ID2 = (SELECT CountryID
                      FROM Country
                      WHERE CountryName = @CountryName)
GO

CREATE PROCEDURE uspGetGenderID
    @GenderName VARCHAR(255),
    @Gender_ID2 INT OUTPUT AS
  SET @Gender_ID2 = (SELECT GenderID
                     FROM GENDER
                     WHERE GenderName = @GenderName)
GO

CREATE PROCEDURE uspGetTemperamentID
    @TempName VARCHAR(255),
    @Temp_ID2 INT OUTPUT AS
  SET @Temp_ID2 = (SELECT TempID
                   FROM TEMPERAMENT
                   WHERE TempName = @TempName)
GO

SELECT TOP 10 * FROM RAW_PetData_PK

DECLARE @PET_TYPE_ID INT
DECLARE @GENDER_ID INT
DECLARE @COUNTRY_ID INT
DECLARE @TEMP_ID INT
DECLARE @PETNAME VARCHAR(255)
DECLARE @DateOfBirth DATETIME
DECLARE @RUN INT = (SELECT COUNT(*) FROM RAW_PetData_PK)
DECLARE @ID INT = (SELECT Min(PK_ID) FROM RAW_PETDATA_PK)
DECLARE @PET_TYPE_NAME VARCHAR(255)
DECLARE @COUNTRY VARCHAR(255)
DECLARE @GENDER VARCHAR(255)
DECLARE @TEMPERAMENT VARCHAR(255)

WHILE (@RUN > 0)
  BEGIN
      SET @PETNAME = (SELECT PETNAME FROM RAW_PetData_PK WHERE PK_ID = @ID)
      SET @DateOfBirth = (SELECT DATE_BIRTH FROM RAW_PetData_PK WHERE PK_ID = @ID)
      SET @COUNTRY = (SELECT COUNTRY FROM RAW_PetData_PK WHERE PK_ID = @ID)
      SET @GENDER = (SELECT GENDER FROM RAW_PetData_PK WHERE PK_ID = @ID)
      SET @TEMPERAMENT = (SELECT TEMPERAMENT FROM RAW_PetData_PK WHERE PK_ID = @ID)
      SET @PET_TYPE_NAME = (SELECT PET_TYPE FROM RAW_PetData_PK WHERE PK_ID = @ID)
      PRINT @PET_TYPE_NAME

      IF @PETNAME IS NULL
        BEGIN
          PRINT 'Cannot process pet with no name'
          RAISERROR ('No pet.. no processing..yo', 11, 1)
          RETURN
        END

      IF @DateOfBirth IS NULL
        BEGIN
          PRINT 'Cannot process pet with no Date of Birth'
          RAISERROR ('No Date of birth.. no processing..yo', 11, 1)
          RETURN
        END


      EXEC uspGetCountryID @CountryName = @COUNTRY, @Country_ID2 = @COUNTRY_ID OUTPUT
      EXEC uspGetPetTypeID @PetTypeName = @PET_TYPE_NAME, @Pet_Type_ID2 = @PET_TYPE_ID OUTPUT
      EXEC uspGetGenderID @GenderName = @GENDER, @Gender_ID2 = @GENDER_ID OUTPUT
      EXEC uspGetTemperamentID @TempName = @TEMPERAMENT, @Temp_ID2 = @TEMP_ID OUTPUT

      IF @PET_TYPE_ID IS NULL
        BEGIN
          PRINT 'PetTypeID is NULL.. this is not good'
          RAISERROR ('code sucks.. we are done', 11, 1)
        END

      IF @COUNTRY_ID IS NULL
        BEGIN
          PRINT 'CountryID is NULL.. this is not good'
          RAISERROR ('code sucks.. we are done', 11, 1)
        END

      IF @TEMP_ID IS NULL
        BEGIN
          PRINT 'TemperamentID is NULL.. this is not good'
          RAISERROR ('code sucks.. we are done', 11, 1)
        END

      IF @GENDER_ID IS NULL
        BEGIN
          PRINT 'GenderID is NULL.. this is not good'
          RAISERROR ('code sucks.. we are done', 11, 1)
        END

      BEGIN TRAN
        INSERT INTO PET (PetTypeID, CountryId, TempID, GenderId, PetName, DOB)
        VALUES (@PET_TYPE_ID, @COUNTRY_ID, @TEMP_ID, @GENDER_ID, @PETNAME, @DateOfBirth)
          IF @@ERROR <> 0
            ROLLBACK TRAN
          ELSE
            COMMIT TRAN

      SET @RUN = @RUN - 1
      SET @ID = @ID + 1
  END
