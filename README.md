# RetailPro — Proyecto Data Analyst (Coderhouse)

Repositorio del proyecto integrador del curso Data Analyst. Contiene la base de
datos Ventas_Tech_DB (caso de práctica de ventas de tecnología), las consultas
SQL, el pipeline ETL en Power BI y el modelo analítico con medidas DAX,
construidos módulo a módulo sobre esa base.

## Herramienta y sintaxis

Los scripts SQL están escritos en T-SQL (SQL Server), probados en SQL Server
Management Studio (SSMS). El modelo y las medidas están construidos en Power BI
Desktop. No usar sintaxis de MySQL/PostgreSQL (por ejemplo MONTH() en vez de
EXTRACT(), TOP en vez de LIMIT).

## Estructura y orden de ejecución

modulo-3/  -> Creación de la base y carga inicial (correr primero)
modulo-4/  -> Consultas de agregación sobre modulo-3
modulo-5/  -> Consultas con JOIN sobre modulo-3
modulo-6/  -> Pipeline ETL en Power Query (.pbix)
modulo-7/  -> Boceto del dashboard
modulo-8/  -> Modelo de datos y medidas DAX (.pbix)

modulo-3 debe ejecutarse antes que modulo-4 y modulo-5, ya que crea las tablas
que esas consultas usan.
