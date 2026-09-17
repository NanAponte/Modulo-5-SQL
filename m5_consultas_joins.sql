USE Ventas_Tech_DB

-- Consulta 1: Vista Base del Proyecto (Inner Join)

SELECT
    v.id_venta AS ID_Venta,
    v.fecha_venta AS Fecha,

-- Identificadores
c.id_cliente AS ID_Cliente,
c.nombre AS Cliente,
c.email AS Email_Cliente,
p.id_producto AS ID_Producto,
p.nombre_producto AS Producto,
cat.nombre_categoria AS Categoría,

-- Detalles de venta
v.cantidad AS Cantidad,
v.precio_unitario AS Precio_Unitario,
(v.cantidad * v.precio_unitario) AS Total_Venta

FROM ventas v
    INNER JOIN clientes c
        ON v.id_cliente = c.id_cliente
    INNER JOIN productos p
        ON v.id_producto = p.id_producto
    INNER JOIN categorias cat
        ON p.id_categoria = cat.id_categoria
ORDER BY
    v.fecha_venta DESC,
    v.id_venta;

--

-- Consulta 2: Clientes sin ventas (Left Join)

SELECT
    c.id_cliente AS ID_Cliente,
    c.nombre AS Cliente,
    c.email AS Email,
    c.fecha_registro AS Fecha_Registro,
    c.ciudad AS Ciudad,
COUNT(v.id_venta) AS Cantidad_Compras

FROM clientes c
    LEFT JOIN ventas v ON c.id_cliente = v.id_cliente

WHERE v.id_venta IS NULL

GROUP BY c.id_cliente, c.nombre, c.email, c.fecha_registro, c.ciudad

ORDER BY c.fecha_registro DESC;

-- Interpretación; Todos los clientes tienen ventas 

--

-- Consulta 3: Productos sin Ventas (Left Join)

SELECT
    p.id_producto AS ID_Producto,
    p.nombre_producto AS Producto,
    cat.nombre_categoria AS Categoría,
    p.precio AS Precio,
    COUNT(v.id_venta) AS Cantidad_Ventas

FROM productos p
    INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
    LEFT JOIN ventas v ON p.id_producto = v.id_producto

WHERE v.id_venta IS NULL

GROUP BY p.id_producto, p.nombre_producto, cat.nombre_categoria, p.precio

ORDER BY p.id_producto;

-- Interpretación: No hay productos sin ventas

--

-- Consulta 4: Consolidado por Canal (Union All)

SELECT
    'Online' AS Canal,
    COUNT(v.id_venta) AS Cantidad_Transacciones,
    SUM(v.cantidad) AS Cantidad_Unidades,
    SUM(v.cantidad * v.precio_unitario) AS Total_Facturado,
    AVG(v.cantidad * v.precio_unitario) AS Ticket_Promedio

FROM ventas v

-- Ventas en MARZO (mes 3) = Online
WHERE MONTH(v.fecha_venta) = 3

UNION ALL

SELECT
    'Presencial' AS Canal,
    COUNT(v.id_venta) AS Cantidad_Transacciones,
    SUM(v.cantidad) AS Cantidad_Unidades,
    SUM(v.cantidad * v.precio_unitario) AS Total_Facturado,
    AVG(v.cantidad * v.precio_unitario) AS Ticket_Promedio

FROM ventas v

-- Fin :) --