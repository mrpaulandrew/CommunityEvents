USE [sdbamsdapdev001]
GO
/****** Object:  StoredProcedure [metadata].[GetUSQLStoredProcedure]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [metadata].[GetUSQLStoredProcedure]
	(
	@DataFlowName VARCHAR(255),
	@USQL NVARCHAR(MAX) OUTPUT,
	@DebugMode BIT = 0
	)
AS
BEGIN
	/*for development:
	DECLARE @DataFlowName VARCHAR(255) = 'PatientsRawToBase'
	DECLARE @USQL NVARCHAR(MAX) 
	DECLARE @DebugMode BIT = 1
	*/

	--checks
	IF NOT EXISTS
		(
		SELECT * FROM [metadata].[DataFlows] WHERE [DataFlowName] = @DataFlowName
		)
		BEGIN
			RAISERROR('Invalid data flow name provided.',16,1);
			RETURN;
		END
	
	--get script for data flow
	DECLARE @ScriptName VARCHAR(128)
	DECLARE @ProcedureBody NVARCHAR(MAX)

	SELECT
		@ScriptName = sp.[ScriptName]
	FROM 
		[metadata].[DataFlows] df
		INNER JOIN [metadata].[ScriptParts] sp
			ON df.[ScriptId] = sp.[ScriptId]
	WHERE 
		df.[DataFlowName] = @DataFlowName

	--create stored procedure body for script type
	IF @ScriptName = 'ExtractMapOutput'
		BEGIN
			EXEC [metadata].[CreateUSQLExtractMapOutput]
				@DataFlowName = @DataFlowName,
				@CodeSnippet = @ProcedureBody OUTPUT
		END
	ELSE IF @ScriptName = 'ExtractMapTable'
		BEGIN
			EXEC [metadata].[CreateUSQLExtractMapTable]
				@DataFlowName = @DataFlowName,
				@CodeSnippet = @ProcedureBody OUTPUT
		END
	ELSE IF @ScriptName = 'TableMapOutput'
		BEGIN
			EXEC [metadata].[CreateUSQLTableMapOutput]
				@DataFlowName = @DataFlowName,
				@CodeSnippet = @ProcedureBody OUTPUT
		END
 	ELSE IF @ScriptName = 'TableMapTable'
		BEGIN
			EXEC [metadata].[CreateUSQLTableMapTable]
				@DataFlowName = @DataFlowName,
				@CodeSnippet = @ProcedureBody OUTPUT
		END
 	ELSE IF @ScriptName = 'ExtractMergeTable'
		BEGIN
			EXEC [metadata].[CreateUSQLExtractMergeTable]
				@DataFlowName = @DataFlowName,
				@CodeSnippet = @ProcedureBody OUTPUT
		END
	ELSE
		BEGIN
			RAISERROR('No valid script available for data flow.',16,1)
			RETURN;
		END
	
	--wrap proc body with ddl code   
	SELECT
		@USQL = [Script],
		@USQL = REPLACE(@USQL,'<##TransformationSchema##>',[dbo].[GetProperty]('TransformationSchema')),
		@USQL = REPLACE(@USQL,'<##ProcedureName##>','usp_' + @DataFlowName),
		@USQL = REPLACE(@USQL,'<##CodeRefreshDate##>',CONVERT(VARCHAR,GETDATE(),103)),
		@USQL = REPLACE(@USQL,'<##CodeBody##>',@ProcedureBody)
	FROM
		[metadata].[ScriptParts]
	WHERE
		[ScriptName] = 'StoredProcedureWrapper'
	
	--add use database statement
	SELECT
		@USQL = [Script] + CHAR(13) + CHAR(13) + @USQL,
		@USQL = REPLACE(@USQL,'<##TransformationDB##>',[dbo].[GetProperty]('TransformationDB'))
	FROM
		[metadata].[ScriptParts]
	WHERE
		[ScriptName] = 'UseDatabase'

	IF @DebugMode = 1 EXEC [dbo].[usp_PrintBig] @USQL

END
GO
