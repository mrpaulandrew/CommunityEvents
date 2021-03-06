USE [sdbamsdapdev001]
GO
/****** Object:  View [metadata].[CompleteMappings]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [metadata].[CompleteMappings]
AS

SELECT
	m.[MappingId],
	df.[DataFlowName],
	sst.[TechnologyName] AS 'SourceSystemTechnology',
	ss.[SystemName] AS 'SourceSystem',
	tst.[TechnologyName] AS 'TargetSystemTechnology',
	ts.[SystemName] AS 'TargetSystem',
	so.[ObjectPrefix] AS 'SourceObjectPrefix',
	sot.[ObjectTypeName] AS 'SourceObjectType',
	so.[ObjectName] AS 'SourceObject',
	tro.[ObjectPrefix] AS 'TargetObjectPrefix',
	tot.[ObjectTypeName] AS 'TargetObjectType',
	tro.[ObjectName] AS 'TargetObject',
	sa.[AttributeName] AS 'SourceAttribute',
	sa.[IsPK] AS 'SourcePrimaryKey',
	sa.[DataType] AS 'SourceDataType',
	ta.[AttributeName] AS 'TargetAttribute',
	ta.[DataType] AS 'TargetDataType',
	ta.[IsPK] AS 'TargetPrimaryKey'
FROM
	[metadata].[Mappings] m
	INNER JOIN [metadata].[DataFlows] df
		ON m.[DataFlowId] = df.[DataFlowId]
	INNER JOIN [metadata].[Systems] ss
		ON m.[SourceSystemId] = ss.[SystemId]
	INNER JOIN [metadata].[SystemTechnologies] sst
		ON ss.[SystemTechnologyId] = sst.[SystemTechId]
	INNER JOIN [metadata].[Systems] ts
		ON m.[TargetSystemId] = ts.[SystemId]
	INNER JOIN [metadata].[SystemTechnologies] tst
		ON ts.[SystemTechnologyId] = tst.[SystemTechId]
	INNER JOIN [metadata].[Objects] so
		ON m.[SourceObjectId] = so.[ObjectId]
	INNER JOIN [metadata].[ObjectTypes] sot
		ON so.[ObjectTypeId] = sot.[ObjectTypeId]
	INNER JOIN [metadata].[Objects] tro
		ON m.[TargetObjectId] = tro.[ObjectId]
	INNER JOIN [metadata].[ObjectTypes] tot
		ON tro.[ObjectTypeId] = tot.[ObjectTypeId]
	INNER JOIN [metadata].[Attributes] sa
		ON m.[SourceAttributeId] = sa.[AttributeId]
	INNER JOIN [metadata].[Attributes] ta
		ON m.[TargetAttributeId] = ta.[AttributeId]
GO
