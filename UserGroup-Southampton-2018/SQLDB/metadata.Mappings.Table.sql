USE [sdbamsdapdev001]
GO
/****** Object:  Table [metadata].[Mappings]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [metadata].[Mappings](
	[MappingId] [int] IDENTITY(1,1) NOT NULL,
	[DataFlowId] [int] NOT NULL,
	[SourceSystemId] [int] NOT NULL,
	[SourceObjectId] [int] NOT NULL,
	[SourceAttributeId] [int] NOT NULL,
	[TargetSystemId] [int] NOT NULL,
	[TargetObjectId] [int] NOT NULL,
	[TargetAttributeId] [int] NOT NULL,
	[InUse] [bit] NOT NULL,
 CONSTRAINT [PK_Mappings] PRIMARY KEY CLUSTERED 
(
	[MappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [metadata].[Mappings] ADD  CONSTRAINT [DF_Mappings_InUse]  DEFAULT ((1)) FOR [InUse]
GO
ALTER TABLE [metadata].[Mappings]  WITH CHECK ADD  CONSTRAINT [FK_Mappings_Attributes_Source] FOREIGN KEY([SourceAttributeId])
REFERENCES [metadata].[Attributes] ([AttributeId])
GO
ALTER TABLE [metadata].[Mappings] CHECK CONSTRAINT [FK_Mappings_Attributes_Source]
GO
ALTER TABLE [metadata].[Mappings]  WITH CHECK ADD  CONSTRAINT [FK_Mappings_Attributes_Target] FOREIGN KEY([TargetAttributeId])
REFERENCES [metadata].[Attributes] ([AttributeId])
GO
ALTER TABLE [metadata].[Mappings] CHECK CONSTRAINT [FK_Mappings_Attributes_Target]
GO
ALTER TABLE [metadata].[Mappings]  WITH CHECK ADD  CONSTRAINT [FK_Mappings_DataFlows] FOREIGN KEY([DataFlowId])
REFERENCES [metadata].[DataFlows] ([DataFlowId])
GO
ALTER TABLE [metadata].[Mappings] CHECK CONSTRAINT [FK_Mappings_DataFlows]
GO
ALTER TABLE [metadata].[Mappings]  WITH CHECK ADD  CONSTRAINT [FK_Mappings_Objects_Source] FOREIGN KEY([SourceObjectId])
REFERENCES [metadata].[Objects] ([ObjectId])
GO
ALTER TABLE [metadata].[Mappings] CHECK CONSTRAINT [FK_Mappings_Objects_Source]
GO
ALTER TABLE [metadata].[Mappings]  WITH CHECK ADD  CONSTRAINT [FK_Mappings_Objects_Target] FOREIGN KEY([TargetObjectId])
REFERENCES [metadata].[Objects] ([ObjectId])
GO
ALTER TABLE [metadata].[Mappings] CHECK CONSTRAINT [FK_Mappings_Objects_Target]
GO
ALTER TABLE [metadata].[Mappings]  WITH CHECK ADD  CONSTRAINT [FK_Mappings_Systems_Source] FOREIGN KEY([SourceSystemId])
REFERENCES [metadata].[Systems] ([SystemId])
GO
ALTER TABLE [metadata].[Mappings] CHECK CONSTRAINT [FK_Mappings_Systems_Source]
GO
ALTER TABLE [metadata].[Mappings]  WITH CHECK ADD  CONSTRAINT [FK_Mappings_Systems_Target] FOREIGN KEY([TargetSystemId])
REFERENCES [metadata].[Systems] ([SystemId])
GO
ALTER TABLE [metadata].[Mappings] CHECK CONSTRAINT [FK_Mappings_Systems_Target]
GO
