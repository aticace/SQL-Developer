USE [Inmobiliaria]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[f_convertir_USD](@p_precio money, @p_divisa varchar(10))
RETURNS money   
AS   
BEGIN  
    DECLARE @v_precio_calc money
	set @v_precio_calc = 0

    if @p_divisa = '£' 
	begin
		set @v_precio_calc = @p_precio  * 1.32
	end
	else if @p_divisa = '¥' 
	begin 
		set @v_precio_calc = @p_precio  * 0.0083
	end
	else if @p_divisa = '€' 
	begin 
		set @v_precio_calc = @p_precio  * 1.1
	end
	else if @p_divisa = '$' 
	begin 
		set @v_precio_calc = @p_precio  * 1
	end
	else if @p_divisa = 'Kr' 
	begin 
		set @v_precio_calc = @p_precio  * 0.11
	end
	else if @p_divisa = 'Fr' 
	begin 
		set @v_precio_calc = @p_precio  * 1.07
	end
	else if @p_divisa = '₩' 
	begin 
		set @v_precio_calc = @p_precio  * 0.00082
	end
	else
	begin
		set @v_precio_calc = @p_precio
	end
    RETURN @v_precio_calc
END 

GO
