-------------------------------------------------------------------------------
--PARA PROBAR EL FUNCIONAMIENTO CREAMOS LA TABLA HOSPITAL
-------------------------------------------------------------------------------
CREATE TABLE Hospital (
    idHospital INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idDistrito INT,
    Nombre VARCHAR2(100),
    Antiguedad INT,
    Area NUMBER(10,2),
    idSede INT,
    idGerente INT,
    idCondicion INT,
    fechaRegistro DATE,
    FOREIGN KEY (idDistrito) REFERENCES Distrito(idDistrito),
    FOREIGN KEY (idSede) REFERENCES Sede(idSede),
    FOREIGN KEY (idGerente) REFERENCES Gerente(idGerente),
    FOREIGN KEY (idCondicion) REFERENCES Condicion(idCondicion)
);
-------------------------------------------------------------------------------
--PRUEBA PARA REGITRAR
BEGIN
    SP_HOSPITAL_REGISTRAR(1, 'Hospital Central', 10, 250.50, 1, 1, 1);
END;
--PRUEBA PARA ACTUALIZAR
BEGIN
    SP_HOSPITAL_ACTUALIZAR(
        --p_idHospital => 1,  -- ID del hospital a actualizar
        --p_nombre => NULL,    -- No se usa en este caso / Podemos colocar el nombre del hospital
        p_idDistrito => 2, 
        p_nuevoNombre => 'Hospital Nuevo Nombre 2',
        p_antiguedad => 15,
        p_area => 5000.50,
        p_idSede => 2,
        p_idGerente => 1,
        p_idCondicion => 2
    );
END;
--PRUEBAS PARA ELIMINAR
BEGIN
    SP_HOSPITAL_ELIMINAR(p_nombre => 'Hospital Central');
END;
BEGIN
    SP_HOSPITAL_ELIMINAR(p_idHospital => 1);
END;
--PRUEBAS PARA LISTAR
BEGIN
    SP_HOSPITAL_LISTAR;
END;