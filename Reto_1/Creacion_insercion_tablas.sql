-- CREACION DE TABLAS
CREATE TABLE Gerente (
    idGerente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descGerente VARCHAR2(100),
    fechaRegistro DATE
);

CREATE TABLE Condicion (
    idCondicion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descCondicion VARCHAR2(100),
    fechaRegistro DATE
);

CREATE TABLE Provincia (
    idProvincia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descProvincia VARCHAR2(100),
    fechaRegistro DATE
);

CREATE TABLE Distrito (
    idDistrito INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idProvincia INT,
    descDistrito VARCHAR2(100),
    fechaRegistro DATE,
    FOREIGN KEY (idProvincia) REFERENCES Provincia(idProvincia)
);

CREATE TABLE Sede (
    idSede INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descSede VARCHAR2(100),
    fechaRegistro DATE
);

-- INSERCION DE REGISTROS
INSERT INTO Gerente (descGerente, fechaRegistro) VALUES ('Gerente Adminitracion', SYSDATE);
INSERT INTO Gerente (descGerente, fechaRegistro) VALUES ('Gerente Sistemas', SYSDATE);

INSERT INTO Condicion (descCondicion, fechaRegistro) VALUES ('Condicion A', SYSDATE);
INSERT INTO Condicion (descCondicion, fechaRegistro) VALUES ('Condicion B', SYSDATE);

INSERT INTO Provincia (descProvincia, fechaRegistro) VALUES ('Huancayo', SYSDATE);
INSERT INTO Provincia (descProvincia, fechaRegistro) VALUES ('Lima', SYSDATE);

INSERT INTO Distrito (idProvincia, descDistrito, fechaRegistro) VALUES (1, 'El tambo', SYSDATE);
INSERT INTO Distrito (idProvincia, descDistrito, fechaRegistro) VALUES (2, 'La Victoria', SYSDATE);

INSERT INTO Sede (descSede, fechaRegistro) VALUES ('Sede Central', SYSDATE);
INSERT INTO Sede (descSede, fechaRegistro) VALUES ('Sucursal', SYSDATE);