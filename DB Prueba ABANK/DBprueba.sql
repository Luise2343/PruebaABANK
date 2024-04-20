CREATE DATABASE PruebaTecnica;
\c PruebaTecnica
CREATE TABLE Usuarios (
    Id SERIAL PRIMARY KEY,
    Usuario VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Estado VARCHAR(20),
    IdEmpleado INT,
    Fechacreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Fechamodificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Empleados (
    Id SERIAL PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Correo VARCHAR(100),
    FechaContratacion DATE,
    IdArea INT,
    Fechacreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Fechamodificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Departamento (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Fechacreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Fechamodificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Usuarios
ADD CONSTRAINT fk_usuario_empleado FOREIGN KEY (IdEmpleado)
REFERENCES Empleados(Id);

ALTER TABLE Empleados
ADD CONSTRAINT fk_empleado_departamento FOREIGN KEY (IdArea)
REFERENCES Departamento(Id);

INSERT INTO Usuarios (Usuario, Password, Estado, IdEmpleado)
VALUES
    ('usuario1', 'password1', 'activo', 1),
    ('usuario2', 'password2', 'activo', 2),
    ('usuario3', 'password3', 'activo', 3),
    ('usuario4', 'password4', 'activo', 4),
    ('usuario5', 'password5', 'activo', 5),
    ('usuario6', 'password6', 'activo', 6),
    ('usuario7', 'password7', 'activo', 7),
    ('usuario8', 'password8', 'activo', 8),
    ('usuario9', 'password9', 'activo', 9),
    ('usuario10', 'password10', 'activo', 10),
    ('usuario11', 'password11', 'activo', 11),
    ('usuario12', 'password12', 'activo', 12),
    ('usuario13', 'password13', 'activo', 13),
    ('usuario14', 'password14', 'activo', 14),
    ('usuario15', 'password15', 'activo', 15);


INSERT INTO Empleados (Nombres, Apellidos, Telefono, Correo, FechaContratacion, IdArea)
VALUES
    ('Juan', 'González', '123456789', 'juan.gonzalez@example.com', '2023-01-15', 1),
    ('María', 'López', '987654321', 'maria.lopez@example.com', '2022-05-20', 2),
    ('Pedro', 'Martínez', '555555555', 'pedro.martinez@example.com', '2022-03-10', 1),
    ('Ana', 'Rodríguez', '333333333', 'ana.rodriguez@example.com', '2023-02-28', 3),
    ('Carlos', 'Sánchez', '999999999', 'carlos.sanchez@example.com', '2022-07-01', 2),
    ('Laura', 'García', '777777777', 'laura.garcia@example.com', '2023-04-05', 1),
    ('Diego', 'Hernández', '111111111', 'diego.hernandez@example.com', '2022-09-15', 3),
    ('Sofía', 'Díaz', '888888888', 'sofia.diaz@example.com', '2022-11-20', 2),
    ('Elena', 'Pérez', '444444444', 'elena.perez@example.com', '2023-03-10', 1),
    ('Javier', 'Torres', '666666666', 'javier.torres@example.com', '2022-08-12', 3),
    ('Lucía', 'Fernández', '222222222', 'lucia.fernandez@example.com', '2023-05-18', 2),
    ('Miguel', 'Ruiz', '123123123', 'miguel.ruiz@example.com', '2022-06-25', 1),
    ('Paula', 'Santos', '456456456', 'paula.santos@example.com', '2022-10-30', 3),
    ('Andrés', 'Morales', '789789789', 'andres.morales@example.com', '2023-01-05', 1),
    ('Valeria', 'Ortega', '987654321', 'valeria.ortega@example.com', '2022-04-15', 2);

INSERT INTO Departamento (Nombre)
VALUES
    ('Ventas'),
    ('Recursos Humanos'),
    ('Tecnología');

SELECT * FROM Departamento;
SELECT * FROM Empleados;
SELECT * FROM Usuarios;


CREATE OR REPLACE PROCEDURE CrearEmpleado(
    p_Nombres VARCHAR(100),
    p_Apellidos VARCHAR(100),
    p_Telefono VARCHAR(20),
    p_Correo VARCHAR(100),
    p_FechaContratacion DATE,
    p_IdArea INT
)
AS $$
BEGIN
    INSERT INTO Empleados (Nombres, Apellidos, Telefono, Correo, FechaContratacion, IdArea)
    VALUES (p_Nombres, p_Apellidos, p_Telefono, p_Correo, p_FechaContratacion, p_IdArea);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE EditarEmpleado(
    p_Id INT,
    p_Nombres VARCHAR(100),
    p_Apellidos VARCHAR(100),
    p_Telefono VARCHAR(20),
    p_Correo VARCHAR(100),
    p_FechaContratacion DATE,
    p_IdArea INT
)
AS $$
BEGIN
    UPDATE Empleados 
    SET 
        Nombres = p_Nombres,
        Apellidos = p_Apellidos,
        Telefono = p_Telefono,
        Correo = p_Correo,
        FechaContratacion = p_FechaContratacion,
        IdArea = p_IdArea
    WHERE Id = p_Id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE EliminarEmpleado(
    p_Id INT
)
AS $$
BEGIN
    
    DELETE FROM Usuarios WHERE IdEmpleado = p_Id;
    DELETE FROM Empleados WHERE Id = p_Id;
END;
$$ LANGUAGE plpgsql;


-- Llamada al procedimiento para crear un nuevo empleado
CALL CrearEmpleado('Juan', 'Pérez', '123456789', 'juan@example.com', '2024-04-19', 1);
-- Llamada al procedimiento para editar un empleado existente
CALL EditarEmpleado(1, 'Pedro', 'Gómez1', '987654321', 'pedro@example.com', '2024-04-20', 2);
-- Llamada al procedimiento para eliminar un empleado existente
CALL EliminarEmpleado(1);

