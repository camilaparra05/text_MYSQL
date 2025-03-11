USE sakilacampus;
 -- 1. Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses. 

select id_cliente, count(*)
from alquiler 
WHERE fecha_alquiler >= CURDATE() - INTERVAL 6 MONTH 
GROUP  by id_cliente 
order BY id_cliente  DESC
limit 1;

-- 2. Lista las cinco películas más alquiladas durante el último año. 

SELECT titulo , COUNT(*) AS cantidad_alquileres
FROM pelicula  
WHERE renta_rate  >= CURDATE() - INTERVAL 1 YEAR
ORDER BY cantidad_alquileres DESC
LIMIT 5;


-- 3. Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película. 

SELECT i.id_inventario , SUM() AS total_ingresos, COUNT(a.id_alquiler) AS cantidad_alquileres
FROM inventario i  
JOIN alquiler a  ON a.id_inventario = i.id_inventario 
JOIN pelicula p2  ON p2.id_pelicula = i.id_pelicula ;


-- 4. Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico. 

select idioma.nombre as idioma count(DISTINCT id_cliente) as total_clientes
from alquiler a
join cliente c on c.id_cliente = a.id_cliente 
join inventario i on a.id_inventario = i.id_inventario 
join pelicula p on i.id_pelicula = p.id_pelicula 
join idioma i2 on p.id_idioma = i2.id_idioma 
where MONTH  (a.fecha_alquiler ) = MONTH (CURDATE()
GROUP by i2.nombre 

-- 5
    
    
    SELECT p.claificacion as categoria , conut (a.id_alquiler) as total_alquiler
    from alquiler a
    join pelicula p on p.id_pelicula= a.
j.in inventario i on i.id_pelicula  = p.id_pelicula
    where a.fecha_alquiler  >= DATE_SUB(), INTERVAL 1 YEAR )
    group by  p.clasificacion 
    