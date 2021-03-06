USE [sdbamsdapdev001]
GO
/****** Object:  Table [dbo].[TransformProperties]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransformProperties](
	[PropertyId] [int] IDENTITY(1,1) NOT NULL,
	[PropertyName] [varchar](128) NOT NULL,
	[PropertyValue] [varchar](500) NULL,
	[PropertyDescription] [varchar](max) NULL,
 CONSTRAINT [PK_TransformProperties] PRIMARY KEY CLUSTERED 
(
	[PropertyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
