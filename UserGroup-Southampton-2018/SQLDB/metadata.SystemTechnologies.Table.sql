USE [sdbamsdapdev001]
GO
/****** Object:  Table [metadata].[SystemTechnologies]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [metadata].[SystemTechnologies](
	[SystemTechId] [int] IDENTITY(1,1) NOT NULL,
	[TechnologyName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SystemTechnologies] PRIMARY KEY CLUSTERED 
(
	[SystemTechId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
