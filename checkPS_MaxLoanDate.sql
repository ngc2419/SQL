select TableName = '[BDE_Data].[dbo].[Portfolio_Summary]', Client, LoanDate = Max(loandate)  FROM [BDE_data].[dbo].[Portfolio_Summary] group by Client
select TableName = '[BDE_Data].[dbo].[Portfolio_Summary_Invvestor]',Client, LoanDate = Max(loandate)  FROM [BDE_Data].[dbo].[Portfolio_Summary_investor] group by Client
select TableName = '[BDESime].[dbo].[Portfolio_Summary_Type]',Client, LoanDate = Max(loandate) FROM [BDESime].[dbo].[Portfolio_Summary_Type] group by Client
--select TableName = '[BDESime].[dbo].[Portfolio_Summary_Type]',Client='',LoanDate=''
