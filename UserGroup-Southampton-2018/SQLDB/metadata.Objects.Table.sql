USE [sdbamsdapdev001]
GO
/****** Object:  Table [metadata].[Objects]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [metadata].[Objects](
	[ObjectId] [int] IDENTITY(1,1) NOT NULL,
	[ObjectTypeId] [int] NOT NULL,
	[ObjectPrefix] [varchar](128) NULL,
	[ObjectName] [varchar](128) NOT NULL,
	[SystemId] [int] NOT NULL,
	[ObjectAdditions] [nvarchar](500) NULL,
	[InUse] [bit] NOT NULL,
 CONSTRAINT [PK_Objects] PRIMARY KEY CLUSTERED 
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [metadata].[Objects] ADD  CONSTRAINT [DF_Objects_InUse]  DEFAULT ((1)) FOR [InUse]
GO
ALTER TABLE [metadata].[Objects]  WITH CHECK ADD  CONSTRAINT [FK_Objects_ObjectTypes] FOREIGN KEY([ObjectTypeId])
REFERENCES [metadata].[ObjectTypes] ([ObjectTypeId])
GO
ALTER TABLE [metadata].[Objects] CHECK CONSTRAINT [FK_Objects_ObjectTypes]
GO
