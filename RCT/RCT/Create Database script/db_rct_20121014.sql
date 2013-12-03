
--Create database

USE [master]
GO
IF NOT EXISTS (SELECT [name] FROM sys.databases WHERE name = N'dbrct')
BEGIN
CREATE DATABASE [dbrct] COLLATE French_CI_AS
END
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'dbrct', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
	EXEC [dbrct].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO
ALTER DATABASE [dbrct] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [dbrct] SET ANSI_NULLS OFF
GO
ALTER DATABASE [dbrct] SET ANSI_PADDING OFF
GO
ALTER DATABASE [dbrct] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [dbrct] SET ARITHABORT OFF
GO
ALTER DATABASE [dbrct] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [dbrct] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [dbrct] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [dbrct] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [dbrct] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [dbrct] SET CURSOR_DEFAULT GLOBAL
GO
ALTER DATABASE [dbrct] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [dbrct] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [dbrct] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [dbrct] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [dbrct] SET DISABLE_BROKER
GO
ALTER DATABASE [dbrct] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [dbrct] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [dbrct] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [dbrct] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [dbrct] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [dbrct] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [dbrct] SET READ_WRITE
GO
ALTER DATABASE [dbrct] SET RECOVERY SIMPLE
GO
ALTER DATABASE [dbrct] SET MULTI_USER
GO
ALTER DATABASE [dbrct] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [dbrct] SET DB_CHAINING OFF
GO

USE [dbrct]
GO

--Create Users
USE [dbrct]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE [name] = N'dbrct')
	CREATE USER [dbrct] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo];
GO

--Create Roles
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'public' AND type = 'R')
	CREATE ROLE [public] AUTHORIZATION [dbo]
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLAdminRCT' AND type = 'R')
	CREATE ROLE [SQLAdminRCT] AUTHORIZATION [dbo]
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SQLUserOnlyRCT' AND type = 'R')
	CREATE ROLE [SQLUserOnlyRCT] AUTHORIZATION [dbo]
GO

--Add Users To Roles
USE [dbrct]
GO
EXEC sp_addrolemember N'db_owner', N'dbrct'
GO

--Database Schemas

USE [dbrct]
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dbo')
EXEC sys.sp_executesql N'CREATE SCHEMA [dbo] AUTHORIZATION [dbo]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'guest')
EXEC sys.sp_executesql N'CREATE SCHEMA [guest] AUTHORIZATION [guest]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'INFORMATION_SCHEMA')
EXEC sys.sp_executesql N'CREATE SCHEMA [INFORMATION_SCHEMA] AUTHORIZATION [INFORMATION_SCHEMA]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'sys')
EXEC sys.sp_executesql N'CREATE SCHEMA [sys] AUTHORIZATION [sys]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_owner')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_owner] AUTHORIZATION [db_owner]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_accessadmin')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_accessadmin] AUTHORIZATION [db_accessadmin]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_securityadmin')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_securityadmin] AUTHORIZATION [db_securityadmin]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_ddladmin')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_ddladmin] AUTHORIZATION [db_ddladmin]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_backupoperator')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_backupoperator] AUTHORIZATION [db_backupoperator]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_datareader')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_datareader] AUTHORIZATION [db_datareader]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_datawriter')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_datawriter] AUTHORIZATION [db_datawriter]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_denydatareader')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_denydatareader] AUTHORIZATION [db_denydatareader]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_denydatawriter')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_denydatawriter] AUTHORIZATION [db_denydatawriter]'
GO

--Table dbo.tblChaptersRelays

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblChaptersRelays] (
	[chapterRelayId] [int] NOT NULL IDENTITY (1, 1),
	[chapterRelayNumber] [tinyint] NULL,
	[chapterRelayTargetsNumbers] [varchar](50) NULL,
	[fkCompetitionChapterId] [smallint] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblChaptersRelays] ON
GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (1, 1, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (2, 2, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (3, 3, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (4, 4, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (5, 5, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (6, 6, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (7, 7, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (8, 8, N'1;2', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (9, 9, N'3;4', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (10, 10, N'3;4', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (11, 11, N'3;4', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (12, 12, N'3;4', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (13, 13, N'3;4', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (14, 14, N'3;4', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (15, 15, N'3;4', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (16, 16, N'5;6', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (17, 17, N'5;6', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (18, 18, N'5;6', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (19, 19, N'5;6', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (20, 20, N'5;6', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (21, 21, N'5;6', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (22, 22, N'5;6', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (23, 23, N'7', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (24, 24, N'7', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (25, 25, N'7', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (26, 26, N'7', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (27, 27, N'7', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (28, 28, N'7', 21)

GO
INSERT INTO [dbo].[tblChaptersRelays] ([chapterRelayId], [chapterRelayNumber], [chapterRelayTargetsNumbers], [fkCompetitionChapterId])
	VALUES (29, 29, N'7', 21)

GO
SET IDENTITY_INSERT [dbo].[tblChaptersRelays] OFF
GO

--Table dbo.tblCompetitions

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblCompetitions] (
	[competitionId] [int] NOT NULL IDENTITY (1, 1),
	[competitionNameFr] [varchar](50) NULL,
	[competitionNameEn] [varchar](50) NULL,
	[fkEventId] [int] NOT NULL);
GO

SET IDENTITY_INSERT [dbo].[tblCompetitions] ON
GO
INSERT INTO [dbo].[tblCompetitions] ([competitionId], [competitionNameFr], [competitionNameEn], [fkEventId])
	VALUES (47, N'Résultats', N'Results', 38)

GO
INSERT INTO [dbo].[tblCompetitions] ([competitionId], [competitionNameFr], [competitionNameEn], [fkEventId])
	VALUES (48, N'Finale', N'Final', 38)

GO
INSERT INTO [dbo].[tblCompetitions] ([competitionId], [competitionNameFr], [competitionNameEn], [fkEventId])
	VALUES (49, N'Qualifications', N'Qualifications', 39)

GO
INSERT INTO [dbo].[tblCompetitions] ([competitionId], [competitionNameFr], [competitionNameEn], [fkEventId])
	VALUES (50, N'Finale', N'Final', 39)

GO
SET IDENTITY_INSERT [dbo].[tblCompetitions] OFF
GO

--Table dbo.tblCompetitionsChapters

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblCompetitionsChapters] (
	[competitionChapterId] [smallint] NOT NULL IDENTITY (1, 1),
	[competitionChapterNameFr] [varchar](50) NULL,
	[competitionChapterNameEn] [nvarchar](50) NULL,
	[competitionChapterValue] [float] NOT NULL,
	[competitionChapterNbrTargets] [tinyint] NULL,
	[fkCompetitionTypeId] [tinyint] NOT NULL,
	[fkCompetitionId] [int] NOT NULL);
GO

SET IDENTITY_INSERT [dbo].[tblCompetitionsChapters] ON
GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (17, N'Tir Debout', N'Standing Shooting', CAST ('0.1111' AS float), 4, 1, 47)

GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (18, N'Tir Coucher', N'Prone Shooting', CAST ('0.8889' AS float), 6, 2, 47)

GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (19, N'Tir Debout', N'Standing Shooting', CAST ('0.1111' AS float), 1, 1, 48)

GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (20, N'Tir Coucher', N'Prone Shooting', CAST ('0.8889' AS float), 2, 2, 48)

GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (21, N'Tir Debout', N'Standing Shooting', CAST ('0.1111' AS float), 7, 1, 49)

GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (22, N'Tir Coucher', N'Prone Shooting', CAST ('0.8889' AS float), 14, 2, 49)

GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (23, N'Tir Debout', N'Standing Shooting', CAST ('0.1111' AS float), 10, 1, 50)

GO
INSERT INTO [dbo].[tblCompetitionsChapters] ([competitionChapterId], [competitionChapterNameFr], [competitionChapterNameEn], [competitionChapterValue], [competitionChapterNbrTargets], [fkCompetitionTypeId], [fkCompetitionId])
	VALUES (24, N'Tir Coucher', N'Prone Shooting', CAST ('0.8889' AS float), 20, 2, 50)

GO
SET IDENTITY_INSERT [dbo].[tblCompetitionsChapters] OFF
GO

--Table dbo.tblCompetitionsTypes

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblCompetitionsTypes] (
	[competitionTypeId] [tinyint] NOT NULL IDENTITY (1, 1),
	[competitionTypeNameFr] [varchar](50) NULL,
	[competitionTypeNameEn] [varchar](50) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblCompetitionsTypes] ON
GO
INSERT INTO [dbo].[tblCompetitionsTypes] ([competitionTypeId], [competitionTypeNameFr], [competitionTypeNameEn])
	VALUES (1, N'Debout', N'Standing')

GO
INSERT INTO [dbo].[tblCompetitionsTypes] ([competitionTypeId], [competitionTypeNameFr], [competitionTypeNameEn])
	VALUES (2, N'Coucher', N'Prone')

GO
SET IDENTITY_INSERT [dbo].[tblCompetitionsTypes] OFF
GO

--Table dbo.tblCompetitorsCategories

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblCompetitorsCategories] (
	[competitorCategoryId] [tinyint] NOT NULL IDENTITY (1, 1),
	[competitorCategoryNameFr] [varchar](50) NULL,
	[competitorCategoryNameEn] [varchar](50) NULL,
	[competitorCategoryLetterFr] [char](10) NULL,
	[competitorCategoryLetterEn] [char](10) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblCompetitorsCategories] ON
GO
INSERT INTO [dbo].[tblCompetitorsCategories] ([competitorCategoryId], [competitorCategoryNameFr], [competitorCategoryNameEn], [competitorCategoryLetterFr], [competitorCategoryLetterEn])
	VALUES (1, N'Junior', N'Junior', N'JR        ', N'JR        ')

GO
INSERT INTO [dbo].[tblCompetitorsCategories] ([competitorCategoryId], [competitorCategoryNameFr], [competitorCategoryNameEn], [competitorCategoryLetterFr], [competitorCategoryLetterEn])
	VALUES (2, N'Ouvert', N'Open', N'OU        ', N'OP        ')

GO
SET IDENTITY_INSERT [dbo].[tblCompetitorsCategories] OFF
GO

--Table dbo.tblEvents

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblEvents] (
	[eventId] [int] NOT NULL IDENTITY (1, 1),
	[eventNameFr] [varchar](250) NULL,
	[eventNameEn] [varchar](250) NULL,
	[eventStartDate] [datetime] NULL,
	[eventEndDate] [datetime] NULL,
	[eventLocation] [varchar](250) NULL,
	[fkEventTypeId] [tinyint] NULL,
	[eventShowPublicResults] [bit] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblEvents] ON
GO
INSERT INTO [dbo].[tblEvents] ([eventId], [eventNameFr], [eventNameEn], [eventStartDate], [eventEndDate], [eventLocation], [fkEventTypeId], [eventShowPublicResults])
	VALUES (38, N'Championnat Provincial de Tir 2012 - URSC(E)', N'Provincial Marksmanship 2012 - RCSU(E)', CAST(0x0000a03a00000000 AS datetime), CAST(0x0000a03b00000000 AS datetime), N'Trois-Rivières', 2, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblEvents] ([eventId], [eventNameFr], [eventNameEn], [eventStartDate], [eventEndDate], [eventLocation], [fkEventTypeId], [eventShowPublicResults])
	VALUES (39, N'Championnat National de Tir 2012', N'National Marksmanship 2012', CAST(0x0000a04800000000 AS datetime), CAST(0x0000a04f00000000 AS datetime), N'Valcartier', 1, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblEvents] ([eventId], [eventNameFr], [eventNameEn], [eventStartDate], [eventEndDate], [eventLocation], [fkEventTypeId], [eventShowPublicResults])
	VALUES (40, N'Test National', N'National Test', CAST(0x0000a05200000000 AS datetime), CAST(0x0000a05500000000 AS datetime), N'Valcartier', 1, CAST ('False' AS bit))

GO
SET IDENTITY_INSERT [dbo].[tblEvents] OFF
GO

--Table dbo.tblEventsTypes

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblEventsTypes] (
	[eventTypeId] [tinyint] NOT NULL IDENTITY (1, 1),
	[eventTypeNameFr] [varchar](50) NULL,
	[eventTypeNameEn] [varchar](50) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblEventsTypes] ON
GO
INSERT INTO [dbo].[tblEventsTypes] ([eventTypeId], [eventTypeNameFr], [eventTypeNameEn])
	VALUES (1, N'National', N'National')

GO
INSERT INTO [dbo].[tblEventsTypes] ([eventTypeId], [eventTypeNameFr], [eventTypeNameEn])
	VALUES (2, N'Provincial', N'Provincial')

GO
INSERT INTO [dbo].[tblEventsTypes] ([eventTypeId], [eventTypeNameFr], [eventTypeNameEn])
	VALUES (3, N'Zone', N'Zone')

GO
SET IDENTITY_INSERT [dbo].[tblEventsTypes] OFF
GO

--Table dbo.tblFinalsLines

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblFinalsLines] (
	[finalLineId] [int] NOT NULL IDENTITY (1, 1),
	[fkTeamCompetitorId] [int] NULL,
	[fkCompetitionChapterId] [smallint] NULL,
	[finalLine] [tinyint] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblFinalsLines] ON
GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (21, 296, 22, 1)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (22, 297, 22, 2)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (23, 298, 22, 3)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (24, 299, 22, 4)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (25, 320, 22, 5)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (26, 321, 22, 6)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (27, 322, 22, 7)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (28, 323, 22, 8)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (29, 324, 22, 9)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (30, 325, 22, 10)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (115, 299, 23, 1)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (116, 326, 23, 2)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (117, 327, 23, 3)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (118, 328, 23, 4)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (119, 329, 23, 5)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (120, 299, 24, 1)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (121, 326, 24, 2)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (122, 327, 24, 3)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (123, 328, 24, 4)

GO
INSERT INTO [dbo].[tblFinalsLines] ([finalLineId], [fkTeamCompetitorId], [fkCompetitionChapterId], [finalLine])
	VALUES (124, 329, 24, 5)

GO
SET IDENTITY_INSERT [dbo].[tblFinalsLines] OFF
GO

--Table dbo.tblGenders

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblGenders] (
	[genderId] [tinyint] NOT NULL IDENTITY (1, 1),
	[genderNameFr] [varchar](50) NULL,
	[genderNameEn] [varchar](50) NULL,
	[genderLetter] [char](10) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblGenders] ON
GO
INSERT INTO [dbo].[tblGenders] ([genderId], [genderNameFr], [genderNameEn], [genderLetter])
	VALUES (1, N'Masculin', N'Male', N'M         ')

GO
INSERT INTO [dbo].[tblGenders] ([genderId], [genderNameFr], [genderNameEn], [genderLetter])
	VALUES (2, N'Féminin', N'Female', N'F         ')

GO
SET IDENTITY_INSERT [dbo].[tblGenders] OFF
GO

--Table dbo.tblLanguages

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblLanguages] (
	[languageId] [tinyint] NOT NULL IDENTITY (1, 1),
	[languageNameFr] [varchar](10) NULL,
	[languageNameEn] [varchar](10) NULL,
	[languageLetter] [varchar](2) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblLanguages] ON
GO
INSERT INTO [dbo].[tblLanguages] ([languageId], [languageNameFr], [languageNameEn], [languageLetter])
	VALUES (1, N'Français', N'French', N'FR')

GO
INSERT INTO [dbo].[tblLanguages] ([languageId], [languageNameFr], [languageNameEn], [languageLetter])
	VALUES (2, N'Anglais', N'English', N'EN')

GO
SET IDENTITY_INSERT [dbo].[tblLanguages] OFF
GO

--Table dbo.tblParamsNumeric

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblParamsNumeric] (
	[paramId] [smallint] NOT NULL IDENTITY (1, 1),
	[paramName] [varchar](50) NULL,
	[paramValue] [float] NULL,
	[fkEventIdRestricted] [int] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblParamsNumeric] ON
GO
INSERT INTO [dbo].[tblParamsNumeric] ([paramId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (1, N'DefaultChapterProneValue', CAST ('0.8889' AS float), 0)

GO
INSERT INTO [dbo].[tblParamsNumeric] ([paramId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (2, N'DefaultChapterStandingValue', CAST ('0.1111' AS float), 0)

GO
INSERT INTO [dbo].[tblParamsNumeric] ([paramId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (3, N'HeightTableMenuLeft', CAST ('500' AS float), 0)

GO
INSERT INTO [dbo].[tblParamsNumeric] ([paramId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (4, N'AutoRefreshTime', CAST ('10' AS float), 0)

GO
INSERT INTO [dbo].[tblParamsNumeric] ([paramId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (5, N'PublicAutoRefreshTime', CAST ('20' AS float), 0)

GO
SET IDENTITY_INSERT [dbo].[tblParamsNumeric] OFF
GO

--Table dbo.tblParamsTexts

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblParamsTexts] (
	[paramTextId] [smallint] NOT NULL IDENTITY (1, 1),
	[paramName] [varchar](50) NULL,
	[paramValue] [text] NULL,
	[fkEventIdRestricted] [int] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblParamsTexts] ON
GO
INSERT INTO [dbo].[tblParamsTexts] ([paramTextId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (1, N'DefaultChapterNameFrProne', N'Tir Coucher', 0)

GO
INSERT INTO [dbo].[tblParamsTexts] ([paramTextId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (2, N'DefaultChapterNameFrStanding', N'Tir Debout', 0)

GO
INSERT INTO [dbo].[tblParamsTexts] ([paramTextId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (3, N'DefaultChapterNameEnProne', N'Prone Shooting', 0)

GO
INSERT INTO [dbo].[tblParamsTexts] ([paramTextId], [paramName], [paramValue], [fkEventIdRestricted])
	VALUES (4, N'DefaultChapterNameEnStanding', N'Standing Shooting', 0)

GO
SET IDENTITY_INSERT [dbo].[tblParamsTexts] OFF
GO

--Table dbo.tblPublicHtmlTexts

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblPublicHtmlTexts] (
	[publicHtmlTextId] [int] NOT NULL IDENTITY (1, 1),
	[publicHtmlTextName] [varchar](50) NOT NULL,
	[publicHtmlText] [text] NULL,
	[publicHtmlTextDateTime] [datetime] NULL,
	[fkEventId] [int] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblPublicHtmlTexts] ON
GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (9, N'eid-39_rid-29_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Prince Edward Island&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;&#206;le-du-Prince-&#201;douard</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:42 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177ed54 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (10, N'eid-39_rid-5_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Manitoba&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Manitoba</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 <tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="20" class="TXTResultsBlack" style="font-weight:bold;" bgcolor="#d7d7d7">Team / &Eacute;quipe : MA-U-01</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td width="139" height="40" class="TXTResultsBlack">Competitors<br />Comp&eacute;titeurs</td>
    <td class="LineVertico1PX"></td>
    <td width="114" class="TXTResultsBlack">Position</td>
    <td class="LineVertico2PX"></td>
    <td width="54" class="TXTResultsBlack">Targets<br />Cibles</td>
    <td class="LineVertico1PX"></td>
    <td width="60" class="TXTResultsBlack">Score<br />Pointage</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">%</td>
    <td class="LineVertico1PX"></td>
    <td width="54" style="text-align:center;" bgcolor="#d7d7d7"><span class="TXTResultsRed">89%</span><br /><span class="TXTResultsBlue">11%</span><br /><span class="TXTResultsBlack"><b>100%</b></span></td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Open<br />Ouvert<br />/20</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Junior<br />/5</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>

<tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>0,00</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">6</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">20</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>20</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>0,00</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">5</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">19</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>19</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>0,00</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">4</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">18</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>18</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>0,00</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">3</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">17</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>17</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>0,00</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">2</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">16</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>16</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:21 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177d4f1 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (11, N'eid-39_rid-28_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Alberta&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Alberta</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 <tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="20" class="TXTResultsBlack" style="font-weight:bold;" bgcolor="#d7d7d7">Team / &Eacute;quipe : AB-U-01</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td width="139" height="40" class="TXTResultsBlack">Competitors<br />Comp&eacute;titeurs</td>
    <td class="LineVertico1PX"></td>
    <td width="114" class="TXTResultsBlack">Position</td>
    <td class="LineVertico2PX"></td>
    <td width="54" class="TXTResultsBlack">Targets<br />Cibles</td>
    <td class="LineVertico1PX"></td>
    <td width="60" class="TXTResultsBlack">Score<br />Pointage</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">%</td>
    <td class="LineVertico1PX"></td>
    <td width="54" style="text-align:center;" bgcolor="#d7d7d7"><span class="TXTResultsRed">89%</span><br /><span class="TXTResultsBlue">11%</span><br /><span class="TXTResultsBlack"><b>100%</b></span></td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Open<br />Ouvert<br />/20</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Junior<br />/5</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>

<tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;Shooter 5<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">141</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">70,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">7,83</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>7,83</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">17</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">6</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>7</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">3</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">1</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>2</b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;Shooter 2<br />&nbsp;M&#233;lanie</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">189</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">94,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">10,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>10,50</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">20</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">1</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>2</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;Shooter 3<br />&nbsp;Alain</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">107</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">53,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">5,94</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>5,94</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">19</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">13</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>13</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">5</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">4</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>4</b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;Shooter 4<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">92</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">46,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">5,11</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>5,11</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">18</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>14</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">4</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">5</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>5</b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;Shooter 1<br />&nbsp;Denis</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">1/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">67</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">137</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">67,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">68,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">59,56</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">7,61</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>67,17</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">1</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">8</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>1</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">1</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>1</b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:38 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177e904 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (12, N'eid-39_rid-9_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">New Bunswick&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Nouveau-Brunswick</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:24 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177d7d0 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (13, N'eid-39_rid-8_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">British Columbia&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Colombie-Britannique</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 <tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="20" class="TXTResultsBlack" style="font-weight:bold;" bgcolor="#d7d7d7">Team / &Eacute;quipe : BC-U-01</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td width="139" height="40" class="TXTResultsBlack">Competitors<br />Comp&eacute;titeurs</td>
    <td class="LineVertico1PX"></td>
    <td width="114" class="TXTResultsBlack">Position</td>
    <td class="LineVertico2PX"></td>
    <td width="54" class="TXTResultsBlack">Targets<br />Cibles</td>
    <td class="LineVertico1PX"></td>
    <td width="60" class="TXTResultsBlack">Score<br />Pointage</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">%</td>
    <td class="LineVertico1PX"></td>
    <td width="54" style="text-align:center;" bgcolor="#d7d7d7"><span class="TXTResultsRed">89%</span><br /><span class="TXTResultsBlue">11%</span><br /><span class="TXTResultsBlack"><b>100%</b></span></td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Open<br />Ouvert<br />/20</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Junior<br />/5</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>

<tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">171</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">85,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">9,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>9,50</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">16</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>3</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">165</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">82,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">9,17</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>9,17</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">15</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">3</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>4</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">139</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">69,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">7,72</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>7,72</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>8</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">114</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">57,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">6,33</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>6,33</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">13</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">12</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>12</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">80</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">40,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">4,44</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>4,44</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">12</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">15</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>15</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>

<tr>
    <td colspan="17" class="LineHorizo2PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="20" class="TXTResultsBlack" style="font-weight:bold;" bgcolor="#d7d7d7">Team / &Eacute;quipe : BC-C-01</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td width="139" height="40" class="TXTResultsBlack">Competitors<br />Comp&eacute;titeurs</td>
    <td class="LineVertico1PX"></td>
    <td width="114" class="TXTResultsBlack">Position</td>
    <td class="LineVertico2PX"></td>
    <td width="54" class="TXTResultsBlack">Targets<br />Cibles</td>
    <td class="LineVertico1PX"></td>
    <td width="60" class="TXTResultsBlack">Score<br />Pointage</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">%</td>
    <td class="LineVertico1PX"></td>
    <td width="54" style="text-align:center;" bgcolor="#d7d7d7"><span class="TXTResultsRed">89%</span><br /><span class="TXTResultsBlue">11%</span><br /><span class="TXTResultsBlack"><b>100%</b></span></td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Open<br />Ouvert<br />/20</td>
    <td class="LineVertico1PX"></td>
    <td width="54" class="TXTResultsBlack">Junior<br />/5</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo1PX"></td>

<tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">134</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">67,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">7,44</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>7,44</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">11</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">10</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>10</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">2</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">3</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>3</b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">132</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">66,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">7,33</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>7,33</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">10</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">11</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>11</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">151</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">75,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">8,39</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>8,39</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">9</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">5</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>6</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">164</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">82,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">9,11</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>9,11</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">8</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">4</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>5</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="17" class="LineHorizo1PX"></td><tr>
    <td class="LineVertico2PX"></td>
    <td height="56" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="114" height="18" class="TXTResultsRed" style="text-align:left;">&nbsp;Prone&nbsp;/&nbsp;Couch&eacute;e</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue" style="text-align:left;">&nbsp;Standing&nbsp;/&nbsp;Debout</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen" style="text-align:left;">&nbsp;Cumul.</td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0/14</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">2/7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="60" height="18" class="TXTResultsRed">0</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">135</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">67,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRedT">0,00</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlueT">7,50</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>7,50</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed">7</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue">9</td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b>9</b></td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsRed">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="54" height="18" class="TXTResultsRed"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsBlue"></td>
        <tr>
            <td class="LineHorizo1PX"></td>
        <tr>
            <td height="18" class="TXTResultsGreen"><b></b></td>
        </table>
    </td>
    <td class="LineVertico2PX"></td>

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:40 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177eb2f AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (14, N'eid-39_rid-10_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Nova Scotia&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Nouvelle-&#201;cosse</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:26 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177da88 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (15, N'eid-39_rid-2_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Ontario&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Ontario</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:28 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177dd14 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (16, N'eid-39_rid-1_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Quebec&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Qu&#233;bec</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:30 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177dfb6 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (17, N'eid-39_rid-45_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Northen Regions&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;R&#233;gions du Nord</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:32 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177e217 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (18, N'eid-39_rid-7_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Saskatchewan&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Saskatchewan</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:34 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177e476 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (19, N'eid-39_rid-11_ri', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">

<tr>
    <td colspan="17" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td colspan="15" height="30" class="TXTResultsBlack" style="font-weight:bold;">Newfoundland and Labrador&nbsp;Individual Results / R&eacute;sultats Individuels&nbsp;Terre-Neuve-et-Labrador</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="17" class="LineHorizo2PX"></td>

 


</table>
<br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-07 02:48:36 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a0490177e6d2 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (20, N'eid-39_cr', N'
<center>

<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
    </style>

<br />

    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
    
    <tr>
        <td colspan="17" class="LineHorizo2PX"></td>
    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" colspan="3" class="TXTResultsBlack" style="font-weight:bold;">Competitors ranking<br />Classement des comp&eacute;titeurs</td>
        <td class="LineVertico1PX"></td>
        <td colspan="7" class="TXTResultsBlack" style="font-weight:bold;">Position</td>
        <td class="LineVertico1PX"></td>
        <td colspan="3" class="TXTResultsBlack" style="font-weight:bold;">Ranking<br />Classement</td>
        <td class="LineVertico2PX"></td>
    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>
    <tr>
        <td class="LineVertico2PX"></td>
        <td width="140" height="40" class="TXTResultsBlack">Competitors<br />Comp&eacute;titeurs</td>
        <td class="LineVertico1PX"></td>
        <td width="80" class="TXTResultsBlack">Team<br />&Eacute;quipe</td>
        <td class="LineVertico2PX"></td>
        <td width="60" class="TXTResultsBlack">Targets<br />Cibles<br />/21</td>
        <td class="LineVertico1PX"></td>
        <td width="60" class="TXTResultsRed">Prone<br />Couch&eacute;e<br />89%</td>
        <td class="LineVertico1PX"></td>
        <td width="60" class="TXTResultsBlue">Standing<br />Debout<br />11%</td>
        <td class="LineVertico1PX"></td>
        <td width="60" class="TXTResultsGreen" style="font-weight:bold;">Cumul.<br />(89+11)</td>
        <td class="LineVertico2PX"></td>
        <td width="50" class="TXTResultsBlack">Open<br />Ouvert</td>
        <td class="LineVertico1PX"></td>
        <td width="50" class="TXTResultsBlack">Junior</td>
        <td class="LineVertico2PX"></td>
    <tr>
        <td colspan="17" class="LineHorizo2PX"></td>

        <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;Ricard<br />&nbsp;Denis</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">3</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">59,56</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">7,61</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">67,17</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">1</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">1</td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;Garceau<br />&nbsp;M&#233;lanie</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">10,50</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">10,50</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">9,50</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">9,50</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">3</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">9,17</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">9,17</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">4</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">9,11</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">9,11</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">5</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">8,39</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">8,39</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">6</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">7,83</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">7,83</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">7</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">7,72</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">7,72</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">8</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">7,50</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">7,50</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">9</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">7,44</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">7,44</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">10</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">2</td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">7,33</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">7,33</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">11</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">7,28</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">7,28</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">12</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">6,67</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">6,67</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">13</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">6,33</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">6,33</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">14</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;Roy<br />&nbsp;Alain</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">5,94</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">5,94</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">15</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">3</td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">5,11</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">5,11</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">16</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">4,61</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">4,61</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">17</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;BC-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">4,44</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">4,44</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">18</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">4,22</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">4,22</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">19</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;AB-C-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">2</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">3,72</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">3,72</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">20</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;MA-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">0</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">0,00</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">21</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;MA-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">0</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">0,00</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">22</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;MA-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">0</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">0,00</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">23</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;MA-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">0</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">0,00</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">24</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>    <tr>
        <td colspan="17" class="LineHorizo1PX"></td>    <tr>
        <td class="LineVertico2PX"></td>
        <td height="40" class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack">&nbsp;MA-U-01</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack">0</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsRed">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlue">0,00</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsGreen" style="font-weight:bold;">0,00</td>
        <td class="LineVertico2PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;">25</td>
        <td class="LineVertico1PX"></td>
        <td class="TXTResultsBlack" style="font-weight:bold;"></td>
        <td class="LineVertico2PX"></td>

    <tr>
        <td colspan="17" class="LineHorizo2PX"></td>

    </table>
    <br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-05 14:10:34 (UTC/GMT)
    </span>

</center>
', CAST(0x0000a04800a7b335 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (21, N'eid-39_rr', N'
<center>

 <style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;     
    }
    
    </style>

<br />

        <table border="0" cellpadding="0" cellspacing="0" class="TXTResultsBlack">
        <tr>
            <td colspan="9" class="LineHorizo2PX"></td>
        <tr bgcolor="#ffffff" style="font-weight: bold;">
            <td height="40" class="LineVertico2PX"></td>
            <td colspan="3" align="center" valign="middle">Province</td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle">Score<br />Pointage</td>
            <td class="LineVertico1PX"></td>
            <td align="center" valign="middle">Rank<br />Position</td>
            <td class="LineVertico2PX"></td>
        <tr>
            <td colspan="9" class="LineHorizo2PX"></td>
        
        <tr bgcolor="yellow" style=''font-weight: bold;''>
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Alberta</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">AB        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">64,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">1</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="silver" style=''font-weight: bold;''>
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Newfoundland and Labrador<br>&nbsp;Terre-Neuve-et-Labrador</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">NL        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">2</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#cc9900" style=''font-weight: bold;''>
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Saskatchewan</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">SK        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">3</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Northen Regions<br>&nbsp;R&#233;gions du Nord</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">NR        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">4</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Quebec<br>&nbsp;Qu&#233;bec</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">QC        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">5</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Ontario</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">ON        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">6</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Nova Scotia<br>&nbsp;Nouvelle-&#201;cosse</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">NS        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">7</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;New Bunswick<br>&nbsp;Nouveau-Brunswick</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">NB        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">8</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Manitoba</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">MB        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">9</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;Prince Edward Island<br>&nbsp;&#206;le-du-Prince-&#201;douard</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">PE        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">10</td>
<td class="LineVertico2PX"></td><tr>
<td colspan="9" class="LineHorizo1PX"></td><tr bgcolor="#ffffff" >
<td height="40" class="LineVertico2PX"></td>
<td width="200" align="left" valign="middle">&nbsp;British Columbia<br>&nbsp;Colombie-Britannique</td>
<td class="LineVertico1PX"></td>
<td width="50" align="center" valign="middle">BC        </td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">0,00&nbsp;%</td>
<td class="LineVertico1PX"></td>
<td width="100" align="center" valign="middle">11</td>
<td class="LineVertico2PX"></td>

        <tr>
            <td colspan="9" class="LineHorizo2PX"></td>
        
        </table>
        <br />
    <span class="TXTNormal">
    Updated date / Date de mise-&agrave;-jour<br />
    2012-05-10 18:48:07 (UTC/GMT)
    </span>


</center>
', CAST(0x0000a04d00f3ee11 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (22, N'eid-39_composite_tr', N'<center><span style="COLOR: Black;FONT-FAMILY: verdana,helvetica,arial,serif;FONT-SIZE: 12px;FONT-WEIGHT: normal;">Results soon available.<br />The marksmanship will begin on May 07th, 2012.<br /><br />Résultats bientôt disponibles.<br />Le Championnat de tir débutera le 07 mai 2012.</span></center>', CAST(0x0000a0470102ad81 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (23, N'eid-39_unit_tr', N'<center><span style="COLOR: Black;FONT-FAMILY: verdana,helvetica,arial,serif;FONT-SIZE: 12px;FONT-WEIGHT: normal;">Results soon available.<br />The marksmanship will begin on May 07th, 2012.<br /><br />Résultats bientôt disponibles.<br />Le Championnat de tir débutera le 07 mai 2012.</span></center>', CAST(0x0000a044015974c6 AS datetime), 39)

GO
INSERT INTO [dbo].[tblPublicHtmlTexts] ([publicHtmlTextId], [publicHtmlTextName], [publicHtmlText], [publicHtmlTextDateTime], [fkEventId])
	VALUES (24, N'eid-39_fn', N'<center>
<style type="text/css">
    
    .TXTNormal
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: normal;
    }
    
    .TXTResultsTitles
    {
        COLOR: #000000;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 12px;
        FONT-WEIGHT: bold;
        text-align:center;
    }

    .TXTResultsBlack
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRed
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsBlue
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
    }
    
    .TXTResultsRedT
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsBlueT
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #d7d7d7;
    }
    
    .TXTResultsGreen
    {
        COLOR: Black;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 11px;
        FONT-WEIGHT: normal;
        text-align:center;
        background-color: #A3BC6D;
    }
    
    .TXTResultsRedTiny
    {
        COLOR: Red;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 8px;
        FONT-WEIGHT: normal;
        text-align:center;
        vertical-align: middle;
    }
    
    .TXTResultsBlueTiny
    {
        COLOR: Blue;
        FONT-FAMILY: verdana,helvetica,arial,serif;
        FONT-SIZE: 8px;
        FONT-WEIGHT: normal;
        text-align:center;
        vertical-align: middle;
    }
    
    .LineVertico1PX
    {
        width: 1px;
        background-color: black;
    }

    .LineVertico2PX
    {
        width: 2px;
        background-color: black;
    }

    .LineHorizo1PX
    {
        height: 1px;
        background-color: black;     
    }

    .LineHorizo2PX
    {
        height: 2px;
        background-color: black;
    }
    
</style>
<br />
<table border="0" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="19" class="LineHorizo2PX"></td>
<tr bgcolor="#cecece">
    <td class="LineVertico2PX"></td>
    <td height="35" colspan="17" class="TXTResultsBlack" style="font-weight:bold;">MARKSMANSHIP FINAL<br />FINALE DU CHAMPIONNAT</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="19" class="LineHorizo2PX"></td>
<tr bgcolor="#cecece">
    <td height="30" class="LineVertico2PX"></td>
    <td width="29" class="TXTResultsBlack">Pro.</td>
    <td class="LineVertico1PX"></td>
    <td width="110" class="TXTResultsBlack">Name</td>
    <td class="LineVertico1PX"></td>
    <td width="40" class="TXTResultsBlack">Qualif.</td>
    <td class="LineVertico1PX"></td>
    <td width="229" class="TXTResultsBlack">Targets<br />Cibles</td>
    <td class="LineVertico1PX"></td>
    <td width="40" class="TXTResultsBlack">Score<br />Point.</td>
    <td class="LineVertico1PX"></td>
    <td width="40" class="TXTResultsBlack"><span class="TXTResultsRed">89%</span><br /><span class="TXTResultsBlue">11%</span></td>
    <td class="LineVertico1PX"></td>
    <td width="40" class="TXTResultsGreen">100%<br />89+11</td>
    <td class="LineVertico1PX"></td>
    <td width="30" class="TXTResultsBlack">Op.<br />Ou.</td>
    <td class="LineVertico1PX"></td>
    <td width="30" class="TXTResultsBlack">Jr</td>
    <td class="LineVertico2PX"></td>
<tr>
    <td colspan="19" class="LineHorizo2PX"></td>

    <tr>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsBlack">AB        </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">0,00</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
    
    <!-- ========================== -->
    <!-- ===== Prone Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsRed">Prone position Couch&eacute;e</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
    </table>
    
    <!-- ===== Prone Shooting ===== -->
    <!-- ========================== -->

    <!-- ============================= -->
    <!-- ===== Standing Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsBlue">Standing position Debout</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >9,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >9,5</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >5,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >3,9</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,6</td>
                </table>
            </td>
    </table>
    <!-- ===== Standing Shooting ===== -->
    <!-- ============================= -->

    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">200,0</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">89,2</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">81,55</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">9,09</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsGreen" style="font-weight:bold;">90,64</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">1</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack"></td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="19" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsBlack">AB        </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">0,00</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
    
    <!-- ========================== -->
    <!-- ===== Prone Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsRed">Prone position Couch&eacute;e</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
    </table>
    
    <!-- ===== Prone Shooting ===== -->
    <!-- ========================== -->

    <!-- ============================= -->
    <!-- ===== Standing Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsBlue">Standing position Debout</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >9,2</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >5,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >2,3</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,2</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
    </table>
    <!-- ===== Standing Shooting ===== -->
    <!-- ============================= -->

    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">200,0</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">87,3</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">81,55</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">8,90</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsGreen" style="font-weight:bold;">90,45</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">2</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack"></td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="19" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsBlack">AB        </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">0,00</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
    
    <!-- ========================== -->
    <!-- ===== Prone Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsRed">Prone position Couch&eacute;e</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
    </table>
    
    <!-- ===== Prone Shooting ===== -->
    <!-- ========================== -->

    <!-- ============================= -->
    <!-- ===== Standing Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsBlue">Standing position Debout</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >5,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >9,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >3,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >8,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
    </table>
    <!-- ===== Standing Shooting ===== -->
    <!-- ============================= -->

    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">200,0</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">86,8</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">81,55</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">8,85</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsGreen" style="font-weight:bold;">90,40</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">3</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack"></td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="19" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsBlack">AB        </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack" style="text-align:left;">&nbsp;<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">0,00</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
    
    <!-- ========================== -->
    <!-- ===== Prone Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsRed">Prone position Couch&eacute;e</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
    </table>
    
    <!-- ===== Prone Shooting ===== -->
    <!-- ========================== -->

    <!-- ============================= -->
    <!-- ===== Standing Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsBlue">Standing position Debout</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >2,3</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >8,8</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >3,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >2,9</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
    </table>
    <!-- ===== Standing Shooting ===== -->
    <!-- ============================= -->

    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">200,0</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">77,0</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">81,55</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">7,85</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsGreen" style="font-weight:bold;">89,40</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">4</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack"></td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="19" class="LineHorizo2PX"></td>
<tr>
    <td class="LineVertico2PX"></td>
    <td class="TXTResultsBlack">AB        </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack" style="text-align:left;">&nbsp;Shooter 5<br />&nbsp;</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">64,00</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
    
    <!-- ========================== -->
    <!-- ===== Prone Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsRed">Prone position Couch&eacute;e</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,9</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" >8,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,9</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" >8,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >6,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" >8,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >7,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" >8,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >8,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" >5,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >7,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" >8,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >7,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >7,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >8,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsRedTiny" >8,0</td>
                    <tr>
                        <td class="LineHorizo1PX"></td>
                    <tr>
                        <td height="15" class="TXTResultsRedTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
    </table>
    
    <!-- ===== Prone Shooting ===== -->
    <!-- ========================== -->

    <!-- ============================= -->
    <!-- ===== Standing Shooting ===== -->
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="15" colspan="19" class="TXTResultsBlue">Standing position Debout</td>
        <tr>
            <td colspan="19" class="LineHorizo1PX"></td>
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,9</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,9</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >2,0</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >5,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >5,5</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >2,3</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >8,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >6,5</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" >5,6</td>
                </table>
            </td>
            <td class="LineVertico1PX"></td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="22" height="15" class="TXTResultsBlueTiny" bgcolor=''#FFFF00''>10,0</td>
                </table>
            </td>
    </table>
    <!-- ===== Standing Shooting ===== -->
    <!-- ============================= -->

    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">164,8</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">67,9</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="45" height="47" class="TXTResultsRed">60,35</td>
            <tr>
                <td class="LineHorizo1PX"></td>
            <tr>
                <td height="31" class="TXTResultsBlue">9,63</td>
        </table>
    </td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsGreen" style="font-weight:bold;">69,98</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">5</td>
    <td class="LineVertico1PX"></td>
    <td class="TXTResultsBlack">1</td>
    <td class="LineVertico2PX"></td><tr>
    <td colspan="19" class="LineHorizo2PX"></td>


</table>
</center>', CAST(0x0000a04e00f5e9fd AS datetime), NULL)

GO
SET IDENTITY_INSERT [dbo].[tblPublicHtmlTexts] OFF
GO

--Table dbo.tblRegions

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblRegions] (
	[regionId] [smallint] NOT NULL IDENTITY (1, 1),
	[regionNameFr] [varchar](50) NULL,
	[regionNameEn] [varchar](50) NULL,
	[regionLetterFr] [nchar](10) NULL,
	[regionLetterEn] [nchar](10) NULL,
	[regionFlagLogo] [varchar](50) NULL,
	[fkEventTypeId] [tinyint] NOT NULL);
GO

SET IDENTITY_INSERT [dbo].[tblRegions] ON
GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (1, N'Québec', N'Quebec', N'QC        ', N'QC        ', N'Quebec.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (2, N'Ontario', N'Ontario', N'ON        ', N'ON        ', N'Ontario.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (3, N'Zone 04', N'Zone 04', N'04        ', N'04        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (5, N'Manitoba', N'Manitoba', N'MB        ', N'MB        ', N'Manitoba.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (7, N'Saskatchewan', N'Saskatchewan', N'SK        ', N'SK        ', N'Saskatchewan.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (8, N'Colombie-Britannique', N'British Columbia', N'BC        ', N'BC        ', N'BritishColumbia.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (9, N'Nouveau-Brunswick', N'New Bunswick', N'NB        ', N'NB        ', N'NewBrunswick.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (10, N'Nouvelle-Écosse', N'Nova Scotia', N'NS        ', N'NS        ', N'NovaScotia.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (11, N'Terre-Neuve-et-Labrador', N'Newfoundland and Labrador', N'NL        ', N'NL        ', N'Newfoundland.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (12, N'Nunavut', N'Nunavut', N'NU        ', N'NU        ', N'Nunavut.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (14, N'Territoires du Nord-Ouest', N'Northwest Territories', N'NT        ', N'NT        ', N'NorthwestTerritories.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (15, N'Corps de Cadets 2931 Louiseville', N'Cadet Corps 2931 Louiseville', N'2931      ', N'2931      ', N'', 3)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (16, N'Corps de Cadets 2671 Trois-Rivières', N'Cadet Corps 2671 Trois-Rivieres', N'2671      ', N'2671      ', N'', 3)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (17, N'Zone 01', N'Zone 01', N'01        ', N'01        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (18, N'Zone 02', N'Zone 02', N'02        ', N'02        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (21, N'Corps de Cadets 694 Shawinigan', N'Cadet Corps 694 Shawinigan', N'694       ', N'694       ', N'', 3)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (22, N'Corps de Cadets 2006 Acton Vale', N'Cadet Corps 2006 Acton Vale', N'2006      ', N'2006      ', N'', 3)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (23, N'Escadron 14 Shawinigan', N'Sqadron 14 Shawinigan', N'14        ', N'14        ', N'', 3)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (24, N'Escadron 226 Trois-Rivières', N'Sqadron 226 Trois-Rivieres', N'226       ', N'226       ', N'', 3)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (25, N'Escadron 350 Cap-de-la-Madeleine', N'Sqadron 350 Cap-de-la-Madeleine', N'350       ', N'350       ', N'', 3)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (28, N'Alberta', N'Alberta', N'AB        ', N'AB        ', N'Alberta.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (29, N'Île-du-Prince-Édouard', N'Prince Edward Island', N'PE        ', N'PE        ', N'PrinceEdwardIsland.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (30, N'Yukon', N'Yukon', N'YT        ', N'YT        ', N'Yukon.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (31, N'Zone 03', N'Zone 03', N'03        ', N'03        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (32, N'Zone 05', N'Zone 05', N'05        ', N'05        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (33, N'Zone 06', N'Zone 06', N'06        ', N'06        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (34, N'Zone 07', N'Zone 07', N'07        ', N'07        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (35, N'Zone 08', N'Zone 08', N'08        ', N'08        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (36, N'Zone 09', N'Zone 09', N'09        ', N'09        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (37, N'Zone 10', N'Zone 10', N'10        ', N'10        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (38, N'Zone 11', N'Zone 11', N'11        ', N'11        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (39, N'Zone 12', N'Zone 12', N'12        ', N'12        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (40, N'Zone 13', N'Zone 13', N'13        ', N'13        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (41, N'Zone 14', N'Zone 14', N'14        ', N'14        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (42, N'Zone 15', N'Zone 15', N'15        ', N'15        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (43, N'Zone 16', N'Zone 16', N'16        ', N'16        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (44, N'Zone 17', N'Zone 17', N'17        ', N'17        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (45, N'Régions du Nord', N'Northen Regions', N'NR        ', N'NR        ', N'NorthenRegions.gif', 1)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (46, N'Zone 18', N'Zone 18', N'18        ', N'18        ', N'', 2)

GO
INSERT INTO [dbo].[tblRegions] ([regionId], [regionNameFr], [regionNameEn], [regionLetterFr], [regionLetterEn], [regionFlagLogo], [fkEventTypeId])
	VALUES (47, N'URSC (E)', N'RCSU (E)', N'URSCE     ', N'RCSUE     ', N'', 2)

GO
SET IDENTITY_INSERT [dbo].[tblRegions] OFF
GO

--Table dbo.tblRegionsEvents

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblRegionsEvents] (
	[regionEventId] [int] NOT NULL IDENTITY (1, 1),
	[fkRegionId] [smallint] NOT NULL,
	[fkEventId] [int] NOT NULL);
GO

SET IDENTITY_INSERT [dbo].[tblRegionsEvents] ON
GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (106, 28, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (107, 8, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (108, 29, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (109, 5, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (110, 9, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (111, 10, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (112, 2, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (113, 1, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (114, 45, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (115, 7, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (116, 11, 39)

GO
INSERT INTO [dbo].[tblRegionsEvents] ([regionEventId], [fkRegionId], [fkEventId])
	VALUES (117, 47, 38)

GO
SET IDENTITY_INSERT [dbo].[tblRegionsEvents] OFF
GO

--Table dbo.tblResults

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblResults] (
	[resultId] [int] NOT NULL IDENTITY (1, 1),
	[result] [float] NULL,
	[resultTargetSerial] [varchar](50) NULL,
	[resultDateTimeInsert] [datetime] NULL,
	[resultTargetNbr] [tinyint] NULL,
	[resultTeamSerial] [int] NULL,
	[resultTeamCompetitorSerial] [smallint] NULL,
	[fkCompetitionChapterId] [smallint] NULL,
	[fkTeamCompetitorId] [int] NULL,
	[fkUserId] [int] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblResults] ON
GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (537, CAST ('100' AS float), N'01101', CAST(0x0000a04d009afb8e AS datetime), 1, 1, 11, 21, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (538, CAST ('100' AS float), N'01102', CAST(0x0000a04d009affef AS datetime), 2, 1, 11, 21, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (539, CAST ('19' AS float), N'01101', CAST(0x0000a04d009b09e0 AS datetime), 1, 1, 11, 22, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (540, CAST ('100' AS float), N'01102', CAST(0x0000a04d009b0f8a AS datetime), 2, 1, 11, 22, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (541, CAST ('10.9' AS float), N'01101', CAST(0x0000a04d009b93aa AS datetime), 1, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (542, CAST ('10.9' AS float), N'01102', CAST(0x0000a04d009b9973 AS datetime), 2, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (543, CAST ('10.9' AS float), N'01101', CAST(0x0000a04d009bbe75 AS datetime), 1, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (544, CAST ('10.9' AS float), N'01102', CAST(0x0000a04d009bc329 AS datetime), 2, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (545, CAST ('5' AS float), N'01115', CAST(0x0000a04d009cb766 AS datetime), 15, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (546, CAST ('6' AS float), N'01103', CAST(0x0000a04d009cc794 AS datetime), 3, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (547, CAST ('7' AS float), N'01104', CAST(0x0000a04d009cd125 AS datetime), 4, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (548, CAST ('8' AS float), N'01105', CAST(0x0000a04d009cd5cb AS datetime), 5, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (549, CAST ('7' AS float), N'01106', CAST(0x0000a04d009ce617 AS datetime), 6, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (550, CAST ('7' AS float), N'01107', CAST(0x0000a04d009ce836 AS datetime), 7, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (551, CAST ('7' AS float), N'01108', CAST(0x0000a04d009cea15 AS datetime), 8, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (552, CAST ('8' AS float), N'01109', CAST(0x0000a04d009cec0a AS datetime), 9, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (553, CAST ('8' AS float), N'01110', CAST(0x0000a04d009cede4 AS datetime), 10, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (554, CAST ('8' AS float), N'01111', CAST(0x0000a04d009cef98 AS datetime), 11, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (555, CAST ('8' AS float), N'01112', CAST(0x0000a04d009cf171 AS datetime), 12, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (556, CAST ('8' AS float), N'01113', CAST(0x0000a04d009cf333 AS datetime), 13, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (557, CAST ('8' AS float), N'01114', CAST(0x0000a04d009cf4ec AS datetime), 14, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (558, CAST ('8' AS float), N'01116', CAST(0x0000a04d009cfbe1 AS datetime), 16, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (559, CAST ('9.2' AS float), N'31301', CAST(0x0000a04d00f2051f AS datetime), 1, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (560, CAST ('2.3' AS float), N'31401', CAST(0x0000a04d00f20520 AS datetime), 1, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (561, CAST ('5.6' AS float), N'31501', CAST(0x0000a04d00f20521 AS datetime), 1, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (562, CAST ('5.6' AS float), N'31302', CAST(0x0000a04d00f22bf6 AS datetime), 2, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (563, CAST ('8.8' AS float), N'31402', CAST(0x0000a04d00f22bf7 AS datetime), 2, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (564, CAST ('9.6' AS float), N'31502', CAST(0x0000a04d00f22bfd AS datetime), 2, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (565, CAST ('2' AS float), N'01103', CAST(0x0000a04d00fe7bb1 AS datetime), 3, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (566, CAST ('3' AS float), N'31403', CAST(0x0000a04d00fe7bb2 AS datetime), 3, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (567, CAST ('3' AS float), N'31503', CAST(0x0000a04d00fe7bb3 AS datetime), 3, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (568, CAST ('5.6' AS float), N'01104', CAST(0x0000a04d00fe83bf AS datetime), 4, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (569, CAST ('2.9' AS float), N'31404', CAST(0x0000a04d00fe83bf AS datetime), 4, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (570, CAST ('8.6' AS float), N'31504', CAST(0x0000a04d00fe83c0 AS datetime), 4, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (571, CAST ('5.5' AS float), N'01105', CAST(0x0000a04d00fece18 AS datetime), 5, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (572, CAST ('10' AS float), N'31405', CAST(0x0000a04d00fece1a AS datetime), 5, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (573, CAST ('10' AS float), N'31505', CAST(0x0000a04d00fece1a AS datetime), 5, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (574, CAST ('9.6' AS float), N'31201', CAST(0x0000a04d014aa48f AS datetime), 1, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (575, CAST ('9.5' AS float), N'31202', CAST(0x0000a04d014aaa42 AS datetime), 2, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (576, CAST ('5.6' AS float), N'31203', CAST(0x0000a04d014aafbc AS datetime), 3, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (577, CAST ('2.3' AS float), N'31303', CAST(0x0000a04d014abdc0 AS datetime), 3, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (578, CAST ('3.9' AS float), N'31204', CAST(0x0000a04d014ad250 AS datetime), 4, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (579, CAST ('10.2' AS float), N'31304', CAST(0x0000a04d014ad251 AS datetime), 4, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (580, CAST ('10' AS float), N'31205', CAST(0x0000a04d014ae547 AS datetime), 5, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (581, CAST ('10' AS float), N'31305', CAST(0x0000a04d014ae549 AS datetime), 5, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (582, CAST ('2.3' AS float), N'01106', CAST(0x0000a04d014b127d AS datetime), 6, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (583, CAST ('10' AS float), N'31206', CAST(0x0000a04d014b127e AS datetime), 6, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (584, CAST ('10' AS float), N'31306', CAST(0x0000a04d014b127f AS datetime), 6, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (585, CAST ('10' AS float), N'31406', CAST(0x0000a04d014b1280 AS datetime), 6, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (586, CAST ('10' AS float), N'31506', CAST(0x0000a04d014b1280 AS datetime), 6, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (587, CAST ('8.6' AS float), N'01107', CAST(0x0000a04d014b22d4 AS datetime), 7, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (588, CAST ('10' AS float), N'31207', CAST(0x0000a04d014b22d5 AS datetime), 7, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (589, CAST ('10' AS float), N'31307', CAST(0x0000a04d014b22d6 AS datetime), 7, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (590, CAST ('10' AS float), N'31407', CAST(0x0000a04d014b22d6 AS datetime), 7, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (591, CAST ('10' AS float), N'31507', CAST(0x0000a04d014b22d7 AS datetime), 7, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (592, CAST ('6.5' AS float), N'01108', CAST(0x0000a04d014b77a8 AS datetime), 8, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (593, CAST ('10' AS float), N'31208', CAST(0x0000a04d014b77ac AS datetime), 8, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (594, CAST ('10' AS float), N'31308', CAST(0x0000a04d014b77ad AS datetime), 8, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (595, CAST ('10' AS float), N'31408', CAST(0x0000a04d014b77ae AS datetime), 8, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (596, CAST ('10' AS float), N'31508', CAST(0x0000a04d014b77ae AS datetime), 8, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (597, CAST ('5.6' AS float), N'01109', CAST(0x0000a04d014b848a AS datetime), 9, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (598, CAST ('10' AS float), N'31209', CAST(0x0000a04d014b848d AS datetime), 9, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (599, CAST ('10' AS float), N'31309', CAST(0x0000a04d014b848f AS datetime), 9, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (600, CAST ('10' AS float), N'31409', CAST(0x0000a04d014b8490 AS datetime), 9, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (601, CAST ('10' AS float), N'31509', CAST(0x0000a04d014b8491 AS datetime), 9, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (602, CAST ('10' AS float), N'01110', CAST(0x0000a04d014bb7fc AS datetime), 10, 1, 11, 23, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (603, CAST ('10.6' AS float), N'31210', CAST(0x0000a04d014bb7fe AS datetime), 10, 31, 312, 23, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (604, CAST ('10' AS float), N'31310', CAST(0x0000a04d014bb7ff AS datetime), 10, 31, 313, 23, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (605, CAST ('10' AS float), N'31410', CAST(0x0000a04d014bb7ff AS datetime), 10, 31, 314, 23, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (606, CAST ('10' AS float), N'31510', CAST(0x0000a04d014bb800 AS datetime), 10, 31, 315, 23, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (607, CAST ('10' AS float), N'31201', CAST(0x0000a04e00f4885e AS datetime), 1, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (608, CAST ('10' AS float), N'31301', CAST(0x0000a04e00f48860 AS datetime), 1, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (609, CAST ('10' AS float), N'31401', CAST(0x0000a04e00f48861 AS datetime), 1, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (610, CAST ('10' AS float), N'31501', CAST(0x0000a04e00f48861 AS datetime), 1, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (611, CAST ('10' AS float), N'31202', CAST(0x0000a04e00f48e9a AS datetime), 2, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (612, CAST ('10' AS float), N'31302', CAST(0x0000a04e00f48e9b AS datetime), 2, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (613, CAST ('10' AS float), N'31402', CAST(0x0000a04e00f48e9c AS datetime), 2, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (614, CAST ('10' AS float), N'31502', CAST(0x0000a04e00f48e9d AS datetime), 2, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (615, CAST ('10' AS float), N'31203', CAST(0x0000a04e00f4932f AS datetime), 3, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (616, CAST ('10' AS float), N'31303', CAST(0x0000a04e00f49330 AS datetime), 3, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (617, CAST ('10' AS float), N'31403', CAST(0x0000a04e00f49331 AS datetime), 3, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (618, CAST ('10' AS float), N'31503', CAST(0x0000a04e00f49331 AS datetime), 3, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (619, CAST ('10' AS float), N'31204', CAST(0x0000a04e00f498c9 AS datetime), 4, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (620, CAST ('10' AS float), N'31304', CAST(0x0000a04e00f498ca AS datetime), 4, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (621, CAST ('10' AS float), N'31404', CAST(0x0000a04e00f498cb AS datetime), 4, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (622, CAST ('10' AS float), N'31504', CAST(0x0000a04e00f498cb AS datetime), 4, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (623, CAST ('10' AS float), N'31205', CAST(0x0000a04e00f49cde AS datetime), 5, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (624, CAST ('10' AS float), N'31305', CAST(0x0000a04e00f49cdf AS datetime), 5, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (625, CAST ('10' AS float), N'31405', CAST(0x0000a04e00f49ce0 AS datetime), 5, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (626, CAST ('10' AS float), N'31505', CAST(0x0000a04e00f49ce1 AS datetime), 5, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (627, CAST ('10' AS float), N'31206', CAST(0x0000a04e00f4a13a AS datetime), 6, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (628, CAST ('10' AS float), N'31306', CAST(0x0000a04e00f4a13b AS datetime), 6, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (629, CAST ('10' AS float), N'31406', CAST(0x0000a04e00f4a13c AS datetime), 6, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (630, CAST ('10' AS float), N'31506', CAST(0x0000a04e00f4a13c AS datetime), 6, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (631, CAST ('10' AS float), N'31207', CAST(0x0000a04e00f4a591 AS datetime), 7, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (632, CAST ('10' AS float), N'31307', CAST(0x0000a04e00f4a592 AS datetime), 7, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (633, CAST ('10' AS float), N'31407', CAST(0x0000a04e00f4a592 AS datetime), 7, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (634, CAST ('10' AS float), N'31507', CAST(0x0000a04e00f4a593 AS datetime), 7, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (635, CAST ('10' AS float), N'31208', CAST(0x0000a04e00f4a9cc AS datetime), 8, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (636, CAST ('10' AS float), N'31308', CAST(0x0000a04e00f4a9cd AS datetime), 8, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (637, CAST ('10' AS float), N'31408', CAST(0x0000a04e00f4a9cd AS datetime), 8, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (638, CAST ('10' AS float), N'31508', CAST(0x0000a04e00f4a9ce AS datetime), 8, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (639, CAST ('10' AS float), N'31209', CAST(0x0000a04e00f4adf4 AS datetime), 9, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (640, CAST ('10' AS float), N'31309', CAST(0x0000a04e00f4adf5 AS datetime), 9, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (641, CAST ('10' AS float), N'31409', CAST(0x0000a04e00f4adf6 AS datetime), 9, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (642, CAST ('10' AS float), N'31509', CAST(0x0000a04e00f4adf6 AS datetime), 9, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (643, CAST ('10' AS float), N'31210', CAST(0x0000a04e00f4c339 AS datetime), 10, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (644, CAST ('10' AS float), N'31310', CAST(0x0000a04e00f4c33b AS datetime), 10, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (645, CAST ('10' AS float), N'31410', CAST(0x0000a04e00f4c33c AS datetime), 10, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (646, CAST ('10' AS float), N'31510', CAST(0x0000a04e00f4c33d AS datetime), 10, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (647, CAST ('10' AS float), N'31211', CAST(0x0000a04e00f4c9a8 AS datetime), 11, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (648, CAST ('10' AS float), N'31311', CAST(0x0000a04e00f4c9a9 AS datetime), 11, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (649, CAST ('10' AS float), N'31411', CAST(0x0000a04e00f4c9aa AS datetime), 11, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (650, CAST ('10' AS float), N'31511', CAST(0x0000a04e00f4c9ab AS datetime), 11, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (651, CAST ('10' AS float), N'31212', CAST(0x0000a04e00f4cdde AS datetime), 12, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (652, CAST ('10' AS float), N'31312', CAST(0x0000a04e00f4cddf AS datetime), 12, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (653, CAST ('10' AS float), N'31412', CAST(0x0000a04e00f4cde0 AS datetime), 12, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (654, CAST ('10' AS float), N'31512', CAST(0x0000a04e00f4cde1 AS datetime), 12, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (655, CAST ('10' AS float), N'31213', CAST(0x0000a04e00f4d243 AS datetime), 13, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (656, CAST ('10' AS float), N'31313', CAST(0x0000a04e00f4d244 AS datetime), 13, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (657, CAST ('10' AS float), N'31413', CAST(0x0000a04e00f4d244 AS datetime), 13, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (658, CAST ('10' AS float), N'31513', CAST(0x0000a04e00f4d245 AS datetime), 13, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (659, CAST ('10' AS float), N'31214', CAST(0x0000a04e00f4f93f AS datetime), 14, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (660, CAST ('10' AS float), N'31314', CAST(0x0000a04e00f4f940 AS datetime), 14, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (661, CAST ('10' AS float), N'31414', CAST(0x0000a04e00f4f941 AS datetime), 14, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (662, CAST ('10' AS float), N'31514', CAST(0x0000a04e00f4f941 AS datetime), 14, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (663, CAST ('10' AS float), N'31215', CAST(0x0000a04e00f4fde7 AS datetime), 15, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (664, CAST ('10' AS float), N'31315', CAST(0x0000a04e00f4fde8 AS datetime), 15, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (665, CAST ('10' AS float), N'31415', CAST(0x0000a04e00f4fde9 AS datetime), 15, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (666, CAST ('10' AS float), N'31515', CAST(0x0000a04e00f4fdea AS datetime), 15, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (667, CAST ('10' AS float), N'31216', CAST(0x0000a04e00f501d1 AS datetime), 16, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (668, CAST ('10' AS float), N'31316', CAST(0x0000a04e00f501d2 AS datetime), 16, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (669, CAST ('10' AS float), N'31416', CAST(0x0000a04e00f501d2 AS datetime), 16, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (670, CAST ('10' AS float), N'31516', CAST(0x0000a04e00f501d3 AS datetime), 16, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (671, CAST ('10' AS float), N'01117', CAST(0x0000a04e00f50781 AS datetime), 17, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (672, CAST ('10' AS float), N'31217', CAST(0x0000a04e00f50783 AS datetime), 17, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (673, CAST ('10' AS float), N'31317', CAST(0x0000a04e00f50784 AS datetime), 17, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (674, CAST ('10' AS float), N'31417', CAST(0x0000a04e00f50787 AS datetime), 17, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (675, CAST ('10' AS float), N'31517', CAST(0x0000a04e00f50788 AS datetime), 17, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (676, CAST ('10' AS float), N'01118', CAST(0x0000a04e00f50c07 AS datetime), 18, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (677, CAST ('10' AS float), N'31218', CAST(0x0000a04e00f50c08 AS datetime), 18, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (678, CAST ('10' AS float), N'31318', CAST(0x0000a04e00f50c09 AS datetime), 18, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (679, CAST ('10' AS float), N'31418', CAST(0x0000a04e00f50c0a AS datetime), 18, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (680, CAST ('10' AS float), N'31518', CAST(0x0000a04e00f50c0b AS datetime), 18, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (681, CAST ('10' AS float), N'01119', CAST(0x0000a04e00f5109e AS datetime), 19, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (682, CAST ('10' AS float), N'31219', CAST(0x0000a04e00f510a8 AS datetime), 19, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (683, CAST ('10' AS float), N'31319', CAST(0x0000a04e00f510a8 AS datetime), 19, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (684, CAST ('10' AS float), N'31419', CAST(0x0000a04e00f510a9 AS datetime), 19, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (685, CAST ('10' AS float), N'31519', CAST(0x0000a04e00f510aa AS datetime), 19, 31, 315, 24, 329, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (686, CAST ('10' AS float), N'01120', CAST(0x0000a04e00f51526 AS datetime), 20, 1, 11, 24, 299, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (687, CAST ('10' AS float), N'31220', CAST(0x0000a04e00f51527 AS datetime), 20, 31, 312, 24, 326, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (688, CAST ('10' AS float), N'31320', CAST(0x0000a04e00f51528 AS datetime), 20, 31, 313, 24, 327, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (689, CAST ('10' AS float), N'31420', CAST(0x0000a04e00f51529 AS datetime), 20, 31, 314, 24, 328, 1)

GO
INSERT INTO [dbo].[tblResults] ([resultId], [result], [resultTargetSerial], [resultDateTimeInsert], [resultTargetNbr], [resultTeamSerial], [resultTeamCompetitorSerial], [fkCompetitionChapterId], [fkTeamCompetitorId], [fkUserId])
	VALUES (690, CAST ('10' AS float), N'31520', CAST(0x0000a04e00f51529 AS datetime), 20, 31, 315, 24, 329, 1)

GO
SET IDENTITY_INSERT [dbo].[tblResults] OFF
GO

--Table dbo.tblResultsIRBR

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblResultsIRBR] (
	[resultIRBRId] [int] NOT NULL IDENTITY (1, 1),
	[fkRegionEventId] [int] NULL,
	[resultIRBRSessionId] [varchar](50) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblResultsIRBR] ON
GO
INSERT INTO [dbo].[tblResultsIRBR] ([resultIRBRId], [fkRegionEventId], [resultIRBRSessionId])
	VALUES (416, 106, N'lq1soj45xrzhve45tbrqlbr0')

GO
INSERT INTO [dbo].[tblResultsIRBR] ([resultIRBRId], [fkRegionEventId], [resultIRBRSessionId])
	VALUES (417, 107, N'lq1soj45xrzhve45tbrqlbr0')

GO
INSERT INTO [dbo].[tblResultsIRBR] ([resultIRBRId], [fkRegionEventId], [resultIRBRSessionId])
	VALUES (418, 108, N'lq1soj45xrzhve45tbrqlbr0')

GO
SET IDENTITY_INSERT [dbo].[tblResultsIRBR] OFF
GO

--Table dbo.tblTeams

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblTeams] (
	[teamId] [int] NOT NULL IDENTITY (1, 1),
	[teamSerial] [int] NULL,
	[teamNameFr] [varchar](50) NULL,
	[teamNameEn] [varchar](50) NULL,
	[fkTeamTypeId] [tinyint] NULL,
	[fkRegionEventId] [int] NOT NULL);
GO

SET IDENTITY_INSERT [dbo].[tblTeams] ON
GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (63, 1, N'2446', N'2446', 1, 117)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (64, 2, N'2671', N'2671', 1, 117)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (65, 3, N'2931', N'2931', 1, 117)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (66, 4, N'Composée', N'Composée', 2, 117)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (67, 1, N'AB-U-01', N'AB-U-01', 1, 106)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (69, 3, N'BC-U-01', N'BC-U-01', 1, 107)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (70, 4, N'BC-C-01', N'BC-C-01', 2, 107)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (71, 11, N'MA-U-01', N'MA-U-01', 1, 109)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (72, 21, N'AB-C-01', N'AB-C-01', 2, 106)

GO
INSERT INTO [dbo].[tblTeams] ([teamId], [teamSerial], [teamNameFr], [teamNameEn], [fkTeamTypeId], [fkRegionEventId])
	VALUES (73, 31, N'AB-C-02', N'AB-C-03', 2, 106)

GO
SET IDENTITY_INSERT [dbo].[tblTeams] OFF
GO

--Table dbo.tblTeamsCompetitors

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblTeamsCompetitors] (
	[teamCompetitorId] [int] NOT NULL IDENTITY (1, 1),
	[teamCompetitorSerial] [smallint] NULL,
	[teamCompetitorFirstName] [varchar](50) NULL,
	[teamCompetitorLastName] [varchar](50) NULL,
	[teamCompetitorBirthDate] [datetime] NULL,
	[teamCompetitorUnit] [varchar](10) NULL,
	[fkCompetitorCategoryId] [tinyint] NULL,
	[fkGenderId] [tinyint] NULL,
	[fkTeamId] [int] NULL,
	[teamCompetitorFinalSelected] [bit] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblTeamsCompetitors] ON
GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (275, 11, N'2446 FirstName 1', N'2446 LastName 1', CAST(0x00008ace00000000 AS datetime), N'2446', 2, 1, 63, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (276, 12, N'2446 LastName 2', N'2446 LastName 2', CAST(0x00008c3b00000000 AS datetime), N'2446', 2, 1, 63, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (277, 13, N'2446 FirstName 3', N'2446 LastName 3', CAST(0x00008ace00000000 AS datetime), N'2446', 1, 2, 63, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (278, 14, N'2446 FirstName 4', N'2446 LastName 4', CAST(0x00008da800000000 AS datetime), N'2446', 1, 1, 63, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (279, 15, N'2446 FirstName 5', N'2446 LastName 5', CAST(0x00008da800000000 AS datetime), N'2446', 2, 2, 63, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (280, 21, N'2671 FirstName 1', N'2671 LastName 1', CAST(0x0000871000000000 AS datetime), N'2671', 2, 1, 64, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (281, 22, N'2671 FirstName 2', N'2671 LastName 2', CAST(0x0000858c00000000 AS datetime), N'2671', 2, 1, 64, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (282, 23, N'2671 FirstName 3', N'2671 LastName 3', CAST(0x0000871000000000 AS datetime), N'2671', 1, 1, 64, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (283, 24, N'2671 FirstName 4', N'2671 LastName 4', CAST(0x00008ace00000000 AS datetime), N'2671', 1, 2, 64, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (284, 25, N'2671 FirstName 5', N'2671 LastName 5', CAST(0x00008aa500000000 AS datetime), N'2671', 1, 2, 64, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (285, 31, N'2931 FirstName 1', N'2931 LastName 1', CAST(0x0000931700000000 AS datetime), N'2931', 1, 1, 65, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (286, 32, N'2931 FirstName 2', N'2931 LastName 2', CAST(0x00008da800000000 AS datetime), N'2931', 2, 1, 65, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (287, 33, N'2931 FirstName 3', N'2931 LastName 3', CAST(0x0000871000000000 AS datetime), N'2931', 2, 2, 65, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (288, 34, N'2931 FirstName 4', N'2931 LastName 4', CAST(0x00008da800000000 AS datetime), N'2931', 1, 1, 65, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (289, 35, N'2931 FirstName 5', N'2931 LastName 5', CAST(0x00008c3b00000000 AS datetime), N'2931', 2, 1, 65, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (290, 41, N'Comp FirstName 1', N'Comp LastName 1', CAST(0x0000874600000000 AS datetime), N'170', 1, 1, 66, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (291, 42, N'Comp FirstName 2', N'Comp LastName 2', CAST(0x00008ace00000000 AS datetime), N'817', 2, 1, 66, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (292, 43, N'Comp LastName 3', N'Comp LastName 3', CAST(0x00008ace00000000 AS datetime), N'2006', 2, 1, 66, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (293, 44, N'Comp LastName 4', N'Comp LastName 4', CAST(0x00008aa500000000 AS datetime), N'2626', 2, 2, 66, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (294, 45, N'Comp LastName 5', N'Comp LastName 5', CAST(0x00008aa500000000 AS datetime), N'921', 2, 1, 66, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (295, 15, N'Denis', N'Shooter 1', CAST(0x0000931700000000 AS datetime), N'2931', 1, 1, 67, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (296, 12, N'Mélanie', N'Shooter 2', CAST(0x0000871000000000 AS datetime), N'2931', 2, 2, 67, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (297, 13, N'Alain', N'Shooter 3', CAST(0x0000000000000000 AS datetime), N'34', 1, 1, 67, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (298, 14, N'', N'Shooter 4', CAST(0x0000000000000000 AS datetime), N'', 1, 1, 67, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (299, 11, N'', N'Shooter 5', CAST(0x0000000000000000 AS datetime), N'', 1, 1, 67, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (305, 31, NULL, NULL, NULL, NULL, NULL, NULL, 69, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (306, 32, NULL, NULL, NULL, NULL, NULL, NULL, 69, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (307, 33, NULL, NULL, NULL, NULL, NULL, NULL, 69, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (308, 34, NULL, NULL, NULL, NULL, NULL, NULL, 69, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (309, 35, NULL, NULL, NULL, NULL, NULL, NULL, 69, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (310, 41, N'', N'', CAST(0x0000000000000000 AS datetime), N'', 1, 1, 70, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (311, 42, NULL, NULL, NULL, NULL, NULL, NULL, 70, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (312, 43, NULL, NULL, NULL, NULL, NULL, NULL, 70, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (313, 44, NULL, NULL, NULL, NULL, NULL, NULL, 70, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (314, 45, NULL, NULL, NULL, NULL, NULL, NULL, 70, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (315, 111, NULL, NULL, NULL, NULL, NULL, NULL, 71, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (316, 112, NULL, NULL, NULL, NULL, NULL, NULL, 71, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (317, 113, NULL, NULL, NULL, NULL, NULL, NULL, 71, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (318, 114, NULL, NULL, NULL, NULL, NULL, NULL, 71, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (319, 115, NULL, NULL, NULL, NULL, NULL, NULL, 71, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (320, 211, NULL, NULL, NULL, NULL, NULL, NULL, 72, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (321, 212, NULL, NULL, NULL, NULL, NULL, NULL, 72, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (322, 213, NULL, NULL, NULL, NULL, NULL, NULL, 72, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (323, 214, NULL, NULL, NULL, NULL, NULL, NULL, 72, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (324, 215, NULL, NULL, NULL, NULL, NULL, NULL, 72, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (325, 311, NULL, NULL, NULL, NULL, NULL, NULL, 73, CAST ('False' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (326, 312, NULL, NULL, NULL, NULL, NULL, NULL, 73, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (327, 313, NULL, NULL, NULL, NULL, NULL, NULL, 73, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (328, 314, NULL, NULL, NULL, NULL, NULL, NULL, 73, CAST ('True' AS bit))

GO
INSERT INTO [dbo].[tblTeamsCompetitors] ([teamCompetitorId], [teamCompetitorSerial], [teamCompetitorFirstName], [teamCompetitorLastName], [teamCompetitorBirthDate], [teamCompetitorUnit], [fkCompetitorCategoryId], [fkGenderId], [fkTeamId], [teamCompetitorFinalSelected])
	VALUES (329, 315, NULL, NULL, NULL, NULL, NULL, NULL, 73, CAST ('True' AS bit))

GO
SET IDENTITY_INSERT [dbo].[tblTeamsCompetitors] OFF
GO

--Table dbo.tblTeamsTypes

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblTeamsTypes] (
	[teamTypeId] [tinyint] NOT NULL IDENTITY (1, 1),
	[teamTypeNameFr] [varchar](50) NULL,
	[teamTypeNameEn] [varchar](50) NULL,
	[teamTypeLetterFr] [char](2) NULL,
	[teamTypeLetterEn] [char](2) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblTeamsTypes] ON
GO
INSERT INTO [dbo].[tblTeamsTypes] ([teamTypeId], [teamTypeNameFr], [teamTypeNameEn], [teamTypeLetterFr], [teamTypeLetterEn])
	VALUES (1, N'Unité', N'Unit', N'U ', N'U ')

GO
INSERT INTO [dbo].[tblTeamsTypes] ([teamTypeId], [teamTypeNameFr], [teamTypeNameEn], [teamTypeLetterFr], [teamTypeLetterEn])
	VALUES (2, N'Composée', N'Composite', N'C ', N'C ')

GO
SET IDENTITY_INSERT [dbo].[tblTeamsTypes] OFF
GO

--Table dbo.tblTexts

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblTexts] (
	[textId] [smallint] NOT NULL IDENTITY (1, 1),
	[textName] [varchar](50) NULL,
	[text] [text] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblTexts] ON
GO
INSERT INTO [dbo].[tblTexts] ([textId], [textName], [text])
	VALUES (1, N'resultsHomePageFr', N'Bienvenue dans la section des résultats.')

GO
INSERT INTO [dbo].[tblTexts] ([textId], [textName], [text])
	VALUES (2, N'resultsHomePageEn', N'Welcome in the results section.')

GO
SET IDENTITY_INSERT [dbo].[tblTexts] OFF
GO

--Table dbo.tblUsers

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblUsers] (
	[userId] [int] NOT NULL IDENTITY (1, 1),
	[userLogin] [nchar](10) NOT NULL,
	[userPword] [nchar](10) NOT NULL,
	[userFirstName] [varchar](50) NULL,
	[userLastName] [varchar](50) NULL,
	[fkLanguageId] [tinyint] NULL,
	[fkUserRuleId] [tinyint] NULL,
	[fkEventIdRestricted] [int] NULL);
GO

SET IDENTITY_INSERT [dbo].[tblUsers] ON
GO
INSERT INTO [dbo].[tblUsers] ([userId], [userLogin], [userPword], [userFirstName], [userLastName], [fkLanguageId], [fkUserRuleId], [fkEventIdRestricted])
	VALUES (1, N'dricard   ', N'denmel03! ', N'Denis', N'Ricard', 1, 1, 0)

GO
INSERT INTO [dbo].[tblUsers] ([userId], [userLogin], [userPword], [userFirstName], [userLastName], [fkLanguageId], [fkUserRuleId], [fkEventIdRestricted])
	VALUES (5, N'ngonthier ', N'bia1234   ', N'Normand', N'Gonthier', 1, 2, 0)

GO
INSERT INTO [dbo].[tblUsers] ([userId], [userLogin], [userPword], [userFirstName], [userLastName], [fkLanguageId], [fkUserRuleId], [fkEventIdRestricted])
	VALUES (7, N'ddupuis   ', N'tir4321   ', N'David', N'Dupuis', 1, 3, 0)

GO
INSERT INTO [dbo].[tblUsers] ([userId], [userLogin], [userPword], [userFirstName], [userLastName], [fkLanguageId], [fkUserRuleId], [fkEventIdRestricted])
	VALUES (8, N'guest     ', N'guest123  ', N'Guest', N'Guest', 1, 4, 39)

GO
INSERT INTO [dbo].[tblUsers] ([userId], [userLogin], [userPword], [userFirstName], [userLastName], [fkLanguageId], [fkUserRuleId], [fkEventIdRestricted])
	VALUES (10, N'aroy      ', N'tir1234   ', N'Alain', N'Roy', NULL, 2, 39)

GO
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
GO

--Table dbo.tblUsersRules

USE [dbrct]
GO

--Create table and its columns
CREATE TABLE [dbo].[tblUsersRules] (
	[userRuleId] [tinyint] NOT NULL IDENTITY (1, 1),
	[userRuleName] [varchar](50) NULL);
GO

SET IDENTITY_INSERT [dbo].[tblUsersRules] ON
GO
INSERT INTO [dbo].[tblUsersRules] ([userRuleId], [userRuleName])
	VALUES (1, N'AdminMaster')

GO
INSERT INTO [dbo].[tblUsersRules] ([userRuleId], [userRuleName])
	VALUES (2, N'Admin')

GO
INSERT INTO [dbo].[tblUsersRules] ([userRuleId], [userRuleName])
	VALUES (3, N'User')

GO
INSERT INTO [dbo].[tblUsersRules] ([userRuleId], [userRuleName])
	VALUES (4, N'Gest')

GO
INSERT INTO [dbo].[tblUsersRules] ([userRuleId], [userRuleName])
	VALUES (5, N'Disable')

GO
SET IDENTITY_INSERT [dbo].[tblUsersRules] OFF
GO

--Executing Entities
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vwEventsEventsTypes]
AS
SELECT     dbo.tblEvents.eventId, dbo.tblEvents.eventNameFr, dbo.tblEvents.eventNameEn, CONVERT(varchar, dbo.tblEvents.eventStartDate, 111) AS StartDate, 
                      CONVERT(varchar, dbo.tblEvents.eventEndDate, 111) AS EndDate, dbo.tblEvents.eventLocation, dbo.tblEvents.fkEventTypeId, dbo.tblEventsTypes.eventTypeId, 
                      dbo.tblEventsTypes.eventTypeNameFr, dbo.tblEventsTypes.eventTypeNameEn, dbo.tblEvents.eventShowPublicResults
FROM         dbo.tblEvents INNER JOIN
                      dbo.tblEventsTypes ON dbo.tblEvents.fkEventTypeId = dbo.tblEventsTypes.eventTypeId

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vwTeamsCompetitorsCompetitorsCategoriesGenders]
AS
SELECT     dbo.tblTeamsCompetitors.teamCompetitorId, dbo.tblTeamsCompetitors.teamCompetitorSerial, dbo.tblTeamsCompetitors.teamCompetitorFirstName, 
                      dbo.tblTeamsCompetitors.teamCompetitorLastName, CONVERT(varchar, dbo.tblTeamsCompetitors.teamCompetitorBirthDate, 111) AS DDN, 
                      dbo.tblTeamsCompetitors.teamCompetitorUnit, dbo.tblTeamsCompetitors.fkCompetitorCategoryId, dbo.tblTeamsCompetitors.fkGenderId, 
                      dbo.tblTeamsCompetitors.fkTeamId, dbo.tblGenders.genderId, dbo.tblGenders.genderNameFr, dbo.tblGenders.genderNameEn, dbo.tblGenders.genderLetter, 
                      dbo.tblCompetitorsCategories.competitorCategoryId, dbo.tblCompetitorsCategories.competitorCategoryNameFr, 
                      dbo.tblCompetitorsCategories.competitorCategoryNameEn, dbo.tblCompetitorsCategories.competitorCategoryLetterFr, 
                      dbo.tblCompetitorsCategories.competitorCategoryLetterEn, dbo.tblTeamsCompetitors.teamCompetitorFinalSelected
FROM         dbo.tblTeamsCompetitors LEFT OUTER JOIN
                      dbo.tblGenders ON dbo.tblTeamsCompetitors.fkGenderId = dbo.tblGenders.genderId LEFT OUTER JOIN
                      dbo.tblCompetitorsCategories ON dbo.tblTeamsCompetitors.fkCompetitorCategoryId = dbo.tblCompetitorsCategories.competitorCategoryId

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vwResultsUsersPageResultsAdd]
AS
SELECT     dbo.tblResults.resultId, dbo.tblResults.result, dbo.tblResults.resultTargetSerial, CONVERT(varchar, dbo.tblResults.resultDateTimeInsert, 120) AS DateInsert, 
                      dbo.tblUsers.userLogin, dbo.tblResults.fkCompetitionChapterId
FROM         dbo.tblResults INNER JOIN
                      dbo.tblUsers ON dbo.tblResults.fkUserId = dbo.tblUsers.userId

GO

GO

--Indexes of table dbo.tblChaptersRelays
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblChaptersRelays] ADD CONSTRAINT [PK_tblChaptersRelays] PRIMARY KEY CLUSTERED ([chapterRelayId]) 
GO

--Indexes of table dbo.tblCompetitions
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblCompetitions] ADD CONSTRAINT [PK_tblCompetitions] PRIMARY KEY CLUSTERED ([competitionId]) 
GO

--Indexes of table dbo.tblCompetitionsChapters
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblCompetitionsChapters] ADD CONSTRAINT [PK_tblCompetitionsChapters] PRIMARY KEY CLUSTERED ([competitionChapterId]) 
GO

--Indexes of table dbo.tblCompetitionsTypes
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblCompetitionsTypes] ADD CONSTRAINT [PK_tblCompetitionsTypes] PRIMARY KEY CLUSTERED ([competitionTypeId]) 
GO

--Indexes of table dbo.tblCompetitorsCategories
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblCompetitorsCategories] ADD CONSTRAINT [PK_tblCompetitorsCategories] PRIMARY KEY CLUSTERED ([competitorCategoryId]) 
GO

--Indexes of table dbo.tblEvents
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblEvents] ADD CONSTRAINT [PK_tblEvents] PRIMARY KEY CLUSTERED ([eventId]) 
GO

--Indexes of table dbo.tblEventsTypes
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblEventsTypes] ADD CONSTRAINT [PK_tblEventsTypes] PRIMARY KEY CLUSTERED ([eventTypeId]) 
GO

--Indexes of table dbo.tblFinalsLines
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblFinalsLines] ADD CONSTRAINT [PK_tblFinalsLines] PRIMARY KEY CLUSTERED ([finalLineId]) 
GO

--Indexes of table dbo.tblGenders
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblGenders] ADD CONSTRAINT [PK_tblGenders] PRIMARY KEY CLUSTERED ([genderId]) 
GO

--Indexes of table dbo.tblLanguages
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblLanguages] ADD CONSTRAINT [PK_tblLanguages] PRIMARY KEY CLUSTERED ([languageId]) 
GO

--Indexes of table dbo.tblParamsNumeric
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblParamsNumeric] ADD CONSTRAINT [PK_tblParams] PRIMARY KEY CLUSTERED ([paramId]) 
GO

--Indexes of table dbo.tblParamsTexts
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblParamsTexts] ADD CONSTRAINT [PK_tblParamsTexts] PRIMARY KEY CLUSTERED ([paramTextId]) 
GO

--Indexes of table dbo.tblPublicHtmlTexts
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblPublicHtmlTexts] ADD CONSTRAINT [PK_tblPublicHtmlTexts] PRIMARY KEY CLUSTERED ([publicHtmlTextId]) 
GO

--Indexes of table dbo.tblRegions
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblRegions] ADD CONSTRAINT [PK_tblRegions] PRIMARY KEY CLUSTERED ([regionId]) 
GO

--Indexes of table dbo.tblRegionsEvents
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblRegionsEvents] ADD CONSTRAINT [PK_tblRegionsEvents] PRIMARY KEY CLUSTERED ([regionEventId]) 
GO

--Indexes of table dbo.tblResults
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblResults] ADD CONSTRAINT [PK_tblResults] PRIMARY KEY CLUSTERED ([resultId]) 
GO

--Indexes of table dbo.tblResultsIRBR
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblResultsIRBR] ADD CONSTRAINT [PK_tblResultsIRBR] PRIMARY KEY CLUSTERED ([resultIRBRId]) 
GO

--Indexes of table dbo.tblTeams
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblTeams] ADD CONSTRAINT [PK_tblTeams] PRIMARY KEY CLUSTERED ([teamId]) 
GO

--Indexes of table dbo.tblTeamsCompetitors
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblTeamsCompetitors] ADD CONSTRAINT [PK_tblTeamsCompetitors] PRIMARY KEY CLUSTERED ([teamCompetitorId]) 
GO

--Indexes of table dbo.tblTeamsTypes
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblTeamsTypes] ADD CONSTRAINT [PK_tblTeamsTypes] PRIMARY KEY CLUSTERED ([teamTypeId]) 
GO

--Indexes of table dbo.tblTexts
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblTexts] ADD CONSTRAINT [PK_tblTexts] PRIMARY KEY CLUSTERED ([textId]) 
GO

--Indexes of table dbo.tblUsers
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblUsers] ADD CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED ([userId]) 
GO

--Indexes of table dbo.tblUsersRules
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[tblUsersRules] ADD CONSTRAINT [PK_tblUsersRules] PRIMARY KEY CLUSTERED ([userRuleId]) 
GO
