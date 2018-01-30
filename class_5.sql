/*
	Disaster Recovery

	use master 
	RETORE DATABASE A_New _Name
	FROM DISK = 'C:\SQL\SomeBackupTodayIsJan23.bak'

	BACKUP LOG blah
	TO DISK = 'C:\SQL\...'

	Full backup- complete..All data, all schema, all objects.. etc.
	Differential- Delta since the last full backup.
	Log- is the delta since the last backup of anykind

	Why backup?
	- Disaster recovery
	- we populate the data from different environments (test, stage, dev) so we can run it against the same data


	---------------------------------

	SELECT top 3000000 
	INTO PHAN_CLUB
	FROM  [IS-Hay04.ischool.uw.edu].CUSTOMER_BUILD.dbo.tblCUSTOMER

	CREATE DATABASE aayush19_Lab2

	USE aayush19_Lab2

	Tasks > Import Data > 
*/