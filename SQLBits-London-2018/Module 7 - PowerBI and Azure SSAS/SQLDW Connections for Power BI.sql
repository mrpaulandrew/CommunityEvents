SELECT 
	* 
FROM 
	sys.dm_pdw_exec_sessions 
WHERE
	[status] <> 'Closed' 
	AND [app_name] = 'Mashup Engine'