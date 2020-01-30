WITH cte AS
	(
	SELECT 
		[folder_name], 
		[project_name], 
		[package_name],
		AVG(DATEDIFF(MINUTE, [start_time], [end_time])) AS 'AvgExecuteTime'
	FROM 
		[internal].[execution_info]
	GROUP BY 
		[folder_name], 
		[project_name], 
		[package_name]
	)
SELECT
	fl.[name] + '/' + pj.[name] + '/' +	pk.[name] AS 'PackagePath'
FROM
	[catalog].[packages] pk 
	INNER JOIN [catalog].[projects] pj 
		ON pk.[project_id] = pj.[project_id]
	INNER JOIN [catalog].[folders] fl
		ON pj.[folder_id] = fl.[folder_id]
	--execute long running packages first
	LEFT OUTER JOIN cte
		ON fl.[name] = cte.[folder_name]
			AND pj.[name] = cte.[project_name]
			AND pk.[name] = cte.[package_name]
ORDER BY
	cte.[AvgExecuteTime] DESC