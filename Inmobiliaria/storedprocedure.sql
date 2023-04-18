USE [Inmobiliaria]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[sp_llenar_tablas]
AS   
	set dateformat 'DMY'
	insert into t003_clientes(
		f003_cedula
		,f003_nombre
		,f003_correo
		,f003_telefono
	)
	select
		cast([cedula comprador] as int) cedula
		,left([comprador],255) comprador
		,left([correo comprador],255) correo
		,left([telefono comprador],255) telefono
	from tbImporteManual
	where [cedula comprador] is not null
	group by cast([cedula comprador] as int)
		,left([comprador],255)
		,left([correo comprador],255)
		,left([telefono comprador],255)

	insert into t002_vendedores(
		f002_id
		,f002_cedula
		,f002_nombre
		,f002_correo
		,f002_telefono
	)
	select
		cast([id vendedor] as int)
		,cast([cedula vendedor] as int)
		,left([vendedor],255)
		,left([correo vendedor],255)
		,left([telefono vendedor],255)
	from tbImporteManual
	where [id vendedor] is not null
	group by cast([id vendedor] as int)
		,cast([cedula vendedor] as int)
		,left([vendedor],255)
		,left([correo vendedor],255)
		,left([telefono vendedor],255)

	insert into t001_ventas(
		f001_ref_venta
		,f001_ts_alta
		,f001_divisa
		,f001_precio_venta
		,f001_operacion
		,f001_tipo_inmueble
		,f001_superficie
		,f001_ts_venta
		,f001_id_vendedor
		,f001_cedula_cliente
		,f001_pais
		,f001_provincia
		,f001_ciudad
	)
	select
		cast([Referencia Venta] as int)
		,cast([Fecha y hora Alta] as datetime)
		,left([Divisa],10)
		,cast(ltrim(rtrim(substring([Precio Venta],3,255))) as money)
		,left([Operación],255)
		,left([Tipo Inmueble],255)
		,left([Superficie],255)
		,case when isdate([Fecha Venta]) = 1 then cast([Fecha Venta] as date) else cast(null as date) end
		,cast([Id Vendedor] as int) "[Id Vendedor]"
		,cast([cedula comprador] as int)
		,left([Pais],255)
		,left([Provincia],255)
		,left([Ciudad],255)
	from tbImporteManual
GO


