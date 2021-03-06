USE [BDESime]
GO
ALTER proc sp_testfile as
;WITH L90_973 AS (
				SELECT [LoanNumber]
					  ,[TriggerCode] 
					  ,[TriggerDate] = max([TriggerDate])
				  FROM [BDESime].[dbo].[testFile]
				 GROUP BY [LoanNumber]
						 ,[TriggerCode]
			)
   ,Tie AS (
			SELECT [LoanNumber]
					  ,[TriggerDate] = max([TriggerDate])
				  FROM L90_973
				 GROUP BY [LoanNumber]
			)
	SELECT t.LoanNumber
		  ,s.TriggerDate
		  -- 1/3/2018 per Ken Ly, 973 is the tie breaker for Short Sale claims 
		  ,TriggerCode = min(s.TriggerCode)  
		  FROM Tie t 
  		  JOIN L90_973 s on t.LoanNumber = s.LoanNumber and t.TriggerDate = s.TriggerDate
		 GROUP BY t.[LoanNumber]
				 ,s.TriggerDate
		ORDER BY t.[LoanNumber]						 

		/* -- select count(distinct loannumber) from testFile    --> 6 rows
		SELECT * 
		FROM [BDESime].[dbo].[testFile]
		ORDER BY [LoanNumber]
		*/

	--  select [loan number] 
	--	 ,[TriggerDate] = max(ls1.[ls actual completion date])
	--	 ,[TriggerCode] = min(ls1.[ls step code])
	-- from bdesime.dbo.testFile ls1  (nolock)
	-- where ls1.[ls step code] IN ('L90','973')
	--  --and [loan number] in (0000994228,0000997429,0001007566,0001066380,0001318161,0001586841)
	--  and [loan number] = '0001007566'
	--group by [loan number]
