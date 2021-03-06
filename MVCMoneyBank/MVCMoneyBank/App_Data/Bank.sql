USE [master]
GO
/****** Object:  Database [Bank]    Script Date: 2/7/2020 8:58:49 PM ******/
CREATE DATABASE [Bank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bank', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Bank.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Bank_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Bank_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Bank] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bank].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bank] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bank] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bank] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bank] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bank] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bank] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bank] SET RECOVERY FULL 
GO
ALTER DATABASE [Bank] SET  MULTI_USER 
GO
ALTER DATABASE [Bank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bank] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bank] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bank] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Bank] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Bank]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccountNo] [nvarchar](22) NULL,
	[CustomerFK] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](200) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MobileNumbers]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileNumbers](
	[MobileNumberID] [int] IDENTITY(1,1) NOT NULL,
	[MobileNumber] [nvarchar](10) NULL,
	[CustomerFK] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_MobileNumbers] PRIMARY KEY CLUSTERED 
(
	[MobileNumberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NULL,
	[TransactionTypeFK] [int] NULL,
	[CustomerFK] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[RemainingBalance] [decimal](18, 2) NULL,
	[InitialDepositAmount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypes](
	[TransactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionName] [nvarchar](10) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_TransactionTypes] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (1, N'0000-0000-0000-0001
', 1, NULL, NULL)
INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (2, N'0000-0000-0000-0002', 2, NULL, NULL)
INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (3, N'0000-0000-0000-0003
', 3, NULL, NULL)
INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (4, N'0000-0000-0000-0004
', 4, NULL, NULL)
INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (5, N'0000-0000-0000-0005', 5, NULL, NULL)
INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (1039, N'0000000006', 1037, CAST(N'2020-01-29 17:53:22.103' AS DateTime), NULL)
INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (1042, N'0000000009', 1040, CAST(N'2020-01-30 19:36:51.600' AS DateTime), NULL)
INSERT [dbo].[Accounts] ([AccountId], [AccountNo], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (1043, N'0000000007', 1041, CAST(N'2020-01-30 21:25:37.747' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (1, N'Jose Rizal', NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (2, N'Andres Bonifacio
', NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (3, N'Apolinario Mabini
', NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (4, N'Gregorio Del Pilar
', NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (5, N'Manuel Quezon', NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (1037, N'Jaime William ', CAST(N'2020-01-29 17:53:21.540' AS DateTime), NULL)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (1040, N'Jaime William ', CAST(N'2020-01-30 19:36:51.570' AS DateTime), NULL)
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CreateDate], [UpdateDate]) VALUES (1041, N'Jaime Alzaga', CAST(N'2020-01-30 21:25:37.683' AS DateTime), CAST(N'2020-01-30 22:26:25.307' AS DateTime))
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[MobileNumbers] ON 

INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (2, N'9051234567', 1, NULL, NULL)
INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (3, N'9067654321', 2, NULL, NULL)
INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (4, N'9072345678', 3, NULL, NULL)
INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (5, N'9088765432', 4, NULL, NULL)
INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (6, N'9093456789', 5, NULL, NULL)
INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (42, N'9178390088', 39, CAST(N'2020-01-28 10:24:49.287' AS DateTime), NULL)
INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (1040, N'9178390011', 1041, CAST(N'2020-01-30 21:25:37.760' AS DateTime), CAST(N'2020-01-30 22:26:25.333' AS DateTime))
INSERT [dbo].[MobileNumbers] ([MobileNumberID], [MobileNumber], [CustomerFK], [CreateDate], [UpdateDate]) VALUES (1041, N'9178390012', 1041, CAST(N'2020-01-30 21:25:37.777' AS DateTime), CAST(N'2020-01-30 22:26:25.340' AS DateTime))
SET IDENTITY_INSERT [dbo].[MobileNumbers] OFF
SET IDENTITY_INSERT [dbo].[Transactions] ON 

INSERT [dbo].[Transactions] ([TransactionID], [Amount], [TransactionTypeFK], [CustomerFK], [CreateDate], [UpdateDate], [RemainingBalance], [InitialDepositAmount]) VALUES (1, CAST(10000.00 AS Decimal(18, 2)), 2, 1, CAST(N'2020-01-20 00:00:00.000' AS DateTime), CAST(N'2020-01-20 00:00:00.000' AS DateTime), CAST(50000.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[Transactions] ([TransactionID], [Amount], [TransactionTypeFK], [CustomerFK], [CreateDate], [UpdateDate], [RemainingBalance], [InitialDepositAmount]) VALUES (1037, NULL, 2, 1037, CAST(N'2020-01-29 17:53:22.127' AS DateTime), CAST(N'2020-01-29 17:53:22.127' AS DateTime), NULL, NULL)
INSERT [dbo].[Transactions] ([TransactionID], [Amount], [TransactionTypeFK], [CustomerFK], [CreateDate], [UpdateDate], [RemainingBalance], [InitialDepositAmount]) VALUES (1040, NULL, 2, 1040, CAST(N'2020-01-30 19:36:51.643' AS DateTime), CAST(N'2020-01-30 19:36:51.643' AS DateTime), NULL, NULL)
INSERT [dbo].[Transactions] ([TransactionID], [Amount], [TransactionTypeFK], [CustomerFK], [CreateDate], [UpdateDate], [RemainingBalance], [InitialDepositAmount]) VALUES (1041, CAST(80000.00 AS Decimal(18, 2)), 2, 1041, CAST(N'2020-01-30 21:25:37.787' AS DateTime), CAST(N'2020-01-30 21:25:37.787' AS DateTime), CAST(80000.00 AS Decimal(18, 2)), NULL)
SET IDENTITY_INSERT [dbo].[Transactions] OFF
SET IDENTITY_INSERT [dbo].[TransactionTypes] ON 

INSERT [dbo].[TransactionTypes] ([TransactionTypeID], [TransactionName], [CreateDate], [UpdateDate]) VALUES (1, N'Deposit', NULL, NULL)
INSERT [dbo].[TransactionTypes] ([TransactionTypeID], [TransactionName], [CreateDate], [UpdateDate]) VALUES (2, N'Withdrawal', NULL, NULL)
SET IDENTITY_INSERT [dbo].[TransactionTypes] OFF
/****** Object:  StoredProcedure [dbo].[ACM_List]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ACM_List]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT * FROM [Accounts]
	SELECT 
	AccountId,
     AccountNo,
	 CustomerName,
	 MobileNumber
  FROM Accounts
  INNER JOIN Customers ON CustomerID = CustomerFK
  INNER JOIN MobileNumbers ON Customers.CustomerID = MobileNumbers.CustomerFK
END

GO
/****** Object:  StoredProcedure [dbo].[EditAccount]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditAccount] 
	-- Add the parameters for the stored procedure here
	
	@AccountId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	 AccountId,
     AccountNo,
	 CustomerName,
	 MobileNumber
  FROM Accounts
  INNER JOIN Customers ON CustomerID = CustomerFK
  INNER JOIN MobileNumbers ON Customers.CustomerID = MobileNumbers.CustomerFK
  WHERE Accounts.AccountId = @AccountId
END

GO
/****** Object:  StoredProcedure [dbo].[ViewAccount]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewAccount] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@AccountId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
	 Accounts.AccountId,
     Accounts.AccountNo,
	 Customers.CustomerName,
	 Accounts.CreateDate
  FROM Accounts
  INNER JOIN Customers ON Accounts.CustomerFK = Customers.CustomerID
  WHERE Accounts.AccountId = @AccountId
END

GO
/****** Object:  StoredProcedure [dbo].[ViewTrans]    Script Date: 2/7/2020 8:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewTrans] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@AccountId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
	 Transactions.CreateDate,
	 TransactionTypes.TransactionName,
	 Transactions.Amount,
	 Transactions.RemainingBalance
  FROM Accounts
  INNER JOIN Customers ON Accounts.CustomerFK = Customers.CustomerID
  INNER JOIN Transactions ON Customers.CustomerID = Transactions.CustomerFK
  INNER JOIN TransactionTypes ON Transactions.TransactionTypeFK = TransactionTypes.TransactionTypeID
  WHERE Accounts.AccountId = @AccountId
END

GO
USE [master]
GO
ALTER DATABASE [Bank] SET  READ_WRITE 
GO
