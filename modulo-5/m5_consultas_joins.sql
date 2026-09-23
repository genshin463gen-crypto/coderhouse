USE Ventas_Tech_DB;
GO

-- Consulta 1: Vista base del proyecto (INNER JOIN)
SELECT 
    v.fecha_venta AS fecha,
    v.id_cliente,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    cl.ciudad,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes cl ON v.id_cliente = cl.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
SELECT 
    cl.nombre,
    cl.email,
    cl.fecha_registro
FROM clientes cl
LEFT JOIN ventas v ON cl.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
-- Consulta 3: Productos sin ventas (LEFT JOIN)
SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
-- Consulta 4: Consolidado por canal (UNION ALL)
-- El "canal" no existe en el esquema: se genera como valor literal,usando la ciudad del cliente como criterio de separación.
SELECT 
    canal,
    SUM(total) AS total_facturado
FROM (
    SELECT 
        v.cantidad * v.precio_unitario AS total,
        'Buenos Aires' AS canal
    FROM ventas v
    INNER JOIN clientes cl ON v.id_cliente = cl.id_cliente
    WHERE cl.ciudad = 'Buenos Aires'

    UNION ALL

    SELECT 
        v.cantidad * v.precio_unitario AS total,
        'Interior' AS canal
    FROM ventas v
    INNER JOIN clientes cl ON v.id_cliente = cl.id_cliente
    WHERE cl.ciudad <> 'Buenos Aires'
) AS consolidado
GROUP BY canal;
