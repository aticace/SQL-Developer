USE [Inmobiliaria]
GO

/****** Object:  StoredProcedure [dbo].[sp_reporte]    Script Date: 02/06/2022 18:39:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER   PROCEDURE [dbo].[sp_reporte](@p_fecha_ini date, @p_fecha_fin date)
AS   
	set dateformat 'DMY'
	set nocount on

	select
		upper(left(datename(month,f001_ts_venta),3))+right(cast(datepart(year,f001_ts_venta) as varchar(4)),2) "MES/Año"
		,f001_tipo_inmueble "Tipo de inmueble"
		,f001_pais "País"
		,sum(case f001_operacion when 'Venta' then dbo.f_convertir_USD(f001_precio_venta,f001_divisa) else 0 end) "Suma venta en US"
		,sum(case f001_operacion when 'Alquiler' then dbo.f_convertir_USD(f001_precio_venta,f001_divisa) else 0 end) "Suma Alquiler en US"
		,avg(case f001_operacion when 'Venta' then dbo.f_convertir_USD(f001_precio_venta,f001_divisa) else 0 end) "Promedio venta en US"
		,avg(case f001_operacion when 'Alquiler' then dbo.f_convertir_USD(f001_precio_venta,f001_divisa) else 0 end) "Promedio Alquiler en US"
		,sum(case f001_operacion when 'Venta' then 1 else 0 end) "Unidades Vendidas"
		,sum(case f001_operacion when 'Alquiler' then 1 else 0 end) "Unidades Alquiladas"
	from t001_ventas
	where f001_ts_venta is not null
	and f001_ts_venta between @p_fecha_ini and @p_fecha_fin
	group by upper(left(datename(month,f001_ts_venta),3))+right(cast(datepart(year,f001_ts_venta) as varchar(4)),2)
		,f001_tipo_inmueble
		,f001_pais
GO


