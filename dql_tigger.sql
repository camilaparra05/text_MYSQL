-- 1
CREATE TRIGGER Actualizar_alquileres
AFTER INSERT ON alquiler
FOR EACH ROW
BEGIN
    UPDATE empleados
    SET id_alquiler = id_alquiler + 1
    WHERE id_empleado= NEW.id_empleado;
END;
-- 2

CREATE TABLE actualizar_cliente (
   id_actualizacion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
   nombre_anterior VARCHAR(255),
   apellido_anterior VARCHAR(255),
   nombre_nuevo VARCHAR(255),
   apellido_nuevo VARCHAR(100),
); 

CREATE TRIGGER Actualizacion_cliente
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO actualizar_cliente( id_actualizacion,id_cliente ,nombre_anterior ,apellido_anterior ,nombre_nuevo, apellido_nuevo )
    VALUES (OLD.id_cliente, OLD.nombre, OLD.apellidos, NEW.nombre, NEW.apellidos, NOW());
END;

-- 3.

CREATE TABLE historial (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_pelicula INT,
    antiguo_alqulier DECIMAL(5, 2),
    viejo_alquiler DECIMAL(5, 2),
);
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede realizar un alquiler, el cliente tiene saldo pendiente.';
    END IF;
END;

CREATE TRIGGER Registrar_historial
AFTER UPDATE ON pelicula
FOR EACH ROW
BEGIN
    IF OLD.rental_rate != NEW.rental_rate THEN
        INSERT INTO historial ( id_historial,id_pelicula ,antiguo_alqulier,viejo_alquiler )
        VALUES (NEW.id_pelicula, OLD.rental_rate, NEW.rental_rate, NOW());
    END IF;
   SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede realizar un alquiler, el cliente tiene saldo pendiente.';
    END IF;
END;



-- 4 
CREATE TABLE notificar_al_eliminacionar (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
   id_alquiler INT,
    id_cliente INT,
    eliminacion VARCHAR(255),
    not_eliminacion DATETIME
); 
CREATE TRIGGER notificar_al_eliminacionar
AFTER DELETE ON alquiler
FOR EACH ROW
BEGIN
    INSERT INTO deletion_notifications ( id_notificacion ,id_alquiler id_cliente ,eliminacion,not_eliminacion)
    VALUES (OLD.id_alquiler, OLD.id_cliente, 'Alquiler eliminado', NOW());
END;


-- 5
CREATE TRIGGER alquiler_con_saldo_pendiente
BEFORE INSERT ON alquiler
FOR EACH ROW
BEGIN
    DECLARE saldo_pendiente DECIMAL(10, 2);

    
    SELECT id_cliente INTO saldo_pendient
    FROM  pago
    WHERE id_cliente = NEW.id_cliente;

    IF saldo_pendiente > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede realizar un alquiler, el cliente tiene saldo pendiente.';
    END IF;
END;
