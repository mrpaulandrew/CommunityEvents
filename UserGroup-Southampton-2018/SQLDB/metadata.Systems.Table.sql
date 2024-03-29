USE [sdbamsdapdev001]
GO
/****** Object:  Table [metadata].[Systems]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [metadata].[Systems](
	[SystemId] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](255) NOT NULL,
	[SystemTechnologyId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Systems_1] PRIMARY KEY CLUSTERED 
(
	[SystemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [metadata].[Systems] ADD  CONSTRAINT [DF_Systems_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [metadata].[Systems]  WITH CHECK ADD  CONSTRAINT [FK_Systems_SystemTechnologies] FOREIGN KEY([SystemTechnologyId])
REFERENCES [metadata].[SystemTechnologies] ([SystemTechId])
GO
ALTER TABLE [metadata].[Systems] CHECK CONSTRAINT [FK_Systems_SystemTechnologies]
GO
