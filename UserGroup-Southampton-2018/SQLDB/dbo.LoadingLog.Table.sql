USE [sdbamsdapdev001]
GO
/****** Object:  Table [dbo].[LoadingLog]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoadingLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[ObjectId] [int] NOT NULL,
	[Status] [varchar](128) NULL,
	[LogDate] [datetime] NOT NULL,
 CONSTRAINT [PK_LoadingLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoadingLog] ADD  CONSTRAINT [DF_LoadingLog_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO
