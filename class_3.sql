/*
	
	Error Handling

	Throw vs Raise Error

	Throw automatically terminates the session

	IF @PROD_ID IS NULL
		BEGIN
			PRINT '@PROD Value not found'
			RAISERROR('@ProdID Cannot BE NULL; SESSION terminated, 11, 1')
			RETURN -- this terminates the sessions
		END

	Better version-
	IF @PROD_ID IS NULL
		BEGIN
			PRINT '@PROD Value not found'
			Throw '@ProdID cannot be NULL';
		END

	Why Error Handling?
		Anticipate Mistakes
			- People
			- Process

		Communicate
			- Let client know why there was an error
			- Security concern

		Fail Early: Avoid doing extra work
			- Avoid affecting other transactions 


	Processing Many to Many tables
		- What are the challenges?

	High Availability vs Scalibility 

		- HA: ability to process a transaction
			- Goal- 
				- Provide continuous use of mission-critical data
				- degrees of HA (NOT all or nothing)
				 - 99.9% = 8.7% hours of downtime / year

			- Measurement
				- Looks Alive
				- Is Alive
		- Scalability: increased connections/increased through put (num transactions / second)
			- Scale up
				- Addding hardware to a single node
				- Upgrading to a larger node

			- Scale Out
				- Adding more nodes
				- Spreading the data and workload among them
*/
