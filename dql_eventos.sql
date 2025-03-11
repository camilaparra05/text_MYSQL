-- 1
Genera un informe mensual de alquileres y lo almacena automáticamente en una tabla monthly_rental_report.
create table reporte_mensual (
id_reporte int primary key ,
total_alquiler int,
total_ingresos decimal);

CREATE EVENT AlquileresMensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    INSERT INTO reporte_mensual (id_reporte ,total_alquiler,total_ingresos )
    SELECT CURDATE(), COUNT(*), SUM(f.rental_rate)
    FROM alquiler a
    JOIN cliente c ON c.id_cliente = a.id_cliente
    WHERE MONTH(total_alquiler) = MONTH(CURDATE()) AND YEAR(total_alquiler) = YEAR(CURDATE());
END;

2. ActualizarSaldoPendienteCliente
Actualiza los saldos pendientes de los clientes al final de cada mes. Este evento podría sumar o restar los pagos de alquiler realizados por los clientes.

CREATE EVENT Saldo_pendiente
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    UPDATE cliente c
    JOIN alquiler a a ON c.id_cliente = a.cliente
    JOIN pelicula p  ON a.id_pelicula = p.id_pelicula
    join pago p2 on p2.id_cliente= c.id_cliente
    SET c.total = c.total 
    WHERE c.total = c.total 
    END 
    
-- 3.Envía una alerta cuando una película no ha sido alquilada en el último año. Esto puede ser un simple informe que se inserte en una tabla de alertas.

CREATE TABLE alerta (
    alerta_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_allerta VARCHAR(255),
    id_pelicula INT,
  mensage VARCHAR(255),
   
); 

CREATE EVENT PeliculasNoAlquiladas
ON SCHEDULE EVERY 1 DAY
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    INSERT INTO alerta (alert_type, tipo_allerta, id_pelicula,mensage)
    SELECT 'No alquilada', p.id_pelicula, CONCAT('La película "', p.titulo, '" no ha sido alquilada en el último año'), NOW()
    FROM pelicula p
    LEFT JOIN alquiler a ON  a.id_pelicula = p.id_pelicula
    WHERE a. id_alquiler IS NULL OR  < CURDATE() - INTERVAL 1 YEAR;
   END 
