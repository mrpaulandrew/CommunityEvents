USE [sdbamsdapdev001]
GO
/****** Object:  StoredProcedure [metadata].[CreateUSQLExtractMapOutput]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [metadata].[CreateUSQLExtractMapOutput]
	(
	@DataFlowName VARCHAR(255),
	@CodeSnippet NVARCHAR(MAX) OUTPUT,
	@DebugMode BIT = 0
	)
AS

SET NOCOUNT ON;

BEGIN
	/* for development:
	DECLARE @DataFlowName VARCHAR(255) = 'PatientsRawToBase'
	DECLARE @CodeSnippet NVARCHAR(MAX) 
	DECLARE @DebugMode BIT = 1
	*/

	--defensive checks
	IF NOT EXISTS
		(
		SELECT * FROM [metadata].[DataFlows] WHERE [DataFlowName] = @DataFlowName
		)
		BEGIN
			RAISERROR('Data flow name does not exist.',16,1);
			RETURN;
		END

	---------------------------------------------------------------------------------------------
	--									extractor field list
	---------------------------------------------------------------------------------------------
	DECLARE @FieldList NVARCHAR(MAX) = ''

	SELECT
		@FieldList += '[' + [SourceAttribute] + '] ' + [SourceDataType] + ',' + CHAR(13) + CHAR(9) + CHAR(9)
	FROM
		[metadata].[CompleteMappings]
	WHERE
		[DataFlowName] = @DataFlowName

	SET @FieldList = [metadata].[RemoveLastComma](@FieldList)

	---------------------------------------------------------------------------------------------
	--									extractor type, path and additions
	---------------------------------------------------------------------------------------------
	DECLARE @SourceObjectType VARCHAR(128)
	DECLARE @SourceObjectAdditions VARCHAR(128)
	DECLARE @SourceObjectPath VARCHAR(128)

	SELECT
		@SourceObjectType = [metadata].[UpperCaseFirstChar]([SourceObjectType]),
		@SourceObjectAdditions = ISNULL([SourceObjectAdditions],''),
		@SourceObjectPath = '/' + [SourcePrefix] + '/' + [SourceObject] + '.' + [SourceObjectType]
	FROM
		[metadata].[SourceObjects]
	WHERE
		[DataFlowName] = @DataFlowName

	---------------------------------------------------------------------------------------------
	--									mappings
	---------------------------------------------------------------------------------------------
	DECLARE @Mappings NVARCHAR(MAX) = ''

	SELECT
		@Mappings += '[' + [SourceAttribute] + '] AS ' + [TargetAttribute] + ',' + CHAR(13) + CHAR(9) + CHAR(9)
	FROM
		[metadata].[CompleteMappings]
	WHERE
		[DataFlowName] = @DataFlowName

	SET @Mappings = [metadata].[RemoveLastComma](@Mappings)

	---------------------------------------------------------------------------------------------
	--									outputter type, path and additions
	---------------------------------------------------------------------------------------------
	DECLARE @TargetObjectType VARCHAR(128)
	DECLARE @TargetObjectAdditions VARCHAR(128)
	DECLARE @TargetObjectPath VARCHAR(128)

	SELECT
		@TargetObjectType = [metadata].[UpperCaseFirstChar]([TargetObjectType]),
		@TargetObjectAdditions = ISNULL([TargetObjectAdditions],''),
		@TargetObjectPath = '/' + [TargetPrefix] + '/' + [TargetObject] + '.' + [TargetObjectType]
	FROM
		[metadata].[TargetObjects]
	WHERE
		[DataFlowName] = @DataFlowName

	---------------------------------------------------------------------------------------------
	--								create final USQL script
	---------------------------------------------------------------------------------------------
	DECLARE @USQL NVARCHAR(MAX)

	SELECT
		@USQL = sp.[Script],
		@USQL = REPLACE(@USQL,'<##SourceObjectPath##>',@SourceObjectPath),
		@USQL = REPLACE(@USQL,'<##TargetObjectPath##>',@TargetObjectPath),
		@USQL = REPLACE(@USQL,'<##SourceAttributes##>',@FieldList),
		@USQL = REPLACE(@USQL,'<##SourceObjectType##>',@SourceObjectType),
		@USQL = REPLACE(@USQL,'<##SourceObjectAdditions##>',@SourceObjectAdditions),
		@USQL = REPLACE(@USQL,'<##SourceToTargetAttributes##>',@Mappings),
		@USQL = REPLACE(@USQL,'<##TargetObjectType##>',@TargetObjectType),
		@USQL = REPLACE(@USQL,'<##TargetObjectAdditions##>',@TargetObjectAdditions),
		@CodeSnippet = @USQL
	FROM
		[metadata].[ScriptParts] sp
		INNER JOIN [metadata].[DataFlows] df
			ON sp.[ScriptId] = df.[ScriptId]
	WHERE
		df.[DataFlowName] = @DataFlowName
	
	IF @DebugMode = 1 EXEC [dbo].[usp_PrintBig] @USQL

END
GO
