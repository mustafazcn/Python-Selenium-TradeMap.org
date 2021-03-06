USE [TradeMapDB]
GO
/****** Object:  Table [dbo].[UlkeListesi]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UlkeListesi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ulkeAd] [nvarchar](60) NULL,
 CONSTRAINT [PK_UlkeListesi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Base_Ulkeler]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Base_Ulkeler]
AS
SELECT        ID, ulkeAd
FROM            dbo.UlkeListesi
GO
/****** Object:  Table [dbo].[Ozel_Ulke_Raporu]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ozel_Ulke_Raporu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ulkeID] [int] NULL,
	[Yil] [nvarchar](7) NULL,
	[Ithalat] [decimal](18, 2) NULL,
	[Ihracat] [decimal](18, 2) NULL,
	[Hacim] [decimal](18, 2) NULL,
	[Denge] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Ozel_Ulke_Raporu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Base_OzelUlkeRapor]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Base_OzelUlkeRapor]
AS
SELECT        ID, ulkeID, Yil, Ithalat, Ihracat, Hacim, Denge
FROM            dbo.Ozel_Ulke_Raporu
GO
/****** Object:  Table [dbo].[Genel_Ulke_Raporu]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genel_Ulke_Raporu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ulkeID] [int] NULL,
	[Yil] [nvarchar](7) NULL,
	[Ithalat_ulkeID] [int] NULL,
	[Ithalat] [decimal](18, 2) NULL,
	[Ihracat_ulkeID] [int] NULL,
	[Ihracat] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Genel_Ulke_Raporu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Base_GenelUlkeRapor]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Base_GenelUlkeRapor]
AS
SELECT        ID, ulkeID, Yil, Ithalat_ulkeID, Ithalat, Ihracat_ulkeID, Ihracat
FROM            dbo.Genel_Ulke_Raporu
GO
/****** Object:  View [dbo].[View_Presentation_OzelUlke]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Presentation_OzelUlke]
AS
SELECT        dbo.View_Base_OzelUlkeRapor.ulkeID, dbo.View_Base_Ulkeler.ulkeAd, dbo.View_Base_OzelUlkeRapor.Yil, dbo.View_Base_OzelUlkeRapor.Ithalat, dbo.View_Base_OzelUlkeRapor.Ihracat, 
                         dbo.View_Base_OzelUlkeRapor.Hacim, dbo.View_Base_OzelUlkeRapor.Denge
FROM            dbo.View_Base_OzelUlkeRapor LEFT OUTER JOIN
                         dbo.View_Base_Ulkeler ON dbo.View_Base_OzelUlkeRapor.ulkeID = dbo.View_Base_Ulkeler.ID
GO
/****** Object:  View [dbo].[View_Presentation_GenelUlke]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Presentation_GenelUlke]
AS
SELECT        dbo.View_Base_GenelUlkeRapor.ID, dbo.View_Base_Ulkeler.ulkeAd, dbo.View_Base_GenelUlkeRapor.Yil,
                             (SELECT        TOP (1) ulkeAd
                               FROM            dbo.View_Base_Ulkeler AS vBU
                               WHERE        (ID = dbo.View_Base_GenelUlkeRapor.Ithalat_ulkeID)) AS IthalatUlkeAdi, dbo.View_Base_GenelUlkeRapor.Ithalat,
                             (SELECT        TOP (1) ulkeAd
                               FROM            dbo.View_Base_Ulkeler AS vBU
                               WHERE        (ID = dbo.View_Base_GenelUlkeRapor.Ihracat_ulkeID)) AS IhracatUlkeAdi, dbo.View_Base_GenelUlkeRapor.Ihracat
FROM            dbo.View_Base_GenelUlkeRapor LEFT OUTER JOIN
                         dbo.View_Base_Ulkeler ON dbo.View_Base_Ulkeler.ID = dbo.View_Base_GenelUlkeRapor.ulkeID
GO
SET IDENTITY_INSERT [dbo].[Genel_Ulke_Raporu] ON 

INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (1, 1, N'2011', 2, CAST(21693336.00 AS Decimal(18, 2)), 3, CAST(13950825.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (2, 1, N'2012', 2, CAST(21295242.00 AS Decimal(18, 2)), 3, CAST(13124375.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (3, 1, N'2013', 2, CAST(24685885.00 AS Decimal(18, 2)), 3, CAST(13702577.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (4, 1, N'2014', 2, CAST(24918224.00 AS Decimal(18, 2)), 3, CAST(15147423.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (5, 1, N'2015', 2, CAST(24873457.00 AS Decimal(18, 2)), 3, CAST(13417478.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (6, 1, N'2016', 2, CAST(25440454.00 AS Decimal(18, 2)), 3, CAST(14004848.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (7, 1, N'2017', 2, CAST(23370620.00 AS Decimal(18, 2)), 3, CAST(15118910.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (8, 1, N'2018', 2, CAST(20719061.00 AS Decimal(18, 2)), 3, CAST(16137388.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (9, 1, N'2019', 2, CAST(19127972.00 AS Decimal(18, 2)), 3, CAST(16624070.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (10, 1, N'2020', 2, CAST(23040812.00 AS Decimal(18, 2)), 3, CAST(15980400.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (11, 1, N'2011', 3, CAST(22985567.00 AS Decimal(18, 2)), 13, CAST(8151430.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (12, 1, N'2012', 3, CAST(21400614.00 AS Decimal(18, 2)), 13, CAST(8693599.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (13, 1, N'2013', 3, CAST(24182422.00 AS Decimal(18, 2)), 13, CAST(8785124.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (14, 1, N'2014', 3, CAST(22369476.00 AS Decimal(18, 2)), 13, CAST(9903172.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (15, 1, N'2015', 3, CAST(21351883.00 AS Decimal(18, 2)), 13, CAST(10556863.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (16, 1, N'2016', 3, CAST(21473789.00 AS Decimal(18, 2)), 13, CAST(11690650.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (17, 1, N'2017', 3, CAST(21301869.00 AS Decimal(18, 2)), 13, CAST(9603189.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (18, 1, N'2018', 3, CAST(20407294.00 AS Decimal(18, 2)), 13, CAST(11107336.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (19, 1, N'2019', 3, CAST(19279082.00 AS Decimal(18, 2)), 13, CAST(11281350.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (20, 1, N'2020', 3, CAST(21732800.00 AS Decimal(18, 2)), 13, CAST(11236969.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (21, 1, N'2011', 4, CAST(23952914.00 AS Decimal(18, 2)), 6, CAST(4585849.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (22, 1, N'2012', 4, CAST(26625286.00 AS Decimal(18, 2)), 6, CAST(5606487.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (23, 1, N'2013', 4, CAST(25064214.00 AS Decimal(18, 2)), 6, CAST(5641170.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (24, 1, N'2014', 4, CAST(25288597.00 AS Decimal(18, 2)), 6, CAST(6342194.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (25, 1, N'2015', 4, CAST(20401756.00 AS Decimal(18, 2)), 6, CAST(6395899.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (26, 1, N'2016', 4, CAST(15160961.00 AS Decimal(18, 2)), 6, CAST(6627394.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (27, 1, N'2017', 4, CAST(19514094.00 AS Decimal(18, 2)), 6, CAST(8654268.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (28, 1, N'2018', 4, CAST(21989574.00 AS Decimal(18, 2)), 6, CAST(8304672.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (29, 1, N'2019', 4, CAST(23116867.00 AS Decimal(18, 2)), 6, CAST(8971874.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (30, 1, N'2020', 4, CAST(17829236.00 AS Decimal(18, 2)), 6, CAST(10183213.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (31, 1, N'2011', 5, CAST(8788338.00 AS Decimal(18, 2)), 8, CAST(8310130.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (32, 1, N'2012', 5, CAST(12589128.00 AS Decimal(18, 2)), 8, CAST(10822144.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (33, 1, N'2013', 5, CAST(13413450.00 AS Decimal(18, 2)), 8, CAST(11948905.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (34, 1, N'2014', 5, CAST(13654033.00 AS Decimal(18, 2)), 8, CAST(10887826.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (35, 1, N'2015', 5, CAST(9781883.00 AS Decimal(18, 2)), 8, CAST(8550298.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (36, 1, N'2016', 5, CAST(6738141.00 AS Decimal(18, 2)), 8, CAST(7640287.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (37, 1, N'2017', 5, CAST(8239672.00 AS Decimal(18, 2)), 8, CAST(9054612.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (38, 1, N'2018', 5, CAST(11038416.00 AS Decimal(18, 2)), 8, CAST(8346276.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (39, 1, N'2019', 5, CAST(15148738.00 AS Decimal(18, 2)), 8, CAST(10224285.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (40, 1, N'2020', 5, CAST(13685863.00 AS Decimal(18, 2)), 8, CAST(9142515.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (41, 1, N'2011', 6, CAST(16042073.00 AS Decimal(18, 2)), 7, CAST(7854463.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (42, 1, N'2012', 6, CAST(14130625.00 AS Decimal(18, 2)), 7, CAST(6373488.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (43, 1, N'2013', 6, CAST(12596623.00 AS Decimal(18, 2)), 7, CAST(6718743.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (44, 1, N'2014', 6, CAST(12727960.00 AS Decimal(18, 2)), 7, CAST(7141112.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (45, 1, N'2015', 6, CAST(11141465.00 AS Decimal(18, 2)), 7, CAST(6887778.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (46, 1, N'2016', 6, CAST(10867491.00 AS Decimal(18, 2)), 7, CAST(7583132.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (47, 1, N'2017', 6, CAST(11951744.00 AS Decimal(18, 2)), 7, CAST(8473629.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (48, 1, N'2018', 6, CAST(12377681.00 AS Decimal(18, 2)), 7, CAST(9560597.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (49, 1, N'2019', 6, CAST(11847481.00 AS Decimal(18, 2)), 7, CAST(9754698.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (50, 1, N'2020', 6, CAST(11525182.00 AS Decimal(18, 2)), 7, CAST(8082942.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (51, 1, N'2011', 7, CAST(13452359.00 AS Decimal(18, 2)), 10, CAST(6805821.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (52, 1, N'2012', 7, CAST(13345874.00 AS Decimal(18, 2)), 10, CAST(6198536.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (53, 1, N'2013', 7, CAST(12887237.00 AS Decimal(18, 2)), 10, CAST(6376704.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (54, 1, N'2014', 7, CAST(12059098.00 AS Decimal(18, 2)), 10, CAST(6467863.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (55, 1, N'2015', 7, CAST(10641582.00 AS Decimal(18, 2)), 10, CAST(5850226.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (56, 1, N'2016', 7, CAST(10220724.00 AS Decimal(18, 2)), 10, CAST(6027992.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (57, 1, N'2017', 7, CAST(11306054.00 AS Decimal(18, 2)), 10, CAST(6589874.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (58, 1, N'2018', 7, CAST(10155669.00 AS Decimal(18, 2)), 10, CAST(7293603.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (59, 1, N'2019', 7, CAST(9350999.00 AS Decimal(18, 2)), 10, CAST(7952702.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (60, 1, N'2020', 7, CAST(9201429.00 AS Decimal(18, 2)), 10, CAST(7204647.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (61, 1, N'2011', 8, CAST(86753.00 AS Decimal(18, 2)), 14, CAST(3917600.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (62, 1, N'2012', 8, CAST(149328.00 AS Decimal(18, 2)), 14, CAST(3717345.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (63, 1, N'2013', 8, CAST(145684.00 AS Decimal(18, 2)), 14, CAST(4334196.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (64, 1, N'2014', 8, CAST(268544.00 AS Decimal(18, 2)), 14, CAST(4749584.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (65, 1, N'2015', 8, CAST(296505.00 AS Decimal(18, 2)), 14, CAST(4742576.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (66, 1, N'2016', 8, CAST(836298.00 AS Decimal(18, 2)), 14, CAST(4993394.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (67, 1, N'2017', 8, CAST(1527573.00 AS Decimal(18, 2)), 14, CAST(6302135.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (68, 1, N'2018', 8, CAST(1420433.00 AS Decimal(18, 2)), 14, CAST(7708490.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (69, 1, N'2019', 8, CAST(2678193.00 AS Decimal(18, 2)), 14, CAST(8141147.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (70, 1, N'2020', 8, CAST(8201655.00 AS Decimal(18, 2)), 14, CAST(6684540.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (71, 1, N'2011', 9, CAST(5021487.00 AS Decimal(18, 2)), 18, CAST(3243080.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (72, 1, N'2012', 9, CAST(4307344.00 AS Decimal(18, 2)), 18, CAST(3244429.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (73, 1, N'2013', 9, CAST(9647999.00 AS Decimal(18, 2)), 18, CAST(3538043.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (74, 1, N'2014', 9, CAST(4825458.00 AS Decimal(18, 2)), 18, CAST(3458689.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (75, 1, N'2015', 9, CAST(2449606.00 AS Decimal(18, 2)), 18, CAST(3154911.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (76, 1, N'2016', 9, CAST(2506215.00 AS Decimal(18, 2)), 18, CAST(3589553.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (77, 1, N'2017', 9, CAST(6903610.00 AS Decimal(18, 2)), 18, CAST(3864486.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (78, 1, N'2018', 9, CAST(2818664.00 AS Decimal(18, 2)), 18, CAST(4760826.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (79, 1, N'2019', 9, CAST(3377053.00 AS Decimal(18, 2)), 18, CAST(5762607.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (80, 1, N'2020', 9, CAST(7771743.00 AS Decimal(18, 2)), 18, CAST(5195418.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (81, 1, N'2011', 10, CAST(9229558.00 AS Decimal(18, 2)), 30, CAST(2391148.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (82, 1, N'2012', 10, CAST(8589896.00 AS Decimal(18, 2)), 30, CAST(2329531.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (83, 1, N'2013', 10, CAST(8079840.00 AS Decimal(18, 2)), 30, CAST(2649663.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (84, 1, N'2014', 10, CAST(8122571.00 AS Decimal(18, 2)), 30, CAST(2950902.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (85, 1, N'2015', 10, CAST(7597687.00 AS Decimal(18, 2)), 30, CAST(2698141.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (86, 1, N'2016', 10, CAST(7364555.00 AS Decimal(18, 2)), 30, CAST(2956451.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (87, 1, N'2017', 10, CAST(8070897.00 AS Decimal(18, 2)), 30, CAST(3407436.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (88, 1, N'2018', 10, CAST(7413025.00 AS Decimal(18, 2)), 30, CAST(3894506.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (89, 1, N'2019', 10, CAST(6760052.00 AS Decimal(18, 2)), 30, CAST(4464351.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (90, 1, N'2020', 10, CAST(6988092.00 AS Decimal(18, 2)), 30, CAST(4704455.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (91, 1, N'2011', 11, CAST(6298483.00 AS Decimal(18, 2)), 4, CAST(5992633.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (92, 1, N'2012', 11, CAST(5660093.00 AS Decimal(18, 2)), 4, CAST(6680777.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (93, 1, N'2013', 11, CAST(6088318.00 AS Decimal(18, 2)), 4, CAST(6964209.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (94, 1, N'2014', 11, CAST(7548319.00 AS Decimal(18, 2)), 4, CAST(5943014.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (95, 1, N'2015', 11, CAST(7057423.00 AS Decimal(18, 2)), 4, CAST(3588657.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (96, 1, N'2016', 11, CAST(6384206.00 AS Decimal(18, 2)), 4, CAST(1733569.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (97, 1, N'2017', 11, CAST(6608874.00 AS Decimal(18, 2)), 4, CAST(2734316.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (98, 1, N'2018', 11, CAST(6343174.00 AS Decimal(18, 2)), 4, CAST(3399827.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (99, 1, N'2019', 11, CAST(5776952.00 AS Decimal(18, 2)), 4, CAST(4153202.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (100, 1, N'2020', 11, CAST(5734339.00 AS Decimal(18, 2)), 4, CAST(4506813.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (101, 1, N'2011', 12, CAST(1649456.00 AS Decimal(18, 2)), 21, CAST(2878760.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (102, 1, N'2012', 12, CAST(3596545.00 AS Decimal(18, 2)), 21, CAST(2495427.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (103, 1, N'2013', 12, CAST(5384468.00 AS Decimal(18, 2)), 21, CAST(2616313.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (104, 1, N'2014', 12, CAST(3253024.00 AS Decimal(18, 2)), 21, CAST(3008011.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (105, 1, N'2015', 12, CAST(2008690.00 AS Decimal(18, 2)), 21, CAST(2815548.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (106, 1, N'2016', 12, CAST(3701152.00 AS Decimal(18, 2)), 21, CAST(2672005.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (107, 1, N'2017', 12, CAST(5546921.00 AS Decimal(18, 2)), 21, CAST(3139188.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (108, 1, N'2018', 12, CAST(3780736.00 AS Decimal(18, 2)), 21, CAST(3867122.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (109, 1, N'2019', 12, CAST(4388996.00 AS Decimal(18, 2)), 21, CAST(4073769.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (110, 1, N'2020', 12, CAST(5603801.00 AS Decimal(18, 2)), 21, CAST(3895656.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (111, 1, N'2011', 13, CAST(5840380.00 AS Decimal(18, 2)), 17, CAST(2451030.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (112, 1, N'2012', 13, CAST(5629455.00 AS Decimal(18, 2)), 17, CAST(2359575.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (113, 1, N'2013', 13, CAST(6281414.00 AS Decimal(18, 2)), 17, CAST(2573804.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (114, 1, N'2014', 13, CAST(5932227.00 AS Decimal(18, 2)), 17, CAST(2939108.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (115, 1, N'2015', 13, CAST(5541277.00 AS Decimal(18, 2)), 17, CAST(2557805.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (116, 1, N'2016', 13, CAST(5320624.00 AS Decimal(18, 2)), 17, CAST(2548729.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (117, 1, N'2017', 13, CAST(6548620.00 AS Decimal(18, 2)), 17, CAST(3151422.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (118, 1, N'2018', 13, CAST(7446107.00 AS Decimal(18, 2)), 17, CAST(3950970.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (119, 1, N'2019', 13, CAST(5638293.00 AS Decimal(18, 2)), 17, CAST(3396818.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (120, 1, N'2020', 13, CAST(5582391.00 AS Decimal(18, 2)), 17, CAST(3634855.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (121, 1, N'2011', 14, CAST(6196466.00 AS Decimal(18, 2)), 20, CAST(1758252.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (122, 1, N'2012', 14, CAST(6023718.00 AS Decimal(18, 2)), 20, CAST(1853700.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (123, 1, N'2013', 14, CAST(6417719.00 AS Decimal(18, 2)), 20, CAST(2058857.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (124, 1, N'2014', 14, CAST(6075843.00 AS Decimal(18, 2)), 20, CAST(2401689.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (125, 1, N'2015', 14, CAST(5588528.00 AS Decimal(18, 2)), 20, CAST(2329475.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (126, 1, N'2016', 14, CAST(5678913.00 AS Decimal(18, 2)), 20, CAST(2651896.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (127, 1, N'2017', 14, CAST(6372911.00 AS Decimal(18, 2)), 20, CAST(3070758.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (128, 1, N'2018', 14, CAST(5492454.00 AS Decimal(18, 2)), 20, CAST(3346149.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (129, 1, N'2019', 14, CAST(4446670.00 AS Decimal(18, 2)), 20, CAST(3449492.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (130, 1, N'2020', 14, CAST(5039416.00 AS Decimal(18, 2)), 20, CAST(3474883.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (131, 1, N'2011', 15, CAST(6498651.00 AS Decimal(18, 2)), 27, CAST(2759311.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (132, 1, N'2012', 15, CAST(5843638.00 AS Decimal(18, 2)), 27, CAST(3679195.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (133, 1, N'2013', 15, CAST(6367791.00 AS Decimal(18, 2)), 27, CAST(3200362.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (134, 1, N'2014', 15, CAST(6898577.00 AS Decimal(18, 2)), 27, CAST(3297538.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (135, 1, N'2015', 15, CAST(5613570.00 AS Decimal(18, 2)), 27, CAST(3124968.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (136, 1, N'2016', 15, CAST(5757156.00 AS Decimal(18, 2)), 27, CAST(2733143.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (137, 1, N'2017', 15, CAST(6216639.00 AS Decimal(18, 2)), 27, CAST(2360734.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (138, 1, N'2018', 15, CAST(7534783.00 AS Decimal(18, 2)), 27, CAST(3053571.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (139, 1, N'2019', 15, CAST(6635225.00 AS Decimal(18, 2)), 27, CAST(3510629.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (140, 1, N'2020', 15, CAST(4830121.00 AS Decimal(18, 2)), 27, CAST(3136568.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (141, 1, N'2011', 16, CAST(4263730.00 AS Decimal(18, 2)), 2, CAST(2466316.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (142, 1, N'2012', 16, CAST(3601427.00 AS Decimal(18, 2)), 2, CAST(2833255.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (143, 1, N'2013', 16, CAST(3453190.00 AS Decimal(18, 2)), 2, CAST(3600865.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (144, 1, N'2014', 16, CAST(3199915.00 AS Decimal(18, 2)), 2, CAST(2861052.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (145, 1, N'2015', 16, CAST(3140057.00 AS Decimal(18, 2)), 2, CAST(2414790.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (146, 1, N'2016', 16, CAST(3943602.00 AS Decimal(18, 2)), 2, CAST(2329371.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (147, 1, N'2017', 16, CAST(4281472.00 AS Decimal(18, 2)), 2, CAST(2936262.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (148, 1, N'2018', 16, CAST(4124170.00 AS Decimal(18, 2)), 2, CAST(2912539.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (149, 1, N'2019', 16, CAST(3647888.00 AS Decimal(18, 2)), 2, CAST(2726571.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (150, 1, N'2020', 16, CAST(3742695.00 AS Decimal(18, 2)), 2, CAST(2866389.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (151, 1, N'2011', 17, CAST(3959279.00 AS Decimal(18, 2)), 12, CAST(3706654.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (152, 1, N'2012', 17, CAST(3690309.00 AS Decimal(18, 2)), 12, CAST(8174607.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (153, 1, N'2013', 17, CAST(3843376.00 AS Decimal(18, 2)), 12, CAST(4965630.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (154, 1, N'2014', 17, CAST(3863892.00 AS Decimal(18, 2)), 12, CAST(4655710.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (155, 1, N'2015', 17, CAST(3146940.00 AS Decimal(18, 2)), 12, CAST(4681278.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (156, 1, N'2016', 17, CAST(3200738.00 AS Decimal(18, 2)), 12, CAST(5406224.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (157, 1, N'2017', 17, CAST(3728941.00 AS Decimal(18, 2)), 12, CAST(9184157.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (158, 1, N'2018', 17, CAST(3571445.00 AS Decimal(18, 2)), 12, CAST(3137048.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (159, 1, N'2019', 17, CAST(3229469.00 AS Decimal(18, 2)), 12, CAST(3627165.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (160, 1, N'2020', 17, CAST(3716088.00 AS Decimal(18, 2)), 12, CAST(2828394.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (161, 1, N'2011', 18, CAST(4004955.00 AS Decimal(18, 2)), 24, CAST(1622777.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (162, 1, N'2012', 18, CAST(3660634.00 AS Decimal(18, 2)), 24, CAST(1684989.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (163, 1, N'2013', 18, CAST(3363585.00 AS Decimal(18, 2)), 24, CAST(1971247.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (164, 1, N'2014', 18, CAST(3517164.00 AS Decimal(18, 2)), 24, CAST(2040157.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (165, 1, N'2015', 18, CAST(2914731.00 AS Decimal(18, 2)), 24, CAST(1676112.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (166, 1, N'2016', 18, CAST(3000195.00 AS Decimal(18, 2)), 24, CAST(2384116.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (167, 1, N'2017', 18, CAST(3747619.00 AS Decimal(18, 2)), 24, CAST(2803182.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (168, 1, N'2018', 18, CAST(3304581.00 AS Decimal(18, 2)), 24, CAST(2669703.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (169, 1, N'2019', 18, CAST(3202977.00 AS Decimal(18, 2)), 24, CAST(2668830.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (170, 1, N'2020', 18, CAST(3628593.00 AS Decimal(18, 2)), 24, CAST(2634706.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (171, 1, N'2011', 19, CAST(2074354.00 AS Decimal(18, 2)), 28, CAST(2763476.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (172, 1, N'2012', 19, CAST(1770094.00 AS Decimal(18, 2)), 28, CAST(3676612.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (173, 1, N'2013', 19, CAST(1408806.00 AS Decimal(18, 2)), 28, CAST(3191482.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (174, 1, N'2014', 19, CAST(1728745.00 AS Decimal(18, 2)), 28, CAST(3047134.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (175, 1, N'2015', 19, CAST(1792241.00 AS Decimal(18, 2)), 28, CAST(3472634.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (176, 1, N'2016', 19, CAST(1787944.00 AS Decimal(18, 2)), 28, CAST(3174965.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (177, 1, N'2017', 19, CAST(2544928.00 AS Decimal(18, 2)), 28, CAST(2734522.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (178, 1, N'2018', 19, CAST(3257706.00 AS Decimal(18, 2)), 28, CAST(2636039.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (179, 1, N'2019', 19, CAST(2655109.00 AS Decimal(18, 2)), 28, CAST(3293057.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (180, 1, N'2020', 19, CAST(3228353.00 AS Decimal(18, 2)), 28, CAST(2507787.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (181, 1, N'2011', 20, CAST(3496189.00 AS Decimal(18, 2)), 37, CAST(3589635.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (182, 1, N'2012', 20, CAST(3058078.00 AS Decimal(18, 2)), 37, CAST(9921602.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (183, 1, N'2013', 20, CAST(3184533.00 AS Decimal(18, 2)), 37, CAST(4192511.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (184, 1, N'2014', 20, CAST(3082128.00 AS Decimal(18, 2)), 37, CAST(3886190.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (185, 1, N'2015', 20, CAST(2977656.00 AS Decimal(18, 2)), 37, CAST(3664043.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (186, 1, N'2016', 20, CAST(3244197.00 AS Decimal(18, 2)), 37, CAST(4968851.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (187, 1, N'2017', 20, CAST(3445906.00 AS Decimal(18, 2)), 37, CAST(3259270.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (188, 1, N'2018', 20, CAST(3101677.00 AS Decimal(18, 2)), 37, CAST(2392949.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (189, 1, N'2019', 20, CAST(2603243.00 AS Decimal(18, 2)), 37, CAST(2737560.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (190, 1, N'2020', 20, CAST(3005108.00 AS Decimal(18, 2)), 37, CAST(2253363.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (191, 1, N'2011', 21, CAST(3801297.00 AS Decimal(18, 2)), 23, CAST(1729760.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (192, 1, N'2012', 21, CAST(3236425.00 AS Decimal(18, 2)), 23, CAST(1829207.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (193, 1, N'2013', 21, CAST(3592568.00 AS Decimal(18, 2)), 23, CAST(2189245.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (194, 1, N'2014', 21, CAST(3363233.00 AS Decimal(18, 2)), 23, CAST(1729294.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (195, 1, N'2015', 21, CAST(2599758.00 AS Decimal(18, 2)), 23, CAST(1121346.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (196, 1, N'2016', 21, CAST(2195672.00 AS Decimal(18, 2)), 23, CAST(1254054.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (197, 1, N'2017', 21, CAST(2480196.00 AS Decimal(18, 2)), 23, CAST(1340709.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (198, 1, N'2018', 21, CAST(2447471.00 AS Decimal(18, 2)), 23, CAST(1466070.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (199, 1, N'2019', 21, CAST(2770909.00 AS Decimal(18, 2)), 23, CAST(2156876.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (200, 1, N'2020', 21, CAST(2769255.00 AS Decimal(18, 2)), 23, CAST(2090410.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (201, 1, N'2011', 22, CAST(1755452.00 AS Decimal(18, 2)), 57, CAST(2063996.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (202, 1, N'2012', 22, CAST(2005342.00 AS Decimal(18, 2)), 57, CAST(2584671.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (203, 1, N'2013', 22, CAST(2627288.00 AS Decimal(18, 2)), 57, CAST(2960371.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (204, 1, N'2014', 22, CAST(2420199.00 AS Decimal(18, 2)), 57, CAST(2874608.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (205, 1, N'2015', 22, CAST(2218335.00 AS Decimal(18, 2)), 57, CAST(1898543.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (206, 1, N'2016', 22, CAST(2561650.00 AS Decimal(18, 2)), 57, CAST(1285840.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (207, 1, N'2017', 22, CAST(2828107.00 AS Decimal(18, 2)), 57, CAST(1356999.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (208, 1, N'2018', 22, CAST(2650330.00 AS Decimal(18, 2)), 57, CAST(1474368.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (209, 1, N'2019', 22, CAST(2338360.00 AS Decimal(18, 2)), 57, CAST(1788708.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (210, 1, N'2020', 22, CAST(2746268.00 AS Decimal(18, 2)), 57, CAST(2085574.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (211, 1, N'2011', 23, CAST(4812060.00 AS Decimal(18, 2)), 51, CAST(920896.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (212, 1, N'2012', 23, CAST(4394200.00 AS Decimal(18, 2)), 51, CAST(1014906.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (213, 1, N'2013', 23, CAST(4516333.00 AS Decimal(18, 2)), 51, CAST(1192900.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (214, 1, N'2014', 23, CAST(4242612.00 AS Decimal(18, 2)), 51, CAST(1406566.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (215, 1, N'2015', 23, CAST(3448171.00 AS Decimal(18, 2)), 51, CAST(1337555.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (216, 1, N'2016', 23, CAST(2547401.00 AS Decimal(18, 2)), 51, CAST(1469782.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (217, 1, N'2017', 23, CAST(2817133.00 AS Decimal(18, 2)), 51, CAST(1657718.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (218, 1, N'2018', 23, CAST(2645555.00 AS Decimal(18, 2)), 51, CAST(1989587.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (219, 1, N'2019', 23, CAST(2725463.00 AS Decimal(18, 2)), 51, CAST(2346785.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (220, 1, N'2020', 23, CAST(2590375.00 AS Decimal(18, 2)), 51, CAST(2057266.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (221, 1, N'2011', 24, CAST(2474621.00 AS Decimal(18, 2)), 35, CAST(1553312.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (222, 1, N'2012', 24, CAST(2753650.00 AS Decimal(18, 2)), 35, CAST(1401401.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (223, 1, N'2013', 24, CAST(2760303.00 AS Decimal(18, 2)), 35, CAST(1439061.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (224, 1, N'2014', 24, CAST(2846185.00 AS Decimal(18, 2)), 35, CAST(1536658.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (225, 1, N'2015', 24, CAST(2254150.00 AS Decimal(18, 2)), 35, CAST(1400519.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (226, 1, N'2016', 24, CAST(2139942.00 AS Decimal(18, 2)), 35, CAST(1428312.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (227, 1, N'2017', 24, CAST(2773127.00 AS Decimal(18, 2)), 35, CAST(1662638.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (228, 1, N'2018', 24, CAST(2501393.00 AS Decimal(18, 2)), 35, CAST(2086696.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (229, 1, N'2019', 24, CAST(2384901.00 AS Decimal(18, 2)), 35, CAST(2245574.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (230, 1, N'2020', 24, CAST(2124160.00 AS Decimal(18, 2)), 35, CAST(1799864.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (231, 1, N'2011', 25, CAST(1567503.00 AS Decimal(18, 2)), 29, CAST(747629.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (232, 1, N'2012', 25, CAST(1278247.00 AS Decimal(18, 2)), 29, CAST(2139440.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (233, 1, N'2013', 25, CAST(1230783.00 AS Decimal(18, 2)), 29, CAST(2753096.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (234, 1, N'2014', 25, CAST(1160993.00 AS Decimal(18, 2)), 29, CAST(2059898.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (235, 1, N'2015', 25, CAST(1339168.00 AS Decimal(18, 2)), 29, CAST(1420062.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (236, 1, N'2016', 25, CAST(1996907.00 AS Decimal(18, 2)), 29, CAST(906392.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (237, 1, N'2017', 25, CAST(3138558.00 AS Decimal(18, 2)), 29, CAST(880729.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (238, 1, N'2018', 25, CAST(2132979.00 AS Decimal(18, 2)), 29, CAST(1498326.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (239, 1, N'2019', 25, CAST(1847831.00 AS Decimal(18, 2)), 29, CAST(2069669.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (240, 1, N'2020', 25, CAST(1990602.00 AS Decimal(18, 2)), 29, CAST(1653078.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (241, 10, N'2011', 3, CAST(121591317.00 AS Decimal(18, 2)), 3, CAST(97949179.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (242, 10, N'2012', 3, CAST(115584149.00 AS Decimal(18, 2)), 3, CAST(92316938.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (243, 10, N'2013', 3, CAST(115130911.00 AS Decimal(18, 2)), 3, CAST(93524554.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (244, 10, N'2014', 3, CAST(114120643.00 AS Decimal(18, 2)), 3, CAST(94443337.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (245, 10, N'2015', 3, CAST(96531621.00 AS Decimal(18, 2)), 3, CAST(79386095.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (246, 10, N'2016', 3, CAST(95005151.00 AS Decimal(18, 2)), 3, CAST(79188352.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (247, 10, N'2017', 3, CAST(97246356.00 AS Decimal(18, 2)), 3, CAST(77747949.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (248, 10, N'2018', 3, CAST(102372677.00 AS Decimal(18, 2)), 3, CAST(83301819.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (249, 10, N'2019', 3, CAST(94996855.00 AS Decimal(18, 2)), 3, CAST(78101213.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (250, 10, N'2020', 3, CAST(81269675.00 AS Decimal(18, 2)), 3, CAST(68978511.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (251, 10, N'2011', 2, CAST(57431106.00 AS Decimal(18, 2)), 6, CAST(32552098.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (252, 10, N'2012', 2, CAST(53458273.00 AS Decimal(18, 2)), 6, CAST(34123265.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (253, 10, N'2013', 2, CAST(54221963.00 AS Decimal(18, 2)), 6, CAST(35765163.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (254, 10, N'2014', 2, CAST(57201982.00 AS Decimal(18, 2)), 6, CAST(36433613.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (255, 10, N'2015', 2, CAST(52590552.00 AS Decimal(18, 2)), 6, CAST(36216096.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (256, 10, N'2016', 2, CAST(51818493.00 AS Decimal(18, 2)), 6, CAST(36146163.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (257, 10, N'2017', 2, CAST(56213110.00 AS Decimal(18, 2)), 6, CAST(38374905.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (258, 10, N'2018', 2, CAST(59446115.00 AS Decimal(18, 2)), 6, CAST(45310826.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (259, 10, N'2019', 2, CAST(58794206.00 AS Decimal(18, 2)), 6, CAST(47097319.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (260, 10, N'2020', 2, CAST(64393022.00 AS Decimal(18, 2)), 6, CAST(37052646.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (261, 10, N'2011', 7, CAST(52326917.00 AS Decimal(18, 2)), 7, CAST(47588853.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (262, 10, N'2012', 7, CAST(48221380.00 AS Decimal(18, 2)), 7, CAST(41250069.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (263, 10, N'2013', 7, CAST(48163194.00 AS Decimal(18, 2)), 7, CAST(40407822.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (264, 10, N'2014', 7, CAST(48991386.00 AS Decimal(18, 2)), 7, CAST(41257372.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (265, 10, N'2015', 7, CAST(42090661.00 AS Decimal(18, 2)), 7, CAST(35516779.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (266, 10, N'2016', 7, CAST(42703028.00 AS Decimal(18, 2)), 7, CAST(35833736.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (267, 10, N'2017', 7, CAST(47559812.00 AS Decimal(18, 2)), 7, CAST(39799293.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (268, 10, N'2018', 7, CAST(50595678.00 AS Decimal(18, 2)), 7, CAST(42815184.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (269, 10, N'2019', 7, CAST(48442500.00 AS Decimal(18, 2)), 7, CAST(42021645.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (270, 10, N'2020', 7, CAST(44451842.00 AS Decimal(18, 2)), 7, CAST(36751059.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (271, 10, N'2011', 14, CAST(42533044.00 AS Decimal(18, 2)), 14, CAST(42562638.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (272, 10, N'2012', 14, CAST(40059524.00 AS Decimal(18, 2)), 14, CAST(37799117.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (273, 10, N'2013', 14, CAST(40939305.00 AS Decimal(18, 2)), 14, CAST(38591336.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (274, 10, N'2014', 14, CAST(39600474.00 AS Decimal(18, 2)), 14, CAST(40566956.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (275, 10, N'2015', 14, CAST(35370532.00 AS Decimal(18, 2)), 14, CAST(36200183.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (276, 10, N'2016', 14, CAST(36143631.00 AS Decimal(18, 2)), 14, CAST(36811476.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (277, 10, N'2017', 14, CAST(39728689.00 AS Decimal(18, 2)), 14, CAST(40251360.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (278, 10, N'2018', 14, CAST(42952652.00 AS Decimal(18, 2)), 14, CAST(44403922.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (279, 10, N'2019', 14, CAST(41409156.00 AS Decimal(18, 2)), 14, CAST(41635344.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (280, 10, N'2020', 14, CAST(40215995.00 AS Decimal(18, 2)), 14, CAST(35115280.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (281, 10, N'2011', 17, CAST(54720317.00 AS Decimal(18, 2)), 17, CAST(42242899.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (282, 10, N'2012', 17, CAST(50348751.00 AS Decimal(18, 2)), 17, CAST(40969186.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (283, 10, N'2013', 17, CAST(52709193.00 AS Decimal(18, 2)), 17, CAST(43628179.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (284, 10, N'2014', 17, CAST(53489164.00 AS Decimal(18, 2)), 17, CAST(41499711.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (285, 10, N'2015', 17, CAST(40962387.00 AS Decimal(18, 2)), 17, CAST(33707033.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (286, 10, N'2016', 17, CAST(38152966.00 AS Decimal(18, 2)), 17, CAST(33302896.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (287, 10, N'2017', 17, CAST(41398308.00 AS Decimal(18, 2)), 17, CAST(36539009.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (288, 10, N'2018', 17, CAST(46457776.00 AS Decimal(18, 2)), 17, CAST(40384520.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (289, 10, N'2019', 17, CAST(42598574.00 AS Decimal(18, 2)), 17, CAST(38285966.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (290, 10, N'2020', 17, CAST(36934736.00 AS Decimal(18, 2)), 17, CAST(35103785.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (291, 10, N'2011', 6, CAST(40857268.00 AS Decimal(18, 2)), 13, CAST(38841447.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (292, 10, N'2012', 6, CAST(42557358.00 AS Decimal(18, 2)), 13, CAST(37689540.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (293, 10, N'2013', 6, CAST(43526006.00 AS Decimal(18, 2)), 13, CAST(39093103.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (294, 10, N'2014', 6, CAST(42124750.00 AS Decimal(18, 2)), 13, CAST(40916518.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (295, 10, N'2015', 6, CAST(38816051.00 AS Decimal(18, 2)), 13, CAST(35388844.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (296, 10, N'2016', 6, CAST(40060951.00 AS Decimal(18, 2)), 13, CAST(35005567.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (297, 10, N'2017', 6, CAST(39906433.00 AS Decimal(18, 2)), 13, CAST(35368023.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (298, 10, N'2018', 6, CAST(41588406.00 AS Decimal(18, 2)), 13, CAST(38719974.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (299, 10, N'2019', 6, CAST(42745580.00 AS Decimal(18, 2)), 13, CAST(37679993.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (300, 10, N'2020', 6, CAST(35356128.00 AS Decimal(18, 2)), 13, CAST(30765602.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (301, 10, N'2011', 18, CAST(30965845.00 AS Decimal(18, 2)), 2, CAST(18745449.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (302, 10, N'2012', 18, CAST(29457230.00 AS Decimal(18, 2)), 2, CAST(19383272.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (303, 10, N'2013', 18, CAST(29257928.00 AS Decimal(18, 2)), 2, CAST(19572699.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (304, 10, N'2014', 18, CAST(28877576.00 AS Decimal(18, 2)), 2, CAST(21493750.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (305, 10, N'2015', 18, CAST(23648842.00 AS Decimal(18, 2)), 2, CAST(19920508.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (306, 10, N'2016', 18, CAST(25234744.00 AS Decimal(18, 2)), 2, CAST(17705981.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (307, 10, N'2017', 18, CAST(28228114.00 AS Decimal(18, 2)), 2, CAST(21280066.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (308, 10, N'2018', 18, CAST(29766241.00 AS Decimal(18, 2)), 2, CAST(24628774.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (309, 10, N'2019', 18, CAST(28277259.00 AS Decimal(18, 2)), 2, CAST(23436619.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (310, 10, N'2020', 18, CAST(25821306.00 AS Decimal(18, 2)), 2, CAST(19989577.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (311, 10, N'2011', 13, CAST(30648576.00 AS Decimal(18, 2)), 18, CAST(25069547.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (312, 10, N'2012', 13, CAST(29268649.00 AS Decimal(18, 2)), 18, CAST(23688786.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (313, 10, N'2013', 13, CAST(27602391.00 AS Decimal(18, 2)), 18, CAST(23388044.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (314, 10, N'2014', 13, CAST(27717952.00 AS Decimal(18, 2)), 18, CAST(23316755.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (315, 10, N'2015', 13, CAST(23042846.00 AS Decimal(18, 2)), 18, CAST(19374350.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (316, 10, N'2016', 13, CAST(22801866.00 AS Decimal(18, 2)), 18, CAST(17776436.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (317, 10, N'2017', 13, CAST(24575663.00 AS Decimal(18, 2)), 18, CAST(19200091.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (318, 10, N'2018', 13, CAST(24317684.00 AS Decimal(18, 2)), 18, CAST(20902838.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (319, 10, N'2019', 13, CAST(23676744.00 AS Decimal(18, 2)), 18, CAST(19619007.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (320, 10, N'2020', 13, CAST(19422196.00 AS Decimal(18, 2)), 18, CAST(18160769.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (321, 10, N'2011', 9, CAST(16433322.00 AS Decimal(18, 2)), 9, CAST(18377824.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (322, 10, N'2012', 9, CAST(15633804.00 AS Decimal(18, 2)), 9, CAST(17636549.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (323, 10, N'2013', 9, CAST(16986011.00 AS Decimal(18, 2)), 9, CAST(17360709.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (324, 10, N'2014', 9, CAST(17067210.00 AS Decimal(18, 2)), 9, CAST(17226818.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (325, 10, N'2015', 9, CAST(15985304.00 AS Decimal(18, 2)), 9, CAST(15347042.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (326, 10, N'2016', 9, CAST(15676584.00 AS Decimal(18, 2)), 9, CAST(16925573.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (327, 10, N'2017', 9, CAST(16678645.00 AS Decimal(18, 2)), 9, CAST(17752656.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (328, 10, N'2018', 9, CAST(17624953.00 AS Decimal(18, 2)), 9, CAST(18911803.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (329, 10, N'2019', 9, CAST(16449438.00 AS Decimal(18, 2)), 9, CAST(19912046.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (330, 10, N'2020', 9, CAST(14870024.00 AS Decimal(18, 2)), 9, CAST(16415523.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (331, 10, N'2011', 20, CAST(10807093.00 AS Decimal(18, 2)), 20, CAST(9272387.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (332, 10, N'2012', 20, CAST(10226744.00 AS Decimal(18, 2)), 20, CAST(8526181.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (333, 10, N'2013', 20, CAST(10719491.00 AS Decimal(18, 2)), 20, CAST(8944819.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (334, 10, N'2014', 20, CAST(11225614.00 AS Decimal(18, 2)), 20, CAST(9490325.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (335, 10, N'2015', 20, CAST(10001777.00 AS Decimal(18, 2)), 20, CAST(8629265.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (336, 10, N'2016', 20, CAST(10125473.00 AS Decimal(18, 2)), 20, CAST(9101508.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (337, 10, N'2017', 20, CAST(11506266.00 AS Decimal(18, 2)), 20, CAST(10316002.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (338, 10, N'2018', 20, CAST(12766314.00 AS Decimal(18, 2)), 20, CAST(11712208.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (339, 10, N'2019', 20, CAST(13143527.00 AS Decimal(18, 2)), 20, CAST(11410790.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (340, 10, N'2020', 20, CAST(12850745.00 AS Decimal(18, 2)), 20, CAST(10544888.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (341, 10, N'2011', 16, CAST(13276347.00 AS Decimal(18, 2)), 65, CAST(7169473.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (342, 10, N'2012', 16, CAST(11861579.00 AS Decimal(18, 2)), 65, CAST(7538100.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (343, 10, N'2013', 16, CAST(10936019.00 AS Decimal(18, 2)), 65, CAST(7202281.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (344, 10, N'2014', 16, CAST(10441183.00 AS Decimal(18, 2)), 65, CAST(6693249.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (345, 10, N'2015', 16, CAST(9360440.00 AS Decimal(18, 2)), 65, CAST(5933692.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (346, 10, N'2016', 16, CAST(10355221.00 AS Decimal(18, 2)), 65, CAST(6800814.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (347, 10, N'2017', 16, CAST(11184181.00 AS Decimal(18, 2)), 65, CAST(7642444.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (348, 10, N'2018', 16, CAST(11865204.00 AS Decimal(18, 2)), 65, CAST(9717343.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (349, 10, N'2019', 16, CAST(11514265.00 AS Decimal(18, 2)), 65, CAST(9720219.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (350, 10, N'2020', 16, CAST(9602316.00 AS Decimal(18, 2)), 65, CAST(8012185.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (351, 10, N'2011', 5, CAST(2465078.00 AS Decimal(18, 2)), 1, CAST(9335394.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (352, 10, N'2012', 5, CAST(4247267.00 AS Decimal(18, 2)), 1, CAST(8874382.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (353, 10, N'2013', 5, CAST(5670946.00 AS Decimal(18, 2)), 1, CAST(8319703.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (354, 10, N'2014', 5, CAST(6320508.00 AS Decimal(18, 2)), 1, CAST(7961495.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (355, 10, N'2015', 5, CAST(5263973.00 AS Decimal(18, 2)), 1, CAST(7870934.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (356, 10, N'2016', 5, CAST(5680927.00 AS Decimal(18, 2)), 1, CAST(7750643.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (357, 10, N'2017', 5, CAST(6891370.00 AS Decimal(18, 2)), 1, CAST(7565786.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (358, 10, N'2018', 5, CAST(9671250.00 AS Decimal(18, 2)), 1, CAST(7074817.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (359, 10, N'2019', 5, CAST(11974662.00 AS Decimal(18, 2)), 1, CAST(6655199.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (360, 10, N'2020', 5, CAST(9553847.00 AS Decimal(18, 2)), 1, CAST(7182310.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (361, 10, N'2011', 1, CAST(8252606.00 AS Decimal(18, 2)), 16, CAST(9080339.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (362, 10, N'2012', 1, CAST(7322897.00 AS Decimal(18, 2)), 16, CAST(9506511.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (363, 10, N'2013', 1, CAST(7977000.00 AS Decimal(18, 2)), 16, CAST(9026263.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (364, 10, N'2014', 1, CAST(8245165.00 AS Decimal(18, 2)), 16, CAST(9062450.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (365, 10, N'2015', 1, CAST(7422732.00 AS Decimal(18, 2)), 16, CAST(6978159.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (366, 10, N'2016', 1, CAST(7812689.00 AS Decimal(18, 2)), 16, CAST(6915391.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (367, 10, N'2017', 1, CAST(8469847.00 AS Decimal(18, 2)), 16, CAST(7180603.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (368, 10, N'2018', 1, CAST(9468454.00 AS Decimal(18, 2)), 16, CAST(7817192.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (369, 10, N'2019', 1, CAST(9776916.00 AS Decimal(18, 2)), 16, CAST(8642603.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (370, 10, N'2020', 1, CAST(8885908.00 AS Decimal(18, 2)), 16, CAST(6414911.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (371, 10, N'2011', 46, CAST(8973177.00 AS Decimal(18, 2)), 4, CAST(10375465.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (372, 10, N'2012', 46, CAST(8948090.00 AS Decimal(18, 2)), 4, CAST(11722313.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (373, 10, N'2013', 46, CAST(8788703.00 AS Decimal(18, 2)), 4, CAST(10199853.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (374, 10, N'2014', 46, CAST(8059308.00 AS Decimal(18, 2)), 4, CAST(8973214.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (375, 10, N'2015', 46, CAST(7026328.00 AS Decimal(18, 2)), 4, CAST(5005046.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (376, 10, N'2016', 46, CAST(7393879.00 AS Decimal(18, 2)), 4, CAST(5405632.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (377, 10, N'2017', 46, CAST(7578521.00 AS Decimal(18, 2)), 4, CAST(6278617.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (378, 10, N'2018', 46, CAST(7812178.00 AS Decimal(18, 2)), 4, CAST(6281413.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (379, 10, N'2019', 46, CAST(8493644.00 AS Decimal(18, 2)), 4, CAST(6280178.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (380, 10, N'2020', 46, CAST(8535344.00 AS Decimal(18, 2)), 4, CAST(5883671.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (381, 10, N'2011', 22, CAST(8211722.00 AS Decimal(18, 2)), 70, CAST(6125736.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (382, 10, N'2012', 22, CAST(7181258.00 AS Decimal(18, 2)), 70, CAST(7677575.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (383, 10, N'2013', 22, CAST(7435682.00 AS Decimal(18, 2)), 70, CAST(6391469.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (384, 10, N'2014', 22, CAST(8008072.00 AS Decimal(18, 2)), 70, CAST(5852326.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (385, 10, N'2015', 22, CAST(6966080.00 AS Decimal(18, 2)), 70, CAST(5051662.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (386, 10, N'2016', 22, CAST(7240536.00 AS Decimal(18, 2)), 70, CAST(5991359.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (387, 10, N'2017', 22, CAST(7958882.00 AS Decimal(18, 2)), 70, CAST(7073939.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (388, 10, N'2018', 22, CAST(8976933.00 AS Decimal(18, 2)), 70, CAST(7340135.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (389, 10, N'2019', 22, CAST(8918822.00 AS Decimal(18, 2)), 70, CAST(6478065.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (390, 10, N'2020', 22, CAST(7603250.00 AS Decimal(18, 2)), 70, CAST(5873121.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (391, 10, N'2011', 45, CAST(6715702.00 AS Decimal(18, 2)), 26, CAST(7838371.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (392, 10, N'2012', 45, CAST(6239902.00 AS Decimal(18, 2)), 26, CAST(6533884.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (393, 10, N'2013', 45, CAST(6750281.00 AS Decimal(18, 2)), 26, CAST(6182776.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (394, 10, N'2014', 45, CAST(6808308.00 AS Decimal(18, 2)), 26, CAST(6621008.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (395, 10, N'2015', 45, CAST(6106380.00 AS Decimal(18, 2)), 26, CAST(5787496.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (396, 10, N'2016', 45, CAST(6262841.00 AS Decimal(18, 2)), 26, CAST(5617957.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (397, 10, N'2017', 45, CAST(6812984.00 AS Decimal(18, 2)), 26, CAST(5666479.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (398, 10, N'2018', 45, CAST(7950812.00 AS Decimal(18, 2)), 26, CAST(6036185.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (399, 10, N'2019', 45, CAST(7788773.00 AS Decimal(18, 2)), 26, CAST(6034326.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (400, 10, N'2020', 45, CAST(7082734.00 AS Decimal(18, 2)), 26, CAST(5842851.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (401, 10, N'2011', 26, CAST(8341160.00 AS Decimal(18, 2)), 11, CAST(5834808.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (402, 10, N'2012', 26, CAST(7524696.00 AS Decimal(18, 2)), 11, CAST(4729448.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (403, 10, N'2013', 26, CAST(7781434.00 AS Decimal(18, 2)), 11, CAST(5632540.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (404, 10, N'2014', 26, CAST(7670610.00 AS Decimal(18, 2)), 11, CAST(6589394.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (405, 10, N'2015', 26, CAST(6175138.00 AS Decimal(18, 2)), 11, CAST(5345008.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (406, 10, N'2016', 26, CAST(6007905.00 AS Decimal(18, 2)), 11, CAST(4291254.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (407, 10, N'2017', 26, CAST(6658361.00 AS Decimal(18, 2)), 11, CAST(5672479.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (408, 10, N'2018', 26, CAST(7641017.00 AS Decimal(18, 2)), 11, CAST(5120598.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (409, 10, N'2019', 26, CAST(7030892.00 AS Decimal(18, 2)), 11, CAST(5814773.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (410, 10, N'2020', 26, CAST(6553785.00 AS Decimal(18, 2)), 11, CAST(5469678.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (411, 10, N'2011', 4, CAST(19387250.00 AS Decimal(18, 2)), 45, CAST(5524877.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (412, 10, N'2012', 4, CAST(15367533.00 AS Decimal(18, 2)), 45, CAST(4646112.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (413, 10, N'2013', 4, CAST(14051154.00 AS Decimal(18, 2)), 45, CAST(5339372.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (414, 10, N'2014', 4, CAST(13573509.00 AS Decimal(18, 2)), 45, CAST(5463630.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (415, 10, N'2015', 4, CAST(7012009.00 AS Decimal(18, 2)), 45, CAST(4750826.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (416, 10, N'2016', 4, CAST(6132384.00 AS Decimal(18, 2)), 45, CAST(5080420.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (417, 10, N'2017', 4, CAST(8685370.00 AS Decimal(18, 2)), 45, CAST(5447502.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (418, 10, N'2018', 4, CAST(11819761.00 AS Decimal(18, 2)), 45, CAST(6280257.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (419, 10, N'2019', 4, CAST(9654672.00 AS Decimal(18, 2)), 45, CAST(7995056.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (420, 10, N'2020', 4, CAST(6517365.00 AS Decimal(18, 2)), 45, CAST(5426443.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (421, 10, N'2011', 32, CAST(6568764.00 AS Decimal(18, 2)), 15, CAST(3862716.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (422, 10, N'2012', 32, CAST(6724905.00 AS Decimal(18, 2)), 15, CAST(4188635.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (423, 10, N'2013', 32, CAST(7190090.00 AS Decimal(18, 2)), 15, CAST(3602607.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (424, 10, N'2014', 32, CAST(7798454.00 AS Decimal(18, 2)), 15, CAST(3593222.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (425, 10, N'2015', 32, CAST(6100353.00 AS Decimal(18, 2)), 15, CAST(3524893.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (426, 10, N'2016', 32, CAST(5323621.00 AS Decimal(18, 2)), 15, CAST(4327032.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (427, 10, N'2017', 32, CAST(7517046.00 AS Decimal(18, 2)), 15, CAST(6037746.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (428, 10, N'2018', 32, CAST(7037006.00 AS Decimal(18, 2)), 15, CAST(6533018.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (429, 10, N'2019', 32, CAST(6763453.00 AS Decimal(18, 2)), 15, CAST(5999309.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (430, 10, N'2020', 32, CAST(6151523.00 AS Decimal(18, 2)), 15, CAST(4834039.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (431, 10, N'2011', 34, CAST(2731114.00 AS Decimal(18, 2)), 53, CAST(8023029.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (432, 10, N'2012', 34, CAST(3478767.00 AS Decimal(18, 2)), 53, CAST(8161644.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (433, 10, N'2013', 34, CAST(3732424.00 AS Decimal(18, 2)), 53, CAST(7843394.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (434, 10, N'2014', 34, CAST(4083276.00 AS Decimal(18, 2)), 53, CAST(8180966.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (435, 10, N'2015', 34, CAST(4531027.00 AS Decimal(18, 2)), 53, CAST(6895350.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (436, 10, N'2016', 34, CAST(5001752.00 AS Decimal(18, 2)), 53, CAST(5620623.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (437, 10, N'2017', 34, CAST(5831354.00 AS Decimal(18, 2)), 53, CAST(5631398.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (438, 10, N'2018', 34, CAST(6419397.00 AS Decimal(18, 2)), 53, CAST(6227324.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (439, 10, N'2019', 34, CAST(6298245.00 AS Decimal(18, 2)), 53, CAST(5513759.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (440, 10, N'2020', 34, CAST(6135833.00 AS Decimal(18, 2)), 53, CAST(4800903.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (441, 10, N'2011', 51, CAST(4382952.00 AS Decimal(18, 2)), 22, CAST(4613043.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (442, 10, N'2012', 51, CAST(4209395.00 AS Decimal(18, 2)), 22, CAST(4158693.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (443, 10, N'2013', 51, CAST(4416214.00 AS Decimal(18, 2)), 22, CAST(4513474.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (444, 10, N'2014', 51, CAST(4818006.00 AS Decimal(18, 2)), 22, CAST(4733313.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (445, 10, N'2015', 51, CAST(4534478.00 AS Decimal(18, 2)), 22, CAST(4137801.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (446, 10, N'2016', 51, CAST(4712813.00 AS Decimal(18, 2)), 22, CAST(4440795.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (447, 10, N'2017', 51, CAST(5644466.00 AS Decimal(18, 2)), 22, CAST(5157888.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (448, 10, N'2018', 51, CAST(6271782.00 AS Decimal(18, 2)), 22, CAST(5731274.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (449, 10, N'2019', 51, CAST(6250598.00 AS Decimal(18, 2)), 22, CAST(5273640.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (450, 10, N'2020', 51, CAST(5721836.00 AS Decimal(18, 2)), 22, CAST(4794932.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (451, 10, N'2011', 43, CAST(4325937.00 AS Decimal(18, 2)), 51, CAST(6005564.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (452, 10, N'2012', 43, CAST(4000962.00 AS Decimal(18, 2)), 51, CAST(5179012.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (453, 10, N'2013', 43, CAST(3933939.00 AS Decimal(18, 2)), 51, CAST(5120289.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (454, 10, N'2014', 43, CAST(4101713.00 AS Decimal(18, 2)), 51, CAST(5019874.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (455, 10, N'2015', 43, CAST(3879916.00 AS Decimal(18, 2)), 51, CAST(4174360.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (456, 10, N'2016', 43, CAST(4485934.00 AS Decimal(18, 2)), 51, CAST(4727575.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (457, 10, N'2017', 43, CAST(4987602.00 AS Decimal(18, 2)), 51, CAST(4750331.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (458, 10, N'2018', 43, CAST(5623358.00 AS Decimal(18, 2)), 51, CAST(5186797.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (459, 10, N'2019', 43, CAST(5746967.00 AS Decimal(18, 2)), 51, CAST(5336379.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (460, 10, N'2020', 43, CAST(5678585.00 AS Decimal(18, 2)), 51, CAST(4685030.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (461, 10, N'2011', 15, CAST(6624751.00 AS Decimal(18, 2)), 21, CAST(4048316.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (462, 10, N'2012', 15, CAST(6028307.00 AS Decimal(18, 2)), 21, CAST(3908851.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (463, 10, N'2013', 15, CAST(5858774.00 AS Decimal(18, 2)), 21, CAST(4444368.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (464, 10, N'2014', 15, CAST(6940207.00 AS Decimal(18, 2)), 21, CAST(4573566.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (465, 10, N'2015', 15, CAST(5963743.00 AS Decimal(18, 2)), 21, CAST(3767940.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (466, 10, N'2016', 15, CAST(5175617.00 AS Decimal(18, 2)), 21, CAST(4023344.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (467, 10, N'2017', 15, CAST(6056908.00 AS Decimal(18, 2)), 21, CAST(4447820.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (468, 10, N'2018', 15, CAST(7098385.00 AS Decimal(18, 2)), 21, CAST(4947698.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (469, 10, N'2019', 15, CAST(6984635.00 AS Decimal(18, 2)), 21, CAST(4745447.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (470, 10, N'2020', 15, CAST(5488960.00 AS Decimal(18, 2)), 21, CAST(4267923.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (471, 10, N'2011', 10, CAST(8223974.00 AS Decimal(18, 2)), 31, CAST(3993083.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (472, 10, N'2012', 10, CAST(6358068.00 AS Decimal(18, 2)), 31, CAST(3599439.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (473, 10, N'2013', 10, CAST(6374186.00 AS Decimal(18, 2)), 31, CAST(3815727.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (474, 10, N'2014', 10, CAST(6549220.00 AS Decimal(18, 2)), 31, CAST(4359471.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (475, 10, N'2015', 10, CAST(5253184.00 AS Decimal(18, 2)), 31, CAST(3953478.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (476, 10, N'2016', 10, CAST(5191819.00 AS Decimal(18, 2)), 31, CAST(3517108.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (477, 10, N'2017', 10, CAST(5481378.00 AS Decimal(18, 2)), 31, CAST(3852214.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (478, 10, N'2018', 10, CAST(5630997.00 AS Decimal(18, 2)), 31, CAST(4158041.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (479, 10, N'2019', 10, CAST(5695568.00 AS Decimal(18, 2)), 31, CAST(4166343.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (480, 10, N'2020', 10, CAST(5276429.00 AS Decimal(18, 2)), 31, CAST(4215833.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (481, 3, N'2011', 2, CAST(112601120.00 AS Decimal(18, 2)), 6, CAST(103181346.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (482, 3, N'2012', 2, CAST(102393093.00 AS Decimal(18, 2)), 6, CAST(112269321.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (483, 3, N'2013', 2, CAST(100312728.00 AS Decimal(18, 2)), 6, CAST(119125993.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (484, 3, N'2014', 2, CAST(107580164.00 AS Decimal(18, 2)), 6, CAST(127776387.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (485, 3, N'2015', 2, CAST(101946561.00 AS Decimal(18, 2)), 6, CAST(126090209.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (486, 3, N'2016', 2, CAST(104014508.00 AS Decimal(18, 2)), 6, CAST(118236226.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (487, 3, N'2017', 2, CAST(115183864.00 AS Decimal(18, 2)), 6, CAST(126254167.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (488, 3, N'2018', 2, CAST(125101066.00 AS Decimal(18, 2)), 6, CAST(133896931.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (489, 3, N'2019', 2, CAST(123165529.00 AS Decimal(18, 2)), 6, CAST(132857659.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (490, 3, N'2020', 2, CAST(133146139.00 AS Decimal(18, 2)), 6, CAST(118782057.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (491, 3, N'2011', 18, CAST(102777849.00 AS Decimal(18, 2)), 2, CAST(90642574.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (492, 3, N'2012', 18, CAST(99542585.00 AS Decimal(18, 2)), 2, CAST(86102711.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (493, 3, N'2013', 18, CAST(106236197.00 AS Decimal(18, 2)), 2, CAST(89316350.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (494, 3, N'2014', 18, CAST(107890328.00 AS Decimal(18, 2)), 2, CAST(99201360.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (495, 3, N'2015', 18, CAST(88068305.00 AS Decimal(18, 2)), 2, CAST(79028920.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (496, 3, N'2016', 18, CAST(86331047.00 AS Decimal(18, 2)), 2, CAST(84115719.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (497, 3, N'2017', 18, CAST(94549488.00 AS Decimal(18, 2)), 2, CAST(97505540.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (498, 3, N'2018', 18, CAST(104529826.00 AS Decimal(18, 2)), 2, CAST(109780291.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (499, 3, N'2019', 18, CAST(97396130.00 AS Decimal(18, 2)), 2, CAST(107451431.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (500, 3, N'2020', 18, CAST(89830635.00 AS Decimal(18, 2)), 2, CAST(109771551.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (501, 3, N'2011', 6, CAST(69261437.00 AS Decimal(18, 2)), 10, CAST(140516046.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (502, 3, N'2012', 6, CAST(67205165.00 AS Decimal(18, 2)), 10, CAST(131164664.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (503, 3, N'2013', 6, CAST(66571065.00 AS Decimal(18, 2)), 10, CAST(131619532.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (504, 3, N'2014', 6, CAST(67526624.00 AS Decimal(18, 2)), 10, CAST(133479253.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (505, 3, N'2015', 6, CAST(66428354.00 AS Decimal(18, 2)), 10, CAST(113907395.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (506, 3, N'2016', 6, CAST(64142420.00 AS Decimal(18, 2)), 10, CAST(111782214.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (507, 3, N'2017', 6, CAST(69868049.00 AS Decimal(18, 2)), 10, CAST(119164849.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (508, 3, N'2018', 6, CAST(76179360.00 AS Decimal(18, 2)), 10, CAST(124447383.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (509, 3, N'2019', 6, CAST(79839832.00 AS Decimal(18, 2)), 10, CAST(119212781.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (510, 3, N'2020', 6, CAST(77338883.00 AS Decimal(18, 2)), 10, CAST(103731101.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (511, 3, N'2011', 20, CAST(44940677.00 AS Decimal(18, 2)), 18, CAST(93448453.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (512, 3, N'2012', 20, CAST(42449937.00 AS Decimal(18, 2)), 18, CAST(87342585.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (513, 3, N'2013', 20, CAST(47804573.00 AS Decimal(18, 2)), 18, CAST(90491653.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (514, 3, N'2014', 20, CAST(52677854.00 AS Decimal(18, 2)), 18, CAST(93045615.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (515, 3, N'2015', 20, CAST(49567310.00 AS Decimal(18, 2)), 18, CAST(81552341.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (516, 3, N'2016', 20, CAST(51435745.00 AS Decimal(18, 2)), 18, CAST(82837796.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (517, 3, N'2017', 20, CAST(57121975.00 AS Decimal(18, 2)), 18, CAST(90020575.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (518, 3, N'2018', 20, CAST(65020284.00 AS Decimal(18, 2)), 18, CAST(99550047.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (519, 3, N'2019', 20, CAST(64435078.00 AS Decimal(18, 2)), 18, CAST(92774475.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (520, 3, N'2020', 20, CAST(66731702.00 AS Decimal(18, 2)), 18, CAST(88955490.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (521, 3, N'2011', 10, CAST(91466126.00 AS Decimal(18, 2)), 13, CAST(89401172.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (522, 3, N'2012', 10, CAST(81711208.00 AS Decimal(18, 2)), 13, CAST(90727204.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (523, 3, N'2013', 10, CAST(84194176.00 AS Decimal(18, 2)), 13, CAST(94442690.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (524, 3, N'2014', 10, CAST(88574293.00 AS Decimal(18, 2)), 13, CAST(104888480.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (525, 3, N'2015', 10, CAST(73935687.00 AS Decimal(18, 2)), 13, CAST(98368704.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (526, 3, N'2016', 10, CAST(72652093.00 AS Decimal(18, 2)), 13, CAST(94905257.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (527, 3, N'2017', 10, CAST(72570697.00 AS Decimal(18, 2)), 13, CAST(95961991.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (528, 3, N'2018', 10, CAST(76813927.00 AS Decimal(18, 2)), 13, CAST(96942954.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (529, 3, N'2019', 10, CAST(73968958.00 AS Decimal(18, 2)), 13, CAST(88475888.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (530, 3, N'2020', 10, CAST(64510056.00 AS Decimal(18, 2)), 13, CAST(76380246.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (531, 3, N'2011', 7, CAST(66246065.00 AS Decimal(18, 2)), 20, CAST(60202557.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (532, 3, N'2012', 7, CAST(61328020.00 AS Decimal(18, 2)), 20, CAST(53532844.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (533, 3, N'2013', 7, CAST(61971043.00 AS Decimal(18, 2)), 20, CAST(56170087.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (534, 3, N'2014', 7, CAST(64128499.00 AS Decimal(18, 2)), 20, CAST(63110601.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (535, 3, N'2015', 7, CAST(54036205.00 AS Decimal(18, 2)), 20, CAST(57696208.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (536, 3, N'2016', 7, CAST(57215601.00 AS Decimal(18, 2)), 20, CAST(60327773.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (537, 3, N'2017', 7, CAST(62503877.00 AS Decimal(18, 2)), 20, CAST(66667799.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (538, 3, N'2018', 7, CAST(71146737.00 AS Decimal(18, 2)), 20, CAST(74762787.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (539, 3, N'2019', 7, CAST(63901631.00 AS Decimal(18, 2)), 20, CAST(73609779.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (540, 3, N'2020', 7, CAST(61665245.00 AS Decimal(18, 2)), 20, CAST(74028414.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (541, 3, N'2011', 9, CAST(52541030.00 AS Decimal(18, 2)), 7, CAST(85828428.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (542, 3, N'2012', 9, CAST(49639092.00 AS Decimal(18, 2)), 7, CAST(71046413.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (543, 3, N'2013', 9, CAST(52077146.00 AS Decimal(18, 2)), 7, CAST(70098925.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (544, 3, N'2014', 9, CAST(53867785.00 AS Decimal(18, 2)), 7, CAST(71613560.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (545, 3, N'2015', 9, CAST(47127224.00 AS Decimal(18, 2)), 7, CAST(64083976.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (546, 3, N'2016', 9, CAST(49120554.00 AS Decimal(18, 2)), 7, CAST(67712471.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (547, 3, N'2017', 9, CAST(52102300.00 AS Decimal(18, 2)), 7, CAST(73735334.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (548, 3, N'2018', 9, CAST(54821289.00 AS Decimal(18, 2)), 7, CAST(82387243.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (549, 3, N'2019', 9, CAST(51847920.00 AS Decimal(18, 2)), 7, CAST(75895458.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (550, 3, N'2020', 9, CAST(52361783.00 AS Decimal(18, 2)), 7, CAST(69026574.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (551, 3, N'2011', 22, CAST(45478683.00 AS Decimal(18, 2)), 32, CAST(79124244.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (552, 3, N'2012', 22, CAST(41760128.00 AS Decimal(18, 2)), 32, CAST(71554033.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (553, 3, N'2013', 22, CAST(43831827.00 AS Decimal(18, 2)), 32, CAST(73352504.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (554, 3, N'2014', 22, CAST(48840447.00 AS Decimal(18, 2)), 32, CAST(72909334.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (555, 3, N'2015', 22, CAST(43447447.00 AS Decimal(18, 2)), 32, CAST(63840808.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (556, 3, N'2016', 22, CAST(46731625.00 AS Decimal(18, 2)), 32, CAST(65482092.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (557, 3, N'2017', 22, CAST(51582891.00 AS Decimal(18, 2)), 32, CAST(70104620.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (558, 3, N'2018', 22, CAST(56147443.00 AS Decimal(18, 2)), 32, CAST(75389144.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (559, 3, N'2019', 22, CAST(53313659.00 AS Decimal(18, 2)), 32, CAST(71033393.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (560, 3, N'2020', 22, CAST(49800923.00 AS Decimal(18, 2)), 32, CAST(66650463.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (561, 3, N'2011', 32, CAST(50889534.00 AS Decimal(18, 2)), 9, CAST(67278677.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (562, 3, N'2012', 32, CAST(46428048.00 AS Decimal(18, 2)), 9, CAST(63463871.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (563, 3, N'2013', 32, CAST(47878974.00 AS Decimal(18, 2)), 9, CAST(63150724.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (564, 3, N'2014', 32, CAST(47680377.00 AS Decimal(18, 2)), 9, CAST(62606692.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (565, 3, N'2015', 32, CAST(40965636.00 AS Decimal(18, 2)), 9, CAST(54670993.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (566, 3, N'2016', 32, CAST(42275636.00 AS Decimal(18, 2)), 9, CAST(55895711.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (567, 3, N'2017', 32, CAST(45511686.00 AS Decimal(18, 2)), 9, CAST(61364846.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (568, 3, N'2018', 32, CAST(49489237.00 AS Decimal(18, 2)), 9, CAST(64304110.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (569, 3, N'2019', 32, CAST(46459920.00 AS Decimal(18, 2)), 9, CAST(63676565.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (570, 3, N'2020', 32, CAST(44307432.00 AS Decimal(18, 2)), 9, CAST(64792119.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (571, 3, N'2011', 17, CAST(51403026.00 AS Decimal(18, 2)), 17, CAST(64318098.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (572, 3, N'2012', 17, CAST(46632378.00 AS Decimal(18, 2)), 17, CAST(55785418.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (573, 3, N'2013', 17, CAST(49629350.00 AS Decimal(18, 2)), 17, CAST(55250847.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (574, 3, N'2014', 17, CAST(51025159.00 AS Decimal(18, 2)), 17, CAST(55474865.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (575, 3, N'2015', 17, CAST(39483220.00 AS Decimal(18, 2)), 17, CAST(45276822.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (576, 3, N'2016', 17, CAST(40066764.00 AS Decimal(18, 2)), 17, CAST(45925963.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (577, 3, N'2017', 17, CAST(44664391.00 AS Decimal(18, 2)), 17, CAST(49831849.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (578, 3, N'2018', 17, CAST(53232953.00 AS Decimal(18, 2)), 17, CAST(52307614.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (579, 3, N'2019', 17, CAST(45564783.00 AS Decimal(18, 2)), 17, CAST(51672860.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (580, 3, N'2020', 17, CAST(39325838.00 AS Decimal(18, 2)), 17, CAST(49420562.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (581, 3, N'2011', 13, CAST(60632048.00 AS Decimal(18, 2)), 22, CAST(41413529.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (582, 3, N'2012', 13, CAST(52930006.00 AS Decimal(18, 2)), 22, CAST(38378443.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (583, 3, N'2013', 13, CAST(51782588.00 AS Decimal(18, 2)), 22, CAST(40650287.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (584, 3, N'2014', 13, CAST(50626648.00 AS Decimal(18, 2)), 22, CAST(44154932.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (585, 3, N'2015', 13, CAST(41899255.00 AS Decimal(18, 2)), 22, CAST(40111389.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (586, 3, N'2016', 13, CAST(39082685.00 AS Decimal(18, 2)), 22, CAST(42003067.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (587, 3, N'2017', 13, CAST(41052569.00 AS Decimal(18, 2)), 22, CAST(46751005.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (588, 3, N'2018', 13, CAST(43374270.00 AS Decimal(18, 2)), 22, CAST(51842656.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (589, 3, N'2019', 13, CAST(42483543.00 AS Decimal(18, 2)), 22, CAST(49451433.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (590, 3, N'2020', 13, CAST(39163260.00 AS Decimal(18, 2)), 22, CAST(44921177.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (591, 3, N'2011', 14, CAST(31301047.00 AS Decimal(18, 2)), 14, CAST(48435742.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (592, 3, N'2012', 14, CAST(29837449.00 AS Decimal(18, 2)), 14, CAST(39879186.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (593, 3, N'2013', 14, CAST(31389321.00 AS Decimal(18, 2)), 14, CAST(41607663.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (594, 3, N'2014', 14, CAST(32956432.00 AS Decimal(18, 2)), 14, CAST(46242249.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (595, 3, N'2015', 14, CAST(29036272.00 AS Decimal(18, 2)), 14, CAST(42974802.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (596, 3, N'2016', 14, CAST(30822670.00 AS Decimal(18, 2)), 14, CAST(44843868.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (597, 3, N'2017', 14, CAST(35430483.00 AS Decimal(18, 2)), 14, CAST(48610534.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (598, 3, N'2018', 14, CAST(38313611.00 AS Decimal(18, 2)), 14, CAST(52254479.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (599, 3, N'2019', 14, CAST(37100139.00 AS Decimal(18, 2)), 14, CAST(49530690.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (600, 3, N'2020', 14, CAST(35760451.00 AS Decimal(18, 2)), 14, CAST(42889381.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (601, 3, N'2011', 31, CAST(25341993.00 AS Decimal(18, 2)), 31, CAST(21953043.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (602, 3, N'2012', 31, CAST(23736708.00 AS Decimal(18, 2)), 31, CAST(20829781.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (603, 3, N'2013', 31, CAST(25855565.00 AS Decimal(18, 2)), 31, CAST(23244538.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (604, 3, N'2014', 31, CAST(29184595.00 AS Decimal(18, 2)), 31, CAST(26339615.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (605, 3, N'2015', 31, CAST(26365011.00 AS Decimal(18, 2)), 31, CAST(24209029.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (606, 3, N'2016', 31, CAST(27679122.00 AS Decimal(18, 2)), 31, CAST(25190525.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (607, 3, N'2017', 31, CAST(29802977.00 AS Decimal(18, 2)), 31, CAST(28148168.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (608, 3, N'2018', 31, CAST(32331752.00 AS Decimal(18, 2)), 31, CAST(30921545.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (609, 3, N'2019', 31, CAST(31982877.00 AS Decimal(18, 2)), 31, CAST(30096079.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (610, 3, N'2020', 31, CAST(31491389.00 AS Decimal(18, 2)), 31, CAST(28103543.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (611, 3, N'2011', 5, CAST(0.00 AS Decimal(18, 2)), 26, CAST(30664656.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (612, 3, N'2012', 5, CAST(349.00 AS Decimal(18, 2)), 26, CAST(27108185.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (613, 3, N'2013', 5, CAST(0.00 AS Decimal(18, 2)), 26, CAST(27309765.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (614, 3, N'2014', 5, CAST(0.00 AS Decimal(18, 2)), 26, CAST(28391467.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (615, 3, N'2015', 5, CAST(35798023.00 AS Decimal(18, 2)), 26, CAST(25443563.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (616, 3, N'2016', 5, CAST(26109818.00 AS Decimal(18, 2)), 26, CAST(27502742.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (617, 3, N'2017', 5, CAST(29197782.00 AS Decimal(18, 2)), 26, CAST(30144771.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (618, 3, N'2018', 5, CAST(34607375.00 AS Decimal(18, 2)), 26, CAST(30958464.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (619, 3, N'2019', 5, CAST(35504547.00 AS Decimal(18, 2)), 26, CAST(27888450.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (620, 3, N'2020', 5, CAST(29390705.00 AS Decimal(18, 2)), 26, CAST(26671674.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (621, 3, N'2011', 16, CAST(34885269.00 AS Decimal(18, 2)), 4, CAST(49359616.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (622, 3, N'2012', 16, CAST(29961882.00 AS Decimal(18, 2)), 4, CAST(50180976.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (623, 3, N'2013', 16, CAST(27492037.00 AS Decimal(18, 2)), 4, CAST(48738490.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (624, 3, N'2014', 16, CAST(26500610.00 AS Decimal(18, 2)), 4, CAST(39845206.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (625, 3, N'2015', 16, CAST(22377628.00 AS Decimal(18, 2)), 4, CAST(24003995.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (626, 3, N'2016', 16, CAST(24267202.00 AS Decimal(18, 2)), 4, CAST(23823913.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (627, 3, N'2017', 16, CAST(25896658.00 AS Decimal(18, 2)), 4, CAST(29110398.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (628, 3, N'2018', 16, CAST(28016813.00 AS Decimal(18, 2)), 4, CAST(30575295.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (629, 3, N'2019', 16, CAST(26756331.00 AS Decimal(18, 2)), 4, CAST(29725013.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (630, 3, N'2020', 16, CAST(24265086.00 AS Decimal(18, 2)), 4, CAST(26340316.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (631, 3, N'2011', 46, CAST(17166289.00 AS Decimal(18, 2)), 1, CAST(28160076.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (632, 3, N'2012', 46, CAST(12974604.00 AS Decimal(18, 2)), 1, CAST(25950999.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (633, 3, N'2013', 46, CAST(11660523.00 AS Decimal(18, 2)), 1, CAST(28498296.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (634, 3, N'2014', 46, CAST(11789826.00 AS Decimal(18, 2)), 1, CAST(25664987.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (635, 3, N'2015', 46, CAST(11998963.00 AS Decimal(18, 2)), 1, CAST(24703019.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (636, 3, N'2016', 46, CAST(13085647.00 AS Decimal(18, 2)), 1, CAST(24216131.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (637, 3, N'2017', 46, CAST(13213641.00 AS Decimal(18, 2)), 1, CAST(24280334.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (638, 3, N'2018', 46, CAST(15991247.00 AS Decimal(18, 2)), 1, CAST(22729040.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (639, 3, N'2019', 46, CAST(20590270.00 AS Decimal(18, 2)), 1, CAST(21903773.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (640, 3, N'2020', 46, CAST(24068502.00 AS Decimal(18, 2)), 1, CAST(24413252.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (641, 3, N'2011', 1, CAST(16433879.00 AS Decimal(18, 2)), 48, CAST(20339168.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (642, 3, N'2012', 1, CAST(15526526.00 AS Decimal(18, 2)), 48, CAST(19075405.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (643, 3, N'2013', 1, CAST(16350055.00 AS Decimal(18, 2)), 48, CAST(20732965.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (644, 3, N'2014', 1, CAST(17880771.00 AS Decimal(18, 2)), 48, CAST(21514739.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (645, 3, N'2015', 1, CAST(16113896.00 AS Decimal(18, 2)), 48, CAST(18487291.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (646, 3, N'2016', 1, CAST(17107232.00 AS Decimal(18, 2)), 48, CAST(19206751.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (647, 3, N'2017', 1, CAST(18367627.00 AS Decimal(18, 2)), 48, CAST(20691180.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (648, 3, N'2018', 1, CAST(19374084.00 AS Decimal(18, 2)), 48, CAST(23572859.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (649, 3, N'2019', 1, CAST(17764158.00 AS Decimal(18, 2)), 48, CAST(21488112.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (650, 3, N'2020', 1, CAST(17539239.00 AS Decimal(18, 2)), 48, CAST(21060571.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (651, 3, N'2011', 4, CAST(41696767.00 AS Decimal(18, 2)), 11, CAST(16347514.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (652, 3, N'2012', 4, CAST(41244185.00 AS Decimal(18, 2)), 11, CAST(17277253.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (653, 3, N'2013', 4, CAST(39698776.00 AS Decimal(18, 2)), 11, CAST(19262785.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (654, 3, N'2014', 4, CAST(37042740.00 AS Decimal(18, 2)), 11, CAST(20826022.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (655, 3, N'2015', 4, CAST(22930858.00 AS Decimal(18, 2)), 11, CAST(19818360.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (656, 3, N'2016', 4, CAST(20598602.00 AS Decimal(18, 2)), 11, CAST(19059815.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (657, 3, N'2017', 4, CAST(25090016.00 AS Decimal(18, 2)), 11, CAST(19740735.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (658, 3, N'2018', 4, CAST(29964134.00 AS Decimal(18, 2)), 11, CAST(20416308.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (659, 3, N'2019', 4, CAST(24863110.00 AS Decimal(18, 2)), 11, CAST(19316422.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (660, 3, N'2020', 4, CAST(17452102.00 AS Decimal(18, 2)), 11, CAST(20262669.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (661, 3, N'2011', 43, CAST(14928333.00 AS Decimal(18, 2)), 16, CAST(21397447.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (662, 3, N'2012', 43, CAST(15441972.00 AS Decimal(18, 2)), 16, CAST(22236864.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (663, 3, N'2013', 43, CAST(16270576.00 AS Decimal(18, 2)), 16, CAST(22872493.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (664, 3, N'2014', 43, CAST(17018365.00 AS Decimal(18, 2)), 16, CAST(22779313.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (665, 3, N'2015', 43, CAST(15033565.00 AS Decimal(18, 2)), 16, CAST(18826075.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (666, 3, N'2016', 43, CAST(15824653.00 AS Decimal(18, 2)), 16, CAST(20252781.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (667, 3, N'2017', 43, CAST(16535259.00 AS Decimal(18, 2)), 16, CAST(22091562.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (668, 3, N'2018', 43, CAST(19524145.00 AS Decimal(18, 2)), 16, CAST(24118012.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (669, 3, N'2019', 43, CAST(19756412.00 AS Decimal(18, 2)), 16, CAST(23137108.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (670, 3, N'2020', 43, CAST(17283979.00 AS Decimal(18, 2)), 16, CAST(19820883.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (671, 3, N'2011', 26, CAST(19647383.00 AS Decimal(18, 2)), 21, CAST(12248000.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (672, 3, N'2012', 26, CAST(17708038.00 AS Decimal(18, 2)), 21, CAST(11772704.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (673, 3, N'2013', 26, CAST(18474036.00 AS Decimal(18, 2)), 21, CAST(12797058.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (674, 3, N'2014', 26, CAST(18640529.00 AS Decimal(18, 2)), 21, CAST(14290127.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (675, 3, N'2015', 26, CAST(15477649.00 AS Decimal(18, 2)), 21, CAST(13554189.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (676, 3, N'2016', 26, CAST(15836404.00 AS Decimal(18, 2)), 21, CAST(15006649.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (677, 3, N'2017', 26, CAST(17527565.00 AS Decimal(18, 2)), 21, CAST(17107228.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (678, 3, N'2018', 26, CAST(18665337.00 AS Decimal(18, 2)), 21, CAST(19201389.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (679, 3, N'2019', 26, CAST(17203238.00 AS Decimal(18, 2)), 21, CAST(18849464.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (680, 3, N'2020', 26, CAST(16800497.00 AS Decimal(18, 2)), 21, CAST(18121514.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (681, 3, N'2011', 21, CAST(11639143.00 AS Decimal(18, 2)), 43, CAST(14439690.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (682, 3, N'2012', 21, CAST(11079611.00 AS Decimal(18, 2)), 43, CAST(13286692.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (683, 3, N'2013', 21, CAST(12178935.00 AS Decimal(18, 2)), 43, CAST(14125092.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (684, 3, N'2014', 21, CAST(13575175.00 AS Decimal(18, 2)), 43, CAST(14797917.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (685, 3, N'2015', 21, CAST(11903352.00 AS Decimal(18, 2)), 43, CAST(13494660.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (686, 3, N'2016', 21, CAST(13846099.00 AS Decimal(18, 2)), 43, CAST(13873927.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (687, 3, N'2017', 21, CAST(16882192.00 AS Decimal(18, 2)), 43, CAST(14694568.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (688, 3, N'2018', 21, CAST(18896141.00 AS Decimal(18, 2)), 43, CAST(16474406.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (689, 3, N'2019', 21, CAST(17686738.00 AS Decimal(18, 2)), 43, CAST(15760231.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (690, 3, N'2020', 21, CAST(15483911.00 AS Decimal(18, 2)), 43, CAST(15067913.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (691, 3, N'2011', 11, CAST(13545687.00 AS Decimal(18, 2)), 49, CAST(10598271.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (692, 3, N'2012', 11, CAST(10969600.00 AS Decimal(18, 2)), 49, CAST(11446026.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (693, 3, N'2013', 11, CAST(10753920.00 AS Decimal(18, 2)), 49, CAST(11947601.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (694, 3, N'2014', 11, CAST(10661567.00 AS Decimal(18, 2)), 49, CAST(12099606.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (695, 3, N'2015', 11, CAST(8524684.00 AS Decimal(18, 2)), 49, CAST(12265035.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (696, 3, N'2016', 11, CAST(8565734.00 AS Decimal(18, 2)), 49, CAST(12278572.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (697, 3, N'2017', 11, CAST(12828572.00 AS Decimal(18, 2)), 49, CAST(14593792.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (698, 3, N'2018', 11, CAST(14316894.00 AS Decimal(18, 2)), 49, CAST(16405187.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (699, 3, N'2019', 11, CAST(13760781.00 AS Decimal(18, 2)), 49, CAST(15325969.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (700, 3, N'2020', 11, CAST(12907440.00 AS Decimal(18, 2)), 49, CAST(12919728.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (701, 3, N'2011', 48, CAST(16705629.00 AS Decimal(18, 2)), 15, CAST(15190395.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (702, 3, N'2012', 48, CAST(14395137.00 AS Decimal(18, 2)), 15, CAST(13445520.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (703, 3, N'2013', 48, CAST(14887657.00 AS Decimal(18, 2)), 15, CAST(12219742.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (704, 3, N'2014', 48, CAST(15076848.00 AS Decimal(18, 2)), 15, CAST(11885134.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (705, 3, N'2015', 48, CAST(12365865.00 AS Decimal(18, 2)), 15, CAST(10794023.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (706, 3, N'2016', 48, CAST(12205392.00 AS Decimal(18, 2)), 15, CAST(10822829.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (707, 3, N'2017', 48, CAST(13159911.00 AS Decimal(18, 2)), 15, CAST(12073716.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (708, 3, N'2018', 48, CAST(14784872.00 AS Decimal(18, 2)), 15, CAST(14733295.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (709, 3, N'2019', 48, CAST(13169187.00 AS Decimal(18, 2)), 15, CAST(13336497.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (710, 3, N'2020', 48, CAST(12606295.00 AS Decimal(18, 2)), 15, CAST(12230743.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (711, 3, N'2011', 34, CAST(5643214.00 AS Decimal(18, 2)), 42, CAST(11753963.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (712, 3, N'2012', 34, CAST(6649829.00 AS Decimal(18, 2)), 42, CAST(10324539.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (713, 3, N'2013', 34, CAST(7541006.00 AS Decimal(18, 2)), 42, CAST(10843050.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (714, 3, N'2014', 34, CAST(8092434.00 AS Decimal(18, 2)), 42, CAST(11642828.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (715, 3, N'2015', 34, CAST(8924402.00 AS Decimal(18, 2)), 42, CAST(9958768.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (716, 3, N'2016', 34, CAST(9745278.00 AS Decimal(18, 2)), 42, CAST(10215943.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (717, 3, N'2017', 34, CAST(10887622.00 AS Decimal(18, 2)), 42, CAST(12496199.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (718, 3, N'2018', 34, CAST(11552172.00 AS Decimal(18, 2)), 42, CAST(13131622.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (719, 3, N'2019', 34, CAST(10884226.00 AS Decimal(18, 2)), 42, CAST(12379238.00 AS Decimal(18, 2)))
INSERT [dbo].[Genel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat_ulkeID], [Ithalat], [Ihracat_ulkeID], [Ihracat]) VALUES (720, 3, N'2020', 34, CAST(11732363.00 AS Decimal(18, 2)), 42, CAST(11727989.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Genel_Ulke_Raporu] OFF
GO
SET IDENTITY_INSERT [dbo].[Ozel_Ulke_Raporu] ON 

INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (1, 1, N'2011', CAST(240841676.00 AS Decimal(18, 2)), CAST(134906869.00 AS Decimal(18, 2)), CAST(105934807.00 AS Decimal(18, 2)), CAST(-105934807.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (2, 1, N'2012', CAST(236545141.00 AS Decimal(18, 2)), CAST(152461737.00 AS Decimal(18, 2)), CAST(84083404.00 AS Decimal(18, 2)), CAST(-84083404.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (3, 1, N'2013', CAST(251661250.00 AS Decimal(18, 2)), CAST(151802637.00 AS Decimal(18, 2)), CAST(99858613.00 AS Decimal(18, 2)), CAST(-99858613.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (4, 1, N'2014', CAST(242177117.00 AS Decimal(18, 2)), CAST(157610158.00 AS Decimal(18, 2)), CAST(84566959.00 AS Decimal(18, 2)), CAST(-84566959.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (5, 1, N'2015', CAST(207235628.00 AS Decimal(18, 2)), CAST(143844066.00 AS Decimal(18, 2)), CAST(63391562.00 AS Decimal(18, 2)), CAST(-63391562.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (6, 1, N'2016', CAST(198601934.00 AS Decimal(18, 2)), CAST(142606247.00 AS Decimal(18, 2)), CAST(55995687.00 AS Decimal(18, 2)), CAST(-55995687.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (7, 1, N'2017', CAST(233799651.00 AS Decimal(18, 2)), CAST(156992940.00 AS Decimal(18, 2)), CAST(76806711.00 AS Decimal(18, 2)), CAST(-76806711.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (8, 1, N'2018', CAST(223046879.00 AS Decimal(18, 2)), CAST(167923862.00 AS Decimal(18, 2)), CAST(55123017.00 AS Decimal(18, 2)), CAST(-55123017.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (9, 1, N'2019', CAST(210346890.00 AS Decimal(18, 2)), CAST(180870841.00 AS Decimal(18, 2)), CAST(29476049.00 AS Decimal(18, 2)), CAST(-29476049.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (10, 1, N'2020', CAST(219514373.00 AS Decimal(18, 2)), CAST(169657940.00 AS Decimal(18, 2)), CAST(49856433.00 AS Decimal(18, 2)), CAST(-49856433.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (11, 10, N'2011', CAST(713675254.00 AS Decimal(18, 2)), CAST(585723824.00 AS Decimal(18, 2)), CAST(127951430.00 AS Decimal(18, 2)), CAST(-127951430.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (12, 10, N'2012', CAST(666675231.00 AS Decimal(18, 2)), CAST(558460545.00 AS Decimal(18, 2)), CAST(108214686.00 AS Decimal(18, 2)), CAST(-108214686.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (13, 10, N'2013', CAST(671253553.00 AS Decimal(18, 2)), CAST(567987698.00 AS Decimal(18, 2)), CAST(103265855.00 AS Decimal(18, 2)), CAST(-103265855.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (14, 10, N'2014', CAST(667601846.00 AS Decimal(18, 2)), CAST(569409762.00 AS Decimal(18, 2)), CAST(98192084.00 AS Decimal(18, 2)), CAST(-98192084.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (15, 10, N'2015', CAST(563204454.00 AS Decimal(18, 2)), CAST(495442074.00 AS Decimal(18, 2)), CAST(67762380.00 AS Decimal(18, 2)), CAST(-67762380.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (16, 10, N'2016', CAST(559283575.00 AS Decimal(18, 2)), CAST(490188457.00 AS Decimal(18, 2)), CAST(69095118.00 AS Decimal(18, 2)), CAST(-69095118.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (17, 10, N'2017', CAST(609088414.00 AS Decimal(18, 2)), CAST(523809550.00 AS Decimal(18, 2)), CAST(85278864.00 AS Decimal(18, 2)), CAST(-85278864.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (18, 10, N'2018', CAST(660155685.00 AS Decimal(18, 2)), CAST(569138524.00 AS Decimal(18, 2)), CAST(91017161.00 AS Decimal(18, 2)), CAST(-91017161.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (19, 10, N'2019', CAST(637949069.00 AS Decimal(18, 2)), CAST(555100606.00 AS Decimal(18, 2)), CAST(82848463.00 AS Decimal(18, 2)), CAST(-82848463.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (20, 10, N'2020', CAST(568329124.00 AS Decimal(18, 2)), CAST(475071675.00 AS Decimal(18, 2)), CAST(93257449.00 AS Decimal(18, 2)), CAST(-93257449.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (21, 3, N'2011', CAST(1261588484.00 AS Decimal(18, 2)), CAST(1483802558.00 AS Decimal(18, 2)), CAST(-222214074.00 AS Decimal(18, 2)), CAST(222214074.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (22, 3, N'2012', CAST(1161247824.00 AS Decimal(18, 2)), CAST(1410146321.00 AS Decimal(18, 2)), CAST(-248898497.00 AS Decimal(18, 2)), CAST(248898497.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (23, 3, N'2013', CAST(1187301533.00 AS Decimal(18, 2)), CAST(1450937515.00 AS Decimal(18, 2)), CAST(-263635982.00 AS Decimal(18, 2)), CAST(263635982.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (24, 3, N'2014', CAST(1214915242.00 AS Decimal(18, 2)), CAST(1498238432.00 AS Decimal(18, 2)), CAST(-283323190.00 AS Decimal(18, 2)), CAST(283323190.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (25, 3, N'2015', CAST(1053388444.00 AS Decimal(18, 2)), CAST(1323665116.00 AS Decimal(18, 2)), CAST(-270276672.00 AS Decimal(18, 2)), CAST(270276672.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (26, 3, N'2016', CAST(1056664804.00 AS Decimal(18, 2)), CAST(1332489067.00 AS Decimal(18, 2)), CAST(-275824263.00 AS Decimal(18, 2)), CAST(275824263.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (27, 3, N'2017', CAST(1164586085.00 AS Decimal(18, 2)), CAST(1444776367.00 AS Decimal(18, 2)), CAST(-280190282.00 AS Decimal(18, 2)), CAST(280190282.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (28, 3, N'2018', CAST(1286008402.00 AS Decimal(18, 2)), CAST(1556622939.00 AS Decimal(18, 2)), CAST(-270614537.00 AS Decimal(18, 2)), CAST(270614537.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (29, 3, N'2019', CAST(1236217435.00 AS Decimal(18, 2)), CAST(1486877250.00 AS Decimal(18, 2)), CAST(-250659815.00 AS Decimal(18, 2)), CAST(250659815.00 AS Decimal(18, 2)))
INSERT [dbo].[Ozel_Ulke_Raporu] ([ID], [ulkeID], [Yil], [Ithalat], [Ihracat], [Hacim], [Denge]) VALUES (30, 3, N'2020', CAST(1171622058.00 AS Decimal(18, 2)), CAST(1377863429.00 AS Decimal(18, 2)), CAST(-206241371.00 AS Decimal(18, 2)), CAST(206241371.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Ozel_Ulke_Raporu] OFF
GO
SET IDENTITY_INSERT [dbo].[UlkeListesi] ON 

INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (1, N'Turkey')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (2, N'China')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (3, N'Germany')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (4, N'Russian Federation')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (5, N'Area Nes')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (6, N'United States of America')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (7, N'Italy')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (8, N'Iraq')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (9, N'Switzerland')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (10, N'France')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (11, N'Korea, Republic of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (12, N'United Arab Emirates')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (13, N'United Kingdom')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (14, N'Spain')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (15, N'India')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (16, N'Japan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (17, N'Belgium')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (18, N'Netherlands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (19, N'Brazil')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (20, N'Poland')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (21, N'Romania')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (22, N'Czech Republic')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (23, N'Ukraine')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (24, N'Bulgaria')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (25, N'Malaysia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (26, N'Sweden')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (27, N'Egypt')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (28, N'Saudi Arabia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (29, N'Libya, State of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (30, N'Israel')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (31, N'Hungary')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (32, N'Austria')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (33, N'Taipei, Chinese')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (34, N'Viet Nam')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (35, N'Greece')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (36, N'Thailand')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (37, N'Iran, Islamic Republic of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (38, N'Indonesia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (39, N'Kazakhstan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (40, N'Canada')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (41, N'Colombia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (42, N'Finland')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (43, N'Slovakia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (44, N'Uzbekistan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (45, N'Portugal')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (46, N'Ireland')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (47, N'South Africa')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (48, N'Denmark')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (49, N'Mexico')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (50, N'Norway')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (51, N'Morocco')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (52, N'Bangladesh')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (53, N'Algeria')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (54, N'Argentina')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (55, N'Lithuania')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (56, N'Serbia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (57, N'Azerbaijan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (58, N'Australia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (59, N'Slovenia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (60, N'Georgia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (61, N'Oman')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (62, N'Côte d''Ivoire')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (63, N'Turkmenistan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (64, N'Qatar')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (65, N'Singapore')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (66, N'Chile')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (67, N'Ghana')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (68, N'Peru')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (69, N'Pakistan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (70, N'Hong Kong, China')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (71, N'Syrian Arab Republic')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (72, N'Croatia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (73, N'Uruguay')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (74, N'Bosnia and Herzegovina')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (75, N'Moldova, Republic of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (76, N'Bahrain')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (77, N'Belarus')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (78, N'Bolivia, Plurinational State of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (79, N'Estonia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (80, N'Guinea')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (81, N'Ecuador')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (82, N'Latvia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (83, N'Tunisia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (84, N'Tajikistan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (85, N'Luxembourg')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (86, N'Macedonia, North')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (87, N'Philippines')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (88, N'Nigeria')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (89, N'Malta')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (90, N'Sudan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (91, N'Liberia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (92, N'Jordan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (93, N'Kyrgyzstan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (94, N'Sri Lanka')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (95, N'Cyprus')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (96, N'Mozambique')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (97, N'Chad')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (98, N'Costa Rica')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (99, N'Cambodia')
GO
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (100, N'Venezuela, Bolivarian Republic of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (101, N'Rwanda')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (102, N'Kuwait')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (103, N'Lebanon')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (104, N'Tanzania, United Republic of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (105, N'Myanmar')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (106, N'Cameroon')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (107, N'Ethiopia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (108, N'Panama')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (109, N'Marshall Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (110, N'Palestine, State of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (111, N'New Zealand')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (112, N'Albania')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (113, N'Afghanistan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (114, N'Mauritania')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (115, N'Iceland')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (116, N'Kenya')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (117, N'Trinidad and Tobago')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (118, N'Gabon')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (119, N'Malawi')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (120, N'Senegal')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (121, N'Montenegro')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (122, N'Guatemala')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (123, N'Dominican Republic')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (124, N'Madagascar')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (125, N'Nepal')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (126, N'Zimbabwe')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (127, N'Cuba')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (128, N'Togo')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (129, N'Uganda')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (130, N'Seychelles')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (131, N'Palau')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (132, N'Congo')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (133, N'Yemen')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (134, N'Burkina Faso')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (135, N'Bahamas')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (136, N'Honduras')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (137, N'Benin')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (138, N'Somalia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (139, N'Comoros')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (140, N'Angola')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (141, N'Paraguay')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (142, N'Zambia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (143, N'Lao People''s Democratic Republic')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (144, N'Mali')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (145, N'Armenia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (146, N'Mauritius')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (147, N'Mongolia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (148, N'Saint Kitts and Nevis')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (149, N'El Salvador')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (150, N'Sierra Leone')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (151, N'Central African Republic')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (152, N'Gambia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (153, N'Guyana')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (154, N'Saint Vincent and the Grenadines')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (155, N'Faroe Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (156, N'Guinea-Bissau')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (157, N'Congo, Democratic Republic of the')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (158, N'Nicaragua')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (159, N'Bhutan')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (160, N'Haiti')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (161, N'Gibraltar')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (162, N'United States Minor Outlying Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (163, N'Papua New Guinea')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (164, N'Niger')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (165, N'Jamaica')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (166, N'Namibia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (167, N'Burundi')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (168, N'Tuvalu')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (169, N'Korea, Democratic People''s Republic of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (170, N'Niue')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (171, N'Suriname')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (172, N'Antigua and Barbuda')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (173, N'Timor-Leste')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (174, N'Dominica')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (175, N'Djibouti')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (176, N'Fiji')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (177, N'Nauru')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (178, N'Montserrat')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (179, N'Macao, China')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (180, N'Sao Tome and Principe')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (181, N'Equatorial Guinea')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (182, N'Maldives')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (183, N'Barbados')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (184, N'Cayman Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (185, N'Tokelau')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (186, N'Wallis and Futuna Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (187, N'Brunei Darussalam')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (188, N'French Polynesia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (189, N'Lesotho')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (190, N'Andorra')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (191, N'Greenland')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (192, N'Cabo Verde')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (193, N'Eswatini')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (194, N'Turks and Caicos Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (195, N'Botswana')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (196, N'Eritrea')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (197, N'Bermuda')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (198, N'Curaçao')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (199, N'Belize')
GO
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (200, N'Grenada')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (201, N'Cocos (Keeling) Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (202, N'Saint Helena')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (203, N'Kiribati')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (204, N'New Caledonia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (205, N'British Indian Ocean Territory')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (206, N'British Virgin Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (207, N'Christmas Island')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (208, N'Falkland Islands (Malvinas)')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (209, N'French Southern and Antarctic Territories')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (210, N'Vanuatu')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (211, N'Norfolk Island')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (212, N'Northern Mariana Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (213, N'Pitcairn')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (214, N'Anguilla')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (215, N'St. Pierre and Miquelon')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (216, N'Free Zones')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (217, N'Solomon Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (218, N'Cook Islands')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (219, N'Aruba')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (220, N'Micronesia, Federated States of')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (221, N'Saint Lucia')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (222, N'Samoa')
INSERT [dbo].[UlkeListesi] ([ID], [ulkeAd]) VALUES (223, N'')
SET IDENTITY_INSERT [dbo].[UlkeListesi] OFF
GO
ALTER TABLE [dbo].[Genel_Ulke_Raporu]  WITH CHECK ADD  CONSTRAINT [FK_Genel_Ulke_Raporu_UlkeListesi] FOREIGN KEY([ulkeID])
REFERENCES [dbo].[UlkeListesi] ([ID])
GO
ALTER TABLE [dbo].[Genel_Ulke_Raporu] CHECK CONSTRAINT [FK_Genel_Ulke_Raporu_UlkeListesi]
GO
ALTER TABLE [dbo].[Genel_Ulke_Raporu]  WITH CHECK ADD  CONSTRAINT [FK_Genel_Ulke_Raporu_UlkeListesi1] FOREIGN KEY([Ithalat_ulkeID])
REFERENCES [dbo].[UlkeListesi] ([ID])
GO
ALTER TABLE [dbo].[Genel_Ulke_Raporu] CHECK CONSTRAINT [FK_Genel_Ulke_Raporu_UlkeListesi1]
GO
ALTER TABLE [dbo].[Genel_Ulke_Raporu]  WITH CHECK ADD  CONSTRAINT [FK_Genel_Ulke_Raporu_UlkeListesi2] FOREIGN KEY([Ihracat_ulkeID])
REFERENCES [dbo].[UlkeListesi] ([ID])
GO
ALTER TABLE [dbo].[Genel_Ulke_Raporu] CHECK CONSTRAINT [FK_Genel_Ulke_Raporu_UlkeListesi2]
GO
ALTER TABLE [dbo].[Ozel_Ulke_Raporu]  WITH CHECK ADD  CONSTRAINT [FK_Ozel_Ulke_Raporu_UlkeListesi] FOREIGN KEY([ulkeID])
REFERENCES [dbo].[UlkeListesi] ([ID])
GO
ALTER TABLE [dbo].[Ozel_Ulke_Raporu] CHECK CONSTRAINT [FK_Ozel_Ulke_Raporu_UlkeListesi]
GO
/****** Object:  StoredProcedure [dbo].[Proc_GenelUlkeRapor_Islem]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_GenelUlkeRapor_Islem]
  
		@Islem					nvarchar(50),
		@ulkeAd					nvarchar(60),
		@Yil					nvarchar(8),
		@Ithalat_ulkeAd			nvarchar(60),
		@Ithalat				int,
		@Ihracat_ulkeAd			nvarchar(60),
		@Ihracat				int
		
AS
BEGIN
		IF(@Islem='Yeni')
			Begin
				declare	 @ulkeID 			int
				declare  @ithalat_ulkeID	int
				declare	 @ihracat_ulkeID	int

				declare @ulke int  
				declare @ithalatulke int  
				declare @ihracatulke int

				Select @ulke		= COUNT(1) from View_Base_Ulkeler Where ulkeAd=@ulkeAd 
				Select @ithalatulke = COUNT(1) from View_Base_Ulkeler Where ulkeAd=@Ithalat_ulkeAd 
				Select @ihracatulke = COUNT(1) from View_Base_Ulkeler Where ulkeAd=@Ihracat_ulkeAd

				IF(@ulke=0)

					Begin
						Insert Into [dbo].[UlkeListesi]
						(
						ulkeAd
						) 
						values
						(
						@ulkeAd
						)
					END

				IF(@ithalatulke=0)

					Begin
						Insert Into [dbo].[UlkeListesi]
						(
						ulkeAd
						) 
						values
						(
						@Ithalat_ulkeAd
						)
					END

				IF(@ihracatulke=0)

					Begin
						Insert Into [dbo].[UlkeListesi]
						(
						ulkeAd
						)
						values
						(
						@Ihracat_ulkeAd
						)
					END


				IF(@ulke=1 and @ithalatulke=1 and @ihracatulke=1)

					Begin
						Set		@ulkeID			=(select ID from View_Base_Ulkeler where ulkeAd = @ulkeAd)
						Set		@ithalat_ulkeID	=(select ID from View_Base_Ulkeler where ulkeAd = @Ithalat_ulkeAd)
						Set		@ihracat_ulkeID	=(select ID from View_Base_Ulkeler where ulkeAd = @Ihracat_ulkeAd)

						Insert Into [dbo].[Genel_Ulke_Raporu]
						(ulkeID
						,Yil
						,Ithalat_ulkeID
						,Ithalat
						,Ihracat_ulkeID
						,Ihracat) 
						values
						(@ulkeID
						,@Yil
						,@ithalat_ulkeID
						,@Ithalat
						,@ihracat_ulkeID
						,@Ihracat)

					END
				End

		IF(@Islem='Liste')
			Begin
				select * From View_Presentation_GenelUlke 
			END

		 
END


GO
/****** Object:  StoredProcedure [dbo].[Proc_OzelUlkeRapor_Islem]    Script Date: 22.06.2021 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_OzelUlkeRapor_Islem]
  
		@Islem					nvarchar(50),
		@ulkeAd					nvarchar(60),
		@Yil					nvarchar(8),
		@Ithalat				int,
		@Ihracat				int,
		@Hacim					int,
		@Denge					int
		
AS
BEGIN
		IF(@Islem='Yeni')
			Begin
				Declare	@ulkeID	int

				Declare @ulke int
				Select @ulke = COUNT(1) from UlkeListesi
				Where ulkeAd=@ulkeAd

				IF(@ulke=0)
					Begin
						Insert Into [dbo].[UlkeListesi]
						(
						[ulkeAd]
						) 
						values
						(
						@ulkeAd
						)
						Set		@ulkeID	=(select ID from View_Base_Ulkeler where ulkeAd = @ulkeAd)
						Insert Into [dbo].[Ozel_Ulke_Raporu]
						([ulkeID]
						,[Yil]
						,[Ithalat]
						,[Ihracat]
						,[Hacim]
						,[Denge]
						)
						Values
						(@ulkeID 
						,@Yil 
						,@Ithalat
						,@Ihracat
						,@Hacim
						,@Denge
						)
					End

					ELSE	
					BEGIN
						Set	@ulkeID	=(select ID from View_Base_Ulkeler where ulkeAd = @ulkeAd)

						Insert Into Ozel_Ulke_Raporu
						([ulkeID]
						,[Yil]
						,[Ithalat]
						,[Ihracat]
						,[Hacim]
						,[Denge]
						)
						Values
						(@ulkeID 
						,@Yil 
						,@Ithalat 
						,@Ihracat 
						,@Hacim 
						,@Denge
						)
					END
				End


		IF(@Islem='Liste')
			Begin
				select * From View_Presentation_OzelUlke 
			END

		 

		

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
         Begin Table = "Genel_Ulke_Raporu"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 224
               Right = 208
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_GenelUlkeRapor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_GenelUlkeRapor'
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
         Begin Table = "Ozel_Ulke_Raporu"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 236
               Right = 208
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_OzelUlkeRapor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_OzelUlkeRapor'
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
         Begin Table = "UlkeListesi"
            Begin Extent = 
               Top = 6
               Left = 25
               Bottom = 160
               Right = 208
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_Ulkeler'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Base_Ulkeler'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[33] 2[18] 3) )"
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
         Begin Table = "View_Base_GenelUlkeRapor"
            Begin Extent = 
               Top = 6
               Left = 51
               Bottom = 258
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_Base_Ulkeler"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Presentation_GenelUlke'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Presentation_GenelUlke'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
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
         Begin Table = "View_Base_OzelUlkeRapor"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 231
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_Base_Ulkeler"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 191
               Right = 416
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Presentation_OzelUlke'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Presentation_OzelUlke'
GO
