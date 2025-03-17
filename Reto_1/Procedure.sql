-- PROCEDURE PARA REGISTRAR
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_REGISTRAR (
    p_idDistrito INT,
    p_nombre VARCHAR2,
    p_antiguedad INT,
    p_area DECIMAL,
    p_idSede INT,
    p_idGerente INT,
    p_idCondicion INT
) AS
    v_count INT;
BEGIN
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Hospital WHERE Nombre = p_nombre;
        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error: Ya existe un hospital con el nombre "' || p_nombre || '".');
        END IF;
        -- Validar si el distrito existe
        SELECT COUNT(*) INTO v_count FROM Distrito WHERE idDistrito = p_idDistrito;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error: El Distrito con ID ' || p_idDistrito || ' no existe.');
        END IF;
        -- Validar si la sede existe
        SELECT COUNT(*) INTO v_count FROM Sede WHERE idSede = p_idSede;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Error: La Sede con ID ' || p_idSede || ' no existe.');
        END IF;
        -- Validar si el gerente existe
        SELECT COUNT(*) INTO v_count FROM Gerente WHERE idGerente = p_idGerente;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Error: El Gerente con ID ' || p_idGerente || ' no existe.');
        END IF;
        -- Validar si la condicion existe
        SELECT COUNT(*) INTO v_count FROM Condicion WHERE idCondicion = p_idCondicion;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Error: La Condición con ID ' || p_idCondicion || ' no existe.');
        END IF;
        -- Si todo está bien, registrar el hospital
        INSERT INTO Hospital (idDistrito, Nombre, Antiguedad, Area, idSede, idGerente, idCondicion, fechaRegistro)
        VALUES (p_idDistrito, p_nombre, p_antiguedad, p_area, p_idSede, p_idGerente, p_idCondicion, SYSDATE);
    
        DBMS_OUTPUT.PUT_LINE('✅ Hospital "' || p_nombre || '" registrado correctamente.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('❌ Error: ' || SQLERRM);
    END;
END;

-- PROCEDURE PARA ACTUALIZAR
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_ACTUALIZAR (
    p_idHospital INT DEFAULT NULL,
    p_nombre VARCHAR2 DEFAULT NULL,
    p_idDistrito INT,
    p_nuevoNombre VARCHAR2,
    p_antiguedad INT,
    p_area DECIMAL,
    p_idSede INT,
    p_idGerente INT,
    p_idCondicion INT
) AS
    v_count INT;
BEGIN
    BEGIN
        IF p_idHospital IS NOT NULL THEN
            UPDATE Hospital
            SET idDistrito = p_idDistrito, Nombre = p_nuevoNombre, Antiguedad = p_antiguedad, Area = p_area,
                idSede = p_idSede, idGerente = p_idGerente, idCondicion = p_idCondicion, fechaRegistro = SYSDATE
            WHERE idHospital = p_idHospital;
            DBMS_OUTPUT.PUT_LINE('✅ Hospital con ID ' || p_idHospital || ' actualizado correctamente.');
        ELSIF p_nombre IS NOT NULL THEN
            SELECT COUNT(*) INTO v_count FROM Hospital WHERE Nombre = p_nombre;
            IF v_count = 0 THEN
                RAISE_APPLICATION_ERROR(-20006, 'Error: No se encontró un hospital con el nombre "' || p_nombre || '".');
            END IF;
            UPDATE Hospital
            SET idDistrito = p_idDistrito, Nombre = p_nuevoNombre, Antiguedad = p_antiguedad, Area = p_area,
                idSede = p_idSede, idGerente = p_idGerente, idCondicion = p_idCondicion, fechaRegistro = SYSDATE
            WHERE Nombre = p_nombre;
            DBMS_OUTPUT.PUT_LINE('✅ Hospital con nombre "' || p_nombre || '" actualizado correctamente.');
        ELSE
            RAISE_APPLICATION_ERROR(-20007, 'Error: Debe proporcionar un ID o un Nombre para actualizar un hospital.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('❌ Error: ' || SQLERRM);
    END;
END;

-- PROCEDURE PARA ELIMINAR
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_ELIMINAR (
    p_idHospital INT DEFAULT NULL,
    p_nombre VARCHAR2 DEFAULT NULL
) AS
    v_count INT;
BEGIN
    BEGIN
        IF p_idHospital IS NOT NULL THEN
            SELECT COUNT(*) INTO v_count FROM Hospital WHERE idHospital = p_idHospital;
            IF v_count = 0 THEN
                RAISE_APPLICATION_ERROR(-20008, 'Error: No se encontró un hospital con ID ' || p_idHospital);
            END IF;
            DELETE FROM Hospital WHERE idHospital = p_idHospital;
            DBMS_OUTPUT.PUT_LINE('✅ Hospital con ID ' || p_idHospital || ' eliminado exitosamente.');
        ELSIF p_nombre IS NOT NULL THEN
            SELECT COUNT(*) INTO v_count FROM Hospital WHERE Nombre = p_nombre;
            IF v_count = 0 THEN
                RAISE_APPLICATION_ERROR(-20009, 'Error: No se encontró un hospital con nombre "' || p_nombre || '".');
            END IF;
            DELETE FROM Hospital WHERE Nombre = p_nombre;
            DBMS_OUTPUT.PUT_LINE('✅ Hospital con nombre "' || p_nombre || '" eliminado exitosamente.');
        ELSE
            RAISE_APPLICATION_ERROR(-20010, 'Error: Debe proporcionar un ID o un Nombre para eliminar un hospital.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('❌ Error: ' || SQLERRM);
    END;
END;

-- PROCEDURE PARA LISTAR 
CREATE OR REPLACE PROCEDURE SP_HOSPITAL_LISTAR IS
    CURSOR hospital_cursor IS
        SELECT h.idHospital, h.Nombre, d.descDistrito, s.descSede, g.descGerente, c.descCondicion
        FROM Hospital h
        JOIN Distrito d ON h.idDistrito = d.idDistrito
        JOIN Sede s ON h.idSede = s.idSede
        JOIN Gerente g ON h.idGerente = g.idGerente
        JOIN Condicion c ON h.idCondicion = c.idCondicion;
    hospital_rec hospital_cursor%ROWTYPE;
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Hospital;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('⚠️ No hay hospitales registrados.');
        RETURN;
    END IF;

    OPEN hospital_cursor;
    LOOP
        FETCH hospital_cursor INTO hospital_rec;
        EXIT WHEN hospital_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(hospital_rec.idHospital || ' - ' || hospital_rec.Nombre || ' | ' || hospital_rec.descDistrito || ' | ' || hospital_rec.descSede || ' | ' || hospital_rec.descGerente || ' | ' || hospital_rec.descCondicion);
    END LOOP;
    CLOSE hospital_cursor;
END;