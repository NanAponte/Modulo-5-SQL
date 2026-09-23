USE Ventas_Tech_DB;
GO
-- Resumen Ejecutivo Mensual
SELECT
	MONTH(fecha_venta) AS Mes,
	COUNT(*) AS Total_Pedidos,
	SUM(cantidad * precio_unitario) AS Total_Facturado,
	AVG(cantidad * precio_unitario) AS Ticket_Promedio
FROM ventas
	GROUP BY MONTH(fecha_venta)
	ORDER BY Mes;

-- Ranking 5 Productos
SELECT TOP 5
	id_producto AS ID_Producto,
	SUM(cantidad) AS Unidades_Vendidas,
	SUM(cantidad * precio_unitario) AS Total_Facturado
FROM ventas
	GROUP BY id_producto
	ORDER BY Total_Facturado DESC;

-- Clientes Recurrentes
SELECT
	id_cliente AS ID_Cliente,
	COUNT(*) AS Cantidad_Pedidos,
	SUM(cantidad * precio_unitario) AS Total_Gastado
FROM ventas
	GROUP BY id_cliente
	HAVING COUNT(*) > 1
	ORDER BY Total_Gastado DESC;

-- Meses Arriba/Abajo del Promedio
WITH ventas_mensuales AS (
    SELECT
        MONTH(fecha_venta) AS Mes,
        SUM(cantidad * precio_unitario) AS Total_Facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
promedio_general AS (
    SELECT
        AVG(Total_Facturado) AS Promedio_Mensual
    FROM ventas_mensuales
)
SELECT
    vm.Mes,
    vm.Total_Facturado,
    pg.Promedio_Mensual,
    CASE
        WHEN vm.Total_Facturado > pg.Promedio_Mensual THEN 'Por encima'
        WHEN vm.Total_Facturado < pg.Promedio_Mensual THEN 'Por debajo'
        ELSE 'En promedio'
    END AS Performance
FROM ventas_mensuales vm
CROSS JOIN promedio_general pg
ORDER BY vm.Mes;

-- Hallazgos
	-- El Producto 1 (Laptop Pro 15) concentra el 59.1% de la facturación total de marzo ($3,600 de $6,084 en los top 5).
	-- El Top 3 de productos (1, 3, 5) genera el 79.2% de la facturación en los 5 primeros, mientras que los últimos 2 (6 y 2) generan apenas el 20.8%.
	-- El Cliente 1 concentra el 44.3% del gasto total ($2,640 de $5,944), y los Top 2 clientes representan el 78% de los ingresos.
