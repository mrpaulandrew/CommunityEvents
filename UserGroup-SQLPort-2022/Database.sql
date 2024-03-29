/****** Object:  Database [trainingdb01]    Script Date: 03/02/2022 16:03:40 ******/
CREATE DATABASE [trainingdb01]  (EDITION = 'GeneralPurpose', SERVICE_OBJECTIVE = 'GP_S_Gen5_1', MAXSIZE = 50 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS;
GO
ALTER DATABASE [trainingdb01] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [trainingdb01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [trainingdb01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [trainingdb01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [trainingdb01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [trainingdb01] SET ARITHABORT OFF 
GO
ALTER DATABASE [trainingdb01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [trainingdb01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [trainingdb01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [trainingdb01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [trainingdb01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [trainingdb01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [trainingdb01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [trainingdb01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [trainingdb01] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [trainingdb01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [trainingdb01] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [trainingdb01] SET  MULTI_USER 
GO
ALTER DATABASE [trainingdb01] SET ENCRYPTION ON
GO
ALTER DATABASE [trainingdb01] SET QUERY_STORE = ON
GO
ALTER DATABASE [trainingdb01] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/****** Object:  Schema [workers]    Script Date: 03/02/2022 16:03:40 ******/
CREATE SCHEMA [workers]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[BucketLog]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BucketLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[LogStartDate] [datetime] NOT NULL,
	[LogEndDate] [datetime] NULL,
	[LogDetail] [varchar](50) NULL,
 CONSTRAINT [PK_BucketLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BucketProcesses]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BucketProcesses](
	[ProcessId] [int] IDENTITY(1,1) NOT NULL,
	[ProcessName] [varchar](50) NOT NULL,
	[ProcessDetails] [varchar](500) NULL,
	[ObjectName] [nvarchar](128) NOT NULL,
	[ObjectParameters] [nvarchar](500) NULL,
	[Duration] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_BProcesses] PRIMARY KEY CLUSTERED 
(
	[ProcessId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Buckets]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buckets](
	[BucketId] [int] IDENTITY(1,1) NOT NULL,
	[BucketCode] [varchar](50) NOT NULL,
	[Details] [varchar](500) NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_Buckets] PRIMARY KEY CLUSTERED 
(
	[BucketId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BucketToProcessMap]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BucketToProcessMap](
	[BucketId] [int] NOT NULL,
	[ProcessId] [int] NOT NULL,
 CONSTRAINT [PK_BucketToProcessMap] PRIMARY KEY CLUSTERED 
(
	[BucketId] ASC,
	[ProcessId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataDump]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataDump](
	[SomeValue] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilesToUpload]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilesToUpload](
	[SourceDirectory] [nvarchar](max) NOT NULL,
	[TargetDirectory] [nvarchar](max) NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[Enabled] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderSummary]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderSummary](
	[SalesOrderNumber] [varchar](20) NOT NULL,
	[RecordCount] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UploadLog]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UploadLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[UploadStartDateTime] [datetime] NOT NULL,
	[UploadEndDateTime] [datetime] NULL,
	[FileUploadCount] [int] NULL,
	[TriggerId] [varchar](36) NULL,
 CONSTRAINT [PK_UploadLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BucketProcesses] ADD  CONSTRAINT [DF_BProcesses_Duration]  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[BucketProcesses] ADD  CONSTRAINT [DF_BProcesses_LastUpdated]  DEFAULT (getdate()) FOR [LastUpdated]
GO
ALTER TABLE [dbo].[BucketProcesses] ADD  CONSTRAINT [DF_BProcesses_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[Buckets] ADD  CONSTRAINT [DF_Buckets_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[BucketToProcessMap]  WITH CHECK ADD  CONSTRAINT [FK_BucketToProcessMap_BucketProcesses] FOREIGN KEY([ProcessId])
REFERENCES [dbo].[BucketProcesses] ([ProcessId])
GO
ALTER TABLE [dbo].[BucketToProcessMap] CHECK CONSTRAINT [FK_BucketToProcessMap_BucketProcesses]
GO
ALTER TABLE [dbo].[BucketToProcessMap]  WITH CHECK ADD  CONSTRAINT [FK_BucketToProcessMap_Buckets] FOREIGN KEY([BucketId])
REFERENCES [dbo].[Buckets] ([BucketId])
GO
ALTER TABLE [dbo].[BucketToProcessMap] CHECK CONSTRAINT [FK_BucketToProcessMap_Buckets]
GO
/****** Object:  StoredProcedure [dbo].[GetBucketContents]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBucketContents]
	(
	@BucketId INT
	)
AS

BEGIN
	SELECT 
		p.*
	FROM 
		[dbo].[BucketToProcessMap] m
		INNER JOIN [dbo].[BucketProcesses] p
			ON m.[ProcessId] = p.[ProcessId]
	WHERE
		m.[BucketId] = @BucketId
END
GO
/****** Object:  StoredProcedure [dbo].[GetBuckets]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBuckets]
AS

BEGIN
	SELECT [BucketId] FROM [dbo].[Buckets] WHERE [Enabled] = 1
END
GO
/****** Object:  StoredProcedure [dbo].[LogUploadFinish]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogUploadFinish]
	(
	@LogId INT
	)
AS
BEGIN

	UPDATE
		[dbo].[UploadLog]
	SET
		[UploadEndDateTime] = GETDATE()
	WHERE
		[LogId] = @LogId;

END;
GO
/****** Object:  StoredProcedure [dbo].[LogUploadStart]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogUploadStart]
	(
	@FileCount INT,
	@TriggerId VARCHAR(36)
	)
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO [dbo].[UploadLog]
		(
		[UploadStartDateTime],
		[FileUploadCount],
		[TriggerId]
		)
	VALUES
		(
		GETDATE(),
		@FileCount,
		@TriggerId
		)

	SELECT
		SCOPE_IDENTITY() AS LogId

END;


GO
/****** Object:  StoredProcedure [dbo].[SetBucketLogEntry]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SetBucketLogEntry]
	(
	@LogId INT = NULL
	)
AS

BEGIN

	IF @LogId IS NULL
	BEGIN

		TRUNCATE TABLE [dbo].[DataDump]
		TRUNCATE TABLE [dbo].[BucketLog]

		INSERT INTO [dbo].[BucketLog] ([LogStartDate], [LogDetail]) VALUES (GETDATE(), 'Running Scale Demo')

		SELECT SCOPE_IDENTITY() AS 'LogId'

	END
	ELSE
	BEGIN
		UPDATE
			[dbo].[BucketLog]
		SET
			[LogEndDate] = GETDATE()
		WHERE
			[LogId] = @LogId
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SetBucketProcesses]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SetBucketProcesses]
	(
	@DebugMode BIT = 0
	)
AS

BEGIN
	
	DELETE FROM [dbo].[BucketToProcessMap] 

	;WITH maxBuckets AS
		(
		SELECT MAX([BucketId]) AS 'MaxBucket' FROM [dbo].[Buckets]
		)

	INSERT INTO [dbo].[BucketToProcessMap] 
	SELECT
		CASE
			WHEN (ROW_NUMBER() OVER (ORDER BY p.[Duration] DESC) * 1) % maxBuckets.[MaxBucket] = 0 THEN maxBuckets.[MaxBucket]
			ELSE (ROW_NUMBER() OVER (ORDER BY p.[Duration] DESC) * 1) % maxBuckets.[MaxBucket]
		END AS 'NewBucketId',
		p.[ProcessId]
	FROM 
		[dbo].[BucketProcesses] p
		CROSS JOIN maxBuckets

	IF @DebugMode = 1
	BEGIN
		;WITH maxBuckets AS
			(
			SELECT MAX([BucketId]) AS 'MaxBucket' FROM [dbo].[Buckets]
			)
		SELECT
			CASE
				WHEN (ROW_NUMBER() OVER (ORDER BY p.[Duration] DESC) * 1) % maxBuckets.[MaxBucket] = 0 THEN maxBuckets.[MaxBucket]
				ELSE (ROW_NUMBER() OVER (ORDER BY p.[Duration] DESC) * 1) % maxBuckets.[MaxBucket]
			END AS 'NewBucketId',
			p.*
		FROM 
			[dbo].[BucketProcesses] p
			CROSS JOIN maxBuckets
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait1]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait1]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait10]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait10]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait100]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait100]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait101]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait101]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait102]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait102]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait103]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait103]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait104]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait104]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait105]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait105]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait106]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait106]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait107]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait107]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait108]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait108]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait109]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait109]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait11]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait11]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait110]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait110]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait111]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait111]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait112]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait112]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait113]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait113]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait114]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait114]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait115]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait115]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait116]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait116]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait117]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait117]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait118]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait118]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait119]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait119]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait12]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait12]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait120]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait120]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait121]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait121]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait122]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait122]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait123]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait123]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait124]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait124]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait125]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait125]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait126]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait126]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait127]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait127]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait128]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait128]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait129]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait129]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait13]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait13]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait130]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait130]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait131]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait131]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait132]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait132]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait133]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait133]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait134]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait134]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait135]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait135]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait136]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait136]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait137]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait137]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait138]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait138]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait139]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait139]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait14]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait14]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait140]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait140]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait141]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait141]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait142]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait142]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait143]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait143]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait144]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait144]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait145]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait145]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait146]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait146]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait147]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait147]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait148]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait148]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait149]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait149]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait15]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait15]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait150]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait150]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait151]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait151]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait152]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait152]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait153]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait153]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait154]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait154]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait155]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait155]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait156]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait156]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait157]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait157]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait158]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait158]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait159]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait159]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait16]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait16]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait160]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait160]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait161]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait161]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait162]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait162]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait163]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait163]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait164]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait164]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait165]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait165]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait166]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait166]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait167]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait167]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait168]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait168]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait169]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait169]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait17]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait17]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait170]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait170]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait171]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait171]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait172]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait172]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait173]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait173]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait174]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait174]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait175]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait175]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait176]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait176]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait177]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait177]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait178]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait178]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait179]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait179]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait18]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait18]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait180]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait180]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait181]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait181]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait182]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait182]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait183]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait183]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait184]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait184]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait185]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait185]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait186]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait186]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait187]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait187]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait188]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait188]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait189]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait189]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait19]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait19]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait190]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait190]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait191]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait191]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait192]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait192]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait193]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait193]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait194]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait194]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait195]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait195]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait196]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait196]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait197]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait197]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait198]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait198]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait199]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait199]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait2]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait2]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait20]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait20]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait200]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait200]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait201]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait201]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait202]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait202]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait203]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait203]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait204]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait204]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait205]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait205]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait206]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait206]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait207]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait207]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait208]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait208]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait209]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait209]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait21]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait21]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait210]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait210]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait211]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait211]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait212]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait212]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait213]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait213]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait214]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait214]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait215]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait215]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait216]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait216]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait217]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait217]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait218]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait218]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait219]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait219]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait22]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait22]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait220]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait220]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait221]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait221]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait222]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait222]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait223]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait223]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait224]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait224]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait225]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait225]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait226]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait226]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait227]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait227]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait228]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait228]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait229]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait229]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait23]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait23]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait230]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait230]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait231]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait231]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait232]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait232]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait233]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait233]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait234]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait234]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait235]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait235]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait236]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait236]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait237]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait237]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait238]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait238]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait239]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait239]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait24]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait24]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait240]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait240]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait241]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait241]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait242]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait242]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait243]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait243]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait244]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait244]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait245]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait245]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait246]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait246]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait247]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait247]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait248]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait248]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait249]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait249]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait25]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait25]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait250]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait250]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait251]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait251]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait252]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait252]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait253]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait253]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait254]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait254]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait255]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait255]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait256]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait256]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait257]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait257]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait258]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait258]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait259]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait259]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait26]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait26]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait260]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait260]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait261]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait261]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait262]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait262]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait263]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait263]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait264]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait264]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait265]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait265]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait266]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait266]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait267]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait267]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait268]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait268]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait269]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait269]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait27]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait27]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait270]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait270]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait271]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait271]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait272]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait272]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait273]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait273]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait274]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait274]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait275]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait275]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait276]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait276]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait277]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait277]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait278]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait278]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait279]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait279]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait28]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait28]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait280]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait280]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait281]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait281]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait282]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait282]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait283]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait283]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait284]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait284]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait285]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait285]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait286]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait286]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait287]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait287]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait288]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait288]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait289]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait289]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait29]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait29]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait290]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait290]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait291]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait291]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait292]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait292]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait293]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait293]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait294]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait294]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait295]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait295]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait296]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait296]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait297]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait297]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait298]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait298]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait299]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait299]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait3]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait3]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait30]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait30]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait300]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait300]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait301]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait301]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait302]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait302]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait303]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait303]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait304]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait304]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait305]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait305]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait306]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait306]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait307]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait307]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait308]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait308]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait309]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait309]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait31]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait31]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait310]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait310]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait311]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait311]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait312]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait312]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait313]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait313]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait314]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait314]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait315]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait315]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait316]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait316]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait317]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait317]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait318]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait318]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait319]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait319]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait32]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait32]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait320]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait320]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait321]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait321]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait322]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait322]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait323]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait323]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait324]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait324]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait325]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait325]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait326]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait326]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait327]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait327]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait328]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait328]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait329]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait329]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait33]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait33]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait330]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait330]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait331]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait331]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait332]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait332]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait333]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait333]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait334]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait334]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait335]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait335]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait336]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait336]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait337]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait337]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait338]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait338]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait339]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait339]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait34]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait34]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait340]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait340]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait341]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait341]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait342]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait342]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait343]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait343]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait344]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait344]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait345]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait345]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait346]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait346]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait347]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait347]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait348]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait348]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait349]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait349]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait35]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait35]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait350]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait350]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait351]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait351]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait352]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait352]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait353]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait353]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait354]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait354]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait355]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait355]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait356]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait356]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait357]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait357]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait358]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait358]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait359]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait359]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait36]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait36]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait360]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait360]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait361]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait361]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait362]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait362]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait363]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait363]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait364]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait364]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait365]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait365]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait366]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait366]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait367]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait367]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait368]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait368]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait369]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait369]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait37]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait37]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait370]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait370]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait371]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait371]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait372]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait372]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait373]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait373]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait374]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait374]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait375]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait375]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait376]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait376]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait377]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait377]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait378]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait378]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait379]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait379]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait38]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait38]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait380]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait380]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait381]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait381]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait382]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait382]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait383]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait383]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait384]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait384]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait385]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait385]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait386]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait386]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait387]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait387]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait388]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait388]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait389]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait389]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait39]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait39]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait390]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait390]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait391]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait391]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait392]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait392]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait393]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait393]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait394]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait394]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait395]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait395]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait396]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait396]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait397]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait397]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait398]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait398]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait399]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait399]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait4]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait4]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait40]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait40]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait400]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait400]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait401]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait401]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait402]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait402]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait403]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait403]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait404]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait404]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait405]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait405]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait406]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait406]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait407]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait407]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait408]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait408]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait409]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait409]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait41]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait41]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait410]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait410]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait411]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait411]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait412]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait412]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait413]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait413]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait414]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait414]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait415]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait415]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait416]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait416]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait417]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait417]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait418]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait418]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait419]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait419]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait42]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait42]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait420]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait420]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait421]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait421]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait422]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait422]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait423]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait423]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait424]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait424]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait425]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait425]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait426]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait426]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait427]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait427]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait428]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait428]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait429]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait429]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait43]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait43]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait430]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait430]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait431]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait431]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait432]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait432]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait433]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait433]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait434]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait434]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait435]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait435]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait436]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait436]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait437]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait437]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait438]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait438]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait439]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait439]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait44]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait44]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait440]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait440]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait441]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait441]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait442]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait442]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait443]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait443]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait444]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait444]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait445]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait445]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait446]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait446]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait447]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait447]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait448]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait448]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait449]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait449]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait45]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait45]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait450]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait450]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait451]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait451]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait452]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait452]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait453]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait453]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait454]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait454]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait455]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait455]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait456]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait456]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait457]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait457]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait458]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait458]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait459]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait459]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait46]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait46]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait460]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait460]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait461]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait461]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait462]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait462]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait463]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait463]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait464]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait464]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait465]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait465]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait466]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait466]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait467]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait467]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait468]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait468]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait469]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait469]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait47]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait47]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait470]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait470]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait471]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait471]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait472]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait472]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait473]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait473]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait474]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait474]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait475]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait475]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait476]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait476]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait477]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait477]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait478]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait478]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait479]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait479]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait48]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait48]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait480]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait480]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait481]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait481]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait482]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait482]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait483]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait483]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait484]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait484]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait485]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait485]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait486]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait486]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait487]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait487]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait488]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait488]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait489]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait489]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait49]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait49]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait490]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait490]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait491]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait491]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait492]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait492]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait493]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait493]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait494]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait494]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait495]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait495]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait496]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait496]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait497]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait497]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait498]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait498]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait499]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait499]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait5]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait5]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait50]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait50]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait500]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait500]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait51]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait51]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait52]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait52]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait53]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait53]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait54]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait54]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait55]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait55]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait56]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait56]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait57]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait57]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait58]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait58]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait59]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait59]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait6]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait6]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait60]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait60]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait61]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait61]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait62]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait62]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait63]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait63]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait64]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait64]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait65]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait65]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait66]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait66]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait67]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait67]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait68]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait68]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait69]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait69]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait7]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait7]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait70]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait70]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait71]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait71]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait72]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait72]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait73]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait73]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait74]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait74]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait75]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait75]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait76]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait76]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait77]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait77]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait78]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait78]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait79]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait79]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait8]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait8]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait80]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait80]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait81]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait81]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait82]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait82]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait83]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait83]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait84]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait84]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait85]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait85]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait86]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait86]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait87]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait87]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait88]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait88]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait89]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait89]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait9]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait9]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait90]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait90]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait91]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait91]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait92]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait92]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait93]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait93]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait94]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait94]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait95]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait95]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait96]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait96]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait97]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait97]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait98]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait98]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
/****** Object:  StoredProcedure [workers].[DumpDataAndWait99]    Script Date: 03/02/2022 16:03:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [workers].[DumpDataAndWait99]
	(
	@SecondWait TINYINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Delay VARCHAR(8)
	SELECT
		@Delay = '00:00:0' + LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1)

	INSERT INTO [dbo].[DataDump] 
		(
		[SomeValue]
		)
	SELECT TOP 1
		[stopword]
	FROM 
		sys.fulltext_system_stopwords 
	WHERE 
		[language_id] = 1033
	ORDER BY
		NEWID()

	WAITFOR DELAY @Delay

END
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
ALTER DATABASE [trainingdb01] SET  READ_WRITE 
GO
