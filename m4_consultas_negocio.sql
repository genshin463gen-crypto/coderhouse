USE Ventas_Tech_DB;
GO
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;--
-- consulta 1:
USE Ventas_Tech_DB;
GO

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
-- Consulta 2:
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
-- Consulta 3: Clientes recurrentes
-- Clientes con más de un pedido, cantidad de pedidos y total gastado
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;
-- Consulta 4: Meses por encima/por debajo del promedio
-- Total facturado por mes, comparado contra el promedio general de todos los meses
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT AVG(total_mes) 
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mes
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS totales_por_mes
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
-- =========================================================
-- Hallazgos
-- =========================================================
-- 1. Todas las ventas registradas corresponden al mes 3 (marzo), por lo que la comparación contra el promedio mensual (Consulta 4) todavía no es posible. Al haber un solo mes, su total es igual al promedio  y nunca puede superarlo, por eso figura "Por debajo".
-- 2. El producto 1 lidera la facturación con $3.600 pese a vender solo 3 unidades, mientras que el producto 2 vendió 13 unidades pero generó apenas $364, por ser el más barato del catálogo ($28). Esto muestra que el ranking por facturación no siempre coincide con el ranking por volumen de ventas.
-- 3. Los 5 clientes cargados registran exactamente 2 pedidos cada uno, por lo que el 100% de la base actual cumple la condición de "cliente recurrente" (más de 1 pedido). 
  