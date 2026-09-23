
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Ventas_Tech_DB')
CREATE DATABASE Ventas_Tech_DB;
GO

USE Ventas_Tech_DB;
GO

DROP TABLE IF EXISTS ventas;          
DROP TABLE IF EXISTS productos;       
DROP TABLE IF EXISTS clientes;        
DROP TABLE IF EXISTS categorias;   

CREATE TABLE categorias (
	id_categoria INT PRIMARY KEY,
	nombre_categoria VARCHAR(50) NOT NULL,
	descripcion VARCHAR(200)
);

CREATE TABLE clientes (
	id_cliente INT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE,
	ciudad VARCHAR(50),
	fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
	id_producto INT PRIMARY KEY,
	nombre_producto VARCHAR(100) NOT NULL,
	id_categoria INT NOT NULL,
	precio DECIMAL(10, 2) NOT NULL,
	stock INT DEFAULT 0,
	activo TINYINT DEFAULT 1,
	FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
	id_venta INT PRIMARY KEY,
	id_cliente INT NOT NULL,
	id_producto INT NOT NULL,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(10, 2) NOT NULL,
	fecha_venta DATE NOT NULL,
		FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
		FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
	INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
		INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
			INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

SELECT * 
	FROM categorias;

INSERT INTO clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
	INSERT INTO clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
		INSERT INTO clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
			INSERT INTO clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
				INSERT INTO clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

SELECT * 
	FROM clientes;

	INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
		INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
			INSERT INTO productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
				INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
					INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
						INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);

SELECT * 
	FROM productos;

INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
	INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
		INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
			INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
				INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
					INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
						INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
							INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
								INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
									INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');

SELECT * 
	FROM ventas;

SELECT 'CATEGORIAS' AS Tabla, COUNT(*) AS Total_Registros FROM categorias
UNION ALL
SELECT 'CLIENTES', COUNT(*) FROM clientes
UNION ALL
SELECT 'PRODUCTOS', COUNT(*) FROM productos
UNION ALL
SELECT 'VENTAS', COUNT(*) FROM ventas;

SELECT
	v.id_venta,
	c.nombre AS Cliente,
	p.nombre_producto AS Producto,
	v.cantidad,
	v.precio_unitario,
	v.fecha_venta
		FROM ventas v
			JOIN clientes c ON v.id_cliente = c.id_cliente
			JOIN productos p ON v.id_producto = p.id_producto
				ORDER BY v.fecha_venta;

SELECT
	p.id_producto,
	p.nombre_producto,
	cat.nombre_categoria,
	p.precio
		FROM productos p
			JOIN categorias cat ON p.id_categoria = cat.id_categoria
				ORDER BY cat.nombre_categoria;

