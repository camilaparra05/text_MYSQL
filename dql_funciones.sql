USE sakilacampus;
   

    -- 2. PromedioDuracionAlquiler(PeliculaID): Retorna la duración promedio de alquiler de una película específica. 
sql
Copiar
CREATE FUNCTION PromedioDuracionAlquiler(PeliculaID INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE promedio_duracion DECIMAL(10, 2);

    SELECT AVG(DATEDIFF(fecha_alquiler,devolucion_alquiler)) INTO promedio_duracion
    FROM alquiler 
    WHERE id_alquiler = id_pelicula;

    RETURN IFNULL(promedio_duracion, 0);
END;

 -- 3. IngresosPorCategoria(CategoriaID): Calcula los ingresos totales generados por una categoría específica de películas. 
sql
Copiar
CREATE FUNCTION IngresosPorCategoria(CategoriaID INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE ingresos_totales DECIMAL(10, 2);

    SELECT SUM(f.rental_rate) INTO ingresos_totales
    FROM categoria c
    JOIN pago p on c.id_categoria = p.id_pago
   WHERE c.id_categoria = p.id_pago;

    RETURN IFNULL(ingresos_totales, 0);
END;
    