USE [dbbiab]
GO

/****** Object:  Table [dbo].[tblComp]    Script Date: 02/13/2013 06:40:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblComp](
	[eid] [int] NOT NULL,
	[title-fr] [varchar](50) NOT NULL,
	[title-en] [varchar](50) NOT NULL,
	[lastDate] [varchar](50) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [tinyint] NULL,
	[publicStart] [varchar](max) NULL,
	[publicTemp] [varchar](max) NULL,
	[publicFinal] [nvarchar](max) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblEvents]    Script Date: 02/13/2013 06:41:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblEvents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name-fr] [varchar](50) NOT NULL,
	[name-en] [varchar](50) NOT NULL,
 CONSTRAINT [tblEvents_PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[TblResults]    Script Date: 02/13/2013 06:42:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TblResults](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[lastname] [varchar](50) NOT NULL,
	[firstname] [varchar](50) NOT NULL,
	[bibnumber] [tinyint] NOT NULL,
	[bibcolor] [tinyint] NULL,
	[class] [varchar](150) NULL,
	[club] [varchar](50) NULL,
	[ms1] [smallint] NULL,
	[ms2] [smallint] NULL,
	[ms3] [smallint] NULL,
	[ms4] [char](10) NULL,
	[lap1] [varchar](50) NULL,
	[lap2] [varchar](50) NULL,
	[lap3] [varchar](50) NULL,
	[lap4] [varchar](50) NULL,
	[runtime] [varchar](50) NULL,
	[penalty] [varchar](50) NULL,
	[finaltime] [varchar](50) NULL,
	[status] [varchar](50) NULL,
	[rank] [int] NULL,
	[starttime] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblUsers]    Script Date: 02/13/2013 06:42:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblUsers](
	[uid] [smallint] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[passwd] [varchar](50) NOT NULL,
	[admin] [smallint] NOT NULL,
	[enabled] [smallint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Index [main]    Script Date: 02/13/2013 06:42:20 ******/
CREATE NONCLUSTERED INDEX [main] ON [dbo].[tblUsers] 
(
	[uid] ASC,
	[username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/** INSERT DATA **/
SET IDENTITY_INSERT [dbbiab].[dbo].[tblUsers] ON
GO

INSERT INTO [dbbiab].[dbo].[tblUsers]([uid],[username],[passwd],[admin],[enabled]) VALUES(1,N'admin',N'Admin',1,1)
GO
print 'Inserted 1 records'

SET IDENTITY_INSERT [dbbiab].[dbo].[tblUsers] OFF
GO

SET IDENTITY_INSERT [dbbiab].[dbo].[tblEvents] ON
GO

INSERT INTO [dbbiab].[dbo].[tblEvents]([id],[name-fr],[name-en]) VALUES(2,N'Provincial 2013',N'Provincial 2013')
GO
print 'Inserted 1 records'

SET IDENTITY_INSERT [dbbiab].[dbo].[tblEvents] OFF
GO

SET IDENTITY_INSERT [dbbiab].[dbo].[tblComp] ON
GO

INSERT INTO [dbbiab].[dbo].[tblComp]([eid],[title-fr],[title-en],[lastDate],[id],[type],[publicStart],[publicTemp],[publicFinal]) VALUES(2,N'Départ de masse',N'Mass start',NULL,2,2,N'Aucune liste de départ | No start list',N'Aucun résultats | No results',N'Aucun résultats | No results')
INSERT INTO [dbbiab].[dbo].[tblComp]([eid],[title-fr],[title-en],[lastDate],[id],[type],[publicStart],[publicTemp],[publicFinal]) VALUES(2,N'Relais',N'Relay',NULL,3,1,N'Aucune liste de départ | No start list',N'Aucun résultats | No results',N'Aucun résultats | No results')
GO
print 'Inserted 2 records'

SET IDENTITY_INSERT [dbbiab].[dbo].[tblComp] OFF
GO




