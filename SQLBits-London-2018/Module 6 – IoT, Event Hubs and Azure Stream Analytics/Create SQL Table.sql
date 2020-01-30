
IF EXISTS
	(
	SELECT
		*
	FROM
		sys.tables
	WHERE
		[name] = 'PiSensorData'
	)
	DROP TABLE [dbo].[PiSensorData]
GO

CREATE TABLE [dbo].[PiSensorData]
	(
	[deviceid] [VARCHAR](50) NULL,
	[readingdatetime] [DATETIME] NULL,
	[sensorreading] [FLOAT] NULL,
	[sensortype] [VARCHAR](50) NULL
	)
GO