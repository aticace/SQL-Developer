USE [Inmobiliaria]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[sp_actualizar_tablas]
AS
	set dateformat 'DMY'
	merge t003_clientes as target
	using(
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
			,left([telefono comprador],255)) as source
		on (target.f003_cedula = source.cedula)
	when matched and target.f003_nombre <> source.comprador 
					or target.f003_correo <> source.correo
					or target.f003_telefono <> source.telefono then
		update set target.f003_nombre = source.comprador
				   ,target.f003_correo = source.correo
				   ,target.f003_telefono = source.telefono
	when not matched by target then
		insert (
			f003_cedula
			,f003_nombre
			,f003_correo
			,f003_telefono
		)values(
			source.cedula
			,source.comprador
			,source.correo
			,source.telefono
		);

	merge t002_vendedores as target
	using(
		select
			cast([id vendedor] as int) id
			,cast([cedula vendedor] as int) cedula_vend
			,left([vendedor],255) vendedor
			,left([correo vendedor],255) correo_vend
			,left([telefono vendedor],255) tel_vend
		from tbImporteManual
		where [id vendedor] is not null
		group by cast([id vendedor] as int)
			,cast([cedula vendedor] as int)
			,left([vendedor],255)
			,left([correo vendedor],255)
			,left([telefono vendedor],255)) as source
		on (target.f002_id = source.id)
	when matched and target.f002_nombre <> source.vendedor 
					or target.f002_correo <> source.correo_vend
					or target.f002_telefono <> source.tel_vend then
		update set target.f002_nombre = source.vendedor
				   ,target.f002_correo = source.correo_vend
				   ,target.f002_telefono = source.tel_vend
	when not matched by target then
		insert(
			f002_id
			,f002_cedula
			,f002_nombre
			,f002_correo
			,f002_telefono
		)values(
			source.id
			,source.cedula_vend
			,source.vendedor
			,source.correo_vend
			,source.tel_vend
		);

	merge t001_ventas as target
	using(
		select
			cast([Referencia Venta] as int) ref_venta
			,cast([Fecha y hora Alta] as datetime) ts_alta
			,left([Divisa],10) divisa
			,cast(ltrim(rtrim(substring([Precio Venta],3,255))) as money) precio
			,left([Operación],255) operacion
			,left([Tipo Inmueble],255) tipo_inmueble
			,left([Superficie],255) superficie
			,case when isdate([Fecha Venta]) = 1 then cast([Fecha Venta] as date) else cast(null as date) end ts_venta
			,cast([Id Vendedor] as int) id_vend
			,cast([cedula comprador] as int) cedula_cli
			,left([Pais],255)	pais
			,left([Provincia],255) provincia
			,left([Ciudad],255) ciudad
		from tbImporteManual) as source
		on (target.f001_ref_venta = source.ref_venta)
	when not matched by target then
		insert(
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
		)values(
			source.ref_venta
			,source.ts_alta
			,source.divisa
			,source.precio
			,source.operacion
			,source.tipo_inmueble
			,source.superficie
			,source.ts_venta
			,source.id_vend
			,source.cedula_cli
			,source.pais
			,source.provincia
			,source.ciudad
		);
GO
