USE [sdbamsdapdev001]
GO
/****** Object:  View [metadata].[TargetObjects]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [metadata].[TargetObjects]
AS

SELECT DISTINCT
	df.[DataFlowName],
	sot.[ObjectTypeName] AS 'TargetObjectType',
	so.[ObjectPrefix] AS 'TargetPrefix',
	so.[ObjectName] AS 'TargetObject',
	so.[ObjectAdditions] AS 'TargetObjectAdditions'
FROM
	[metadata].[Mappings] m
	INNER JOIN [metadata].[DataFlows] df
		ON m.[DataFlowId] = df.[DataFlowId]
	INNER JOIN [metadata].[Objects] so
		ON m.[TargetObjectId] = so.[ObjectId]
	INNER JOIN [metadata].[ObjectTypes] sot
		ON so.[ObjectTypeId] = sot.[ObjectTypeId]
GO
