USE [master]
GO

CREATE DATABASE [Inmobiliaria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Inmobiliaria', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Inmobiliaria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Inmobiliaria_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Inmobiliaria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Inmobiliaria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Inmobiliaria] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Inmobiliaria] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Inmobiliaria] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Inmobiliaria] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Inmobiliaria] SET ARITHABORT OFF 
GO

ALTER DATABASE [Inmobiliaria] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Inmobiliaria] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Inmobiliaria] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Inmobiliaria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Inmobiliaria] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Inmobiliaria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Inmobiliaria] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Inmobiliaria] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Inmobiliaria] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Inmobiliaria] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Inmobiliaria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Inmobiliaria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Inmobiliaria] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Inmobiliaria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Inmobiliaria] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Inmobiliaria] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Inmobiliaria] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Inmobiliaria] SET RECOVERY FULL 
GO

ALTER DATABASE [Inmobiliaria] SET  MULTI_USER 
GO

ALTER DATABASE [Inmobiliaria] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Inmobiliaria] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Inmobiliaria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Inmobiliaria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Inmobiliaria] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Inmobiliaria] SET QUERY_STORE = OFF
GO

ALTER DATABASE [Inmobiliaria] SET  READ_WRITE 
GO
USE [Inmobiliaria]
go
CREATE TABLE [t001_ventas] (
  [f001_ref_venta] int PRIMARY KEY,
  [f001_ts_alta] datetime,
  [f001_divisa] nvarchar(255),
  [f001_precio_venta] money,
  [f001_operacion] nvarchar(255),
  [f001_tipo_inmueble] nvarchar(255),
  [f001_superficie] nvarchar(255),
  [f001_ts_venta] datetime,
  [f001_id_vendedor] int,
  [f001_cedula_cliente] int,
  [f001_pais] nvarchar(255),
  [f001_provincia] nvarchar(255),
  [f001_ciudad] nvarchar(255)
)
GO

CREATE TABLE [t002_vendedores] (
  [f002_id] int PRIMARY KEY,
  [f002_nombre] nvarchar(255),
  [f002_correo] nvarchar(255),
  [f002_cedula] int UNIQUE NOT NULL,
  [f002_telefono] nvarchar(255)
)
GO

CREATE TABLE [t003_clientes] (
  [f003_cedula] int PRIMARY KEY,
  [f003_nombre] nvarchar(255),
  [f003_correo] nvarchar(255) UNIQUE NOT NULL,
  [f003_telefono] nvarchar(255)
)
GO

CREATE INDEX [f001_ref_venta_index] ON [t001_ventas] ("f001_ref_venta")
GO

CREATE INDEX [f002_id_index] ON [t002_vendedores] ("f002_id")
GO

CREATE INDEX [f003_cedula_index] ON [t003_clientes] ("f003_cedula")
GO

ALTER TABLE [t001_ventas] ADD FOREIGN KEY ([f001_id_vendedor]) REFERENCES [t002_vendedores] ([f002_id])
GO

ALTER TABLE [t001_ventas] ADD FOREIGN KEY ([f001_cedula_cliente]) REFERENCES [t003_clientes] ([f003_cedula])
GO
