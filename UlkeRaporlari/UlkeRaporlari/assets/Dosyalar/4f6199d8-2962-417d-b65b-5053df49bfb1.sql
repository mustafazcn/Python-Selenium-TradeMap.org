USE [master]
GO
/****** Object:  Database [AkrediteMaddeler]    Script Date: 14.06.2021 09:27:32 ******/
CREATE DATABASE [AkrediteMaddeler]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AkrediteMaddeler', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AkrediteMaddeler.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AkrediteMaddeler_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\AkrediteMaddeler_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AkrediteMaddeler] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AkrediteMaddeler].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AkrediteMaddeler] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET ARITHABORT OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AkrediteMaddeler] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AkrediteMaddeler] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AkrediteMaddeler] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AkrediteMaddeler] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AkrediteMaddeler] SET  MULTI_USER 
GO
ALTER DATABASE [AkrediteMaddeler] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AkrediteMaddeler] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AkrediteMaddeler] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AkrediteMaddeler] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AkrediteMaddeler] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AkrediteMaddeler] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [AkrediteMaddeler] SET QUERY_STORE = OFF
GO
USE [AkrediteMaddeler]
GO
/****** Object:  Table [dbo].[AkrediteMaddeler]    Script Date: 14.06.2021 09:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AkrediteMaddeler](
	[akrediteMaddeId] [int] IDENTITY(1,1) NOT NULL,
	[akrediteMaddeBaslik] [nvarchar](50) NULL,
	[akrediteMaddeAciklama] [nvarchar](500) NULL,
	[akrediteMaddeYil] [int] NULL,
	[akrediteMaddeSil] [bit] NULL,
 CONSTRAINT [PK_AkrediteMaddeler] PRIMARY KEY CLUSTERED 
(
	[akrediteMaddeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Base_AkrediteMaddeler]    Script Date: 14.06.2021 09:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Base_AkrediteMaddeler]
AS
SELECT        akrediteMaddeId, akrediteMaddeBaslik, akrediteMaddeAciklama, akrediteMaddeYil
FROM            dbo.AkrediteMaddeler
WHERE        (akrediteMaddeSil = 0)
GO
/****** Object:  Table [dbo].[Dosyalar]    Script Date: 14.06.2021 09:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dosyalar](
	[dosyaId] [int] IDENTITY(1,1) NOT NULL,
	[AkrediteMaddeId] [int] NULL,
	[dosyaUrl] [nvarchar](500) NULL,
	[dosyaSil] [bit] NULL,
 CONSTRAINT [PK_Dosyalar] PRIMARY KEY CLUSTERED 
(
	[dosyaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Base_Dosyalar]    Script Date: 14.06.2021 09:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Base_Dosyalar]
AS
SELECT        dosyaId, AkrediteMaddeId, dosyaUrl
FROM            dbo.Dosyalar
WHERE        (dosyaSil = 0)
GO
/****** Object:  View [dbo].[View_Presentation_Dosyalar]    Script Date: 14.06.2021 09:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Presentation_Dosyalar]
AS
SELECT        dbo.View_Base_AkrediteMaddeler.akrediteMaddeId, dbo.View_Base_AkrediteMaddeler.akrediteMaddeBaslik, dbo.View_Base_AkrediteMaddeler.akrediteMaddeAciklama, dbo.View_Base_AkrediteMaddeler.akrediteMaddeYil, 
                         dbo.View_Base_Dosyalar.dosyaId, dbo.View_Base_Dosyalar.dosyaUrl
FROM            dbo.View_Base_AkrediteMaddeler LEFT OUTER JOIN
                         dbo.View_Base_Dosyalar ON dbo.View_Base_AkrediteMaddeler.akrediteMaddeId = dbo.View_Base_Dosyalar.AkrediteMaddeId
GO
/****** Object:  StoredProcedure [dbo].[Proc_AkrediteMaddeler_Islem]    Script Date: 14.06.2021 09:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_AkrediteMaddeler_Islem]
	@Islem					nvarchar(50),
	@AkrediteMaddeId		int,
	@AkrediteMaddeBaslik    nvarchar(50),
	@AkrediteMaddeAciklama	nvarchar(50),
	@AkrediteMaddeYil		int
AS
BEGIN
	if(@Islem='Yeni')
	begin
		INSERT INTO [dbo].[AkrediteMaddeler]
           ([akrediteMaddeBaslik]
           ,[akrediteMaddeAciklama]
           ,[akrediteMaddeYil]
           ,[akrediteMaddeSil]
         )
		VALUES
			(@AkrediteMaddeBaslik
			,@AkrediteMaddeAciklama
			,@AkrediteMaddeYil
			,0 
			)

		   Select top 1 * From View_Base_AkrediteMaddeler Order By akrediteMaddeId desc
	end
	else if(@Islem='Guncelle')
	begin
		Update [dbo].[AkrediteMaddeler] Set
			[akrediteMaddeBaslik]		=ISNULL(@AkrediteMaddeBaslik,[akrediteMaddeBaslik]),
			[akrediteMaddeAciklama]	=ISNULL(@AkrediteMaddeAciklama,[akrediteMaddeAciklama]),
			[akrediteMaddeYil]	=ISNULL(@AkrediteMaddeYil,[akrediteMaddeYil])
		Where akrediteMaddeId=@AkrediteMaddeId

		Select * From View_Base_AkrediteMaddeler Where akrediteMaddeId=@AkrediteMaddeId
	end
	else if(@Islem='Sil')
	begin
		Select * From View_Base_AkrediteMaddeler Where akrediteMaddeId=@AkrediteMaddeId

		Update [dbo].[AkrediteMaddeler] Set
			[akrediteMaddeSil]=1
		Where akrediteMaddeId=@AkrediteMaddeId
	end
	else if(@Islem='Liste')
	begin
		Select * From View_Base_AkrediteMaddeler 
		Where (akrediteMaddeId=@AkrediteMaddeId or @AkrediteMaddeId=0)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Dosyalar_Islem]    Script Date: 14.06.2021 09:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Dosyalar_Islem]
	@Islem					nvarchar(50),
	@DosyaId				int,
	@AkrediteMaddeId		int,
	@DosyaUrl				nvarchar(500)
AS
BEGIN
	if(@Islem='Yeni')
	begin
		INSERT INTO [dbo].[Dosyalar]
           ([AkrediteMaddeId]
           ,[dosyaUrl]
           ,[dosyaSil]
         )
		VALUES
			(@AkrediteMaddeId
			,@DosyaUrl
			,0 
			)

		   Select top 1 * From View_Presentation_Dosyalar Order By dosyaId desc
	end
	else if(@Islem='Guncelle')
	begin
		Update [dbo].[Dosyalar] Set
			[AkrediteMaddeId]	=ISNULL(@AkrediteMaddeId,[AkrediteMaddeId]),
			[dosyaUrl]			=ISNULL(@DosyaUrl,[dosyaUrl])
		Where dosyaId=@DosyaId

		Select * From View_Presentation_Dosyalar Where dosyaId=@DosyaId
	end
	else if(@Islem='Sil')
	begin
		Select * From View_Presentation_Dosyalar Where dosyaId=@DosyaId

		Update [dbo].[Dosyalar] Set
			[dosyaSil]=1
		Where dosyaId=@DosyaId
	end
	else if(@Islem='Liste')
	begin
		Select * From View_Presentation_Dosyalar
		Where (dosyaId=@DosyaId or @DosyaId=0)
		and ([AkrediteMaddeId]=@AkrediteMaddeId or @AkrediteMaddeId=0)
	end
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AkrediteMaddeler"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 199
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_AkrediteMaddeler'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_AkrediteMaddeler'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Dosyalar"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_Dosyalar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_Dosyalar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "View_Base_AkrediteMaddeler"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 174
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_Base_Dosyalar"
            Begin Extent = 
               Top = 6
               Left = 293
               Bottom = 166
               Right = 473
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Presentation_Dosyalar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Presentation_Dosyalar'
GO
USE [master]
GO
ALTER DATABASE [AkrediteMaddeler] SET  READ_WRITE 
GO
