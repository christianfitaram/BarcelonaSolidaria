USE BcnSolDB;
CREATE TABLE [Usuario] (
	idUsuario int IDENTITY NOT NULL PRIMARY KEY,
	Nombre  varchar(15) NOT NULL,
	PrimerApellido varchar(20) NOT null,
	SegundoApellido varchar(20),
	FechaNacimiento date NOT NULL,
	Nacionalidad varchar(15) NOT null,
	NIF char(9),
	NumPasaporte char(10),
	PaisEmisionPas varchar(15),
	DireccionLinea1 varchar(100) NOT NULL,
	DireccionLinea2 varchar(50),
	Municipio varchar(50) NOT null,
	Comarca varchar(50) NOT null,
	Provincia varchar(15) NOT null,
	CodigoPostal char(5) NOT null,
	Email varchar(50) NOT null,
	NumMovil char(9) NOT null,
	FechaRegistro date NOT NULL,
	CONSTRAINT chk_NIF_or_NumPasaporte CHECK (
        (NIF IS NOT NULL AND NumPasaporte IS NULL) OR 
        (NIF IS NULL AND NumPasaporte IS NOT NULL) OR 
        (NIF IS NOT NULL AND NumPasaporte IS NOT NULL)
    ),
    CONSTRAINT chk_NumPasaporte_PaisEmisionPas CHECK (
        NumPasaporte IS NULL OR PaisEmisionPas IS NOT NULL
    )
);
GO

CREATE TABLE [EntidadIntermedia](
    idEntidadIntermedia int IDENTITY NOT NULL PRIMARY KEY,
	RazonSocial varchar(50) NOT NULL,
	NombreComercial varchar(50) NOT NULL,
	esFinesDeLucro bit NOT NULL,
	Descripcion varchar(100) NOT NULL,
	DireccionLinea1 varchar(100) NOT null,
	DireccionLinea2 varchar(50),
	Municipio varchar(50) NOT null,
	Comarca varchar(50) NOT NULL,
	Provincia varchar(15) NOT NULL,
	CodigoPostal char(5) NOT NULL
);
GO

CREATE TABLE [Categoria](
	idCategoria int IDENTITY NOT NULL PRIMARY KEY,
	NombreCategoria varchar(15) NOT NULL,
	DescripcionCategoria varchar(100)
);

-- En esta entidad se registran las categorias que pueden administrar las entidades
CREATE TABLE [EntidadIntermediaCategoria](
	FKidCategoria int NOT NULL,
	FKidEntidadIntermedia int NOT NULL,
	CONSTRAINT fk_Categoria 
	FOREIGN KEY (FKidCategoria)
        REFERENCES [Categoria](idCategoria)
	),
	
	CONSTRAINT fk_EntidadIntermedia 
	FOREIGN KEY (FKidEntidadIntermedia)
        REFERENCES [EntidadIntermedia](idEntidadIntermedia)
	),
	
	CONSTRAINT PK_EntidadIntermediaCategoria 
	PRIMARY KEY (FKidCategoria, FKidEntidadIntermedia)
);
GO 

CREATE TABLE [Articulo](
	idArticulo int IDENTITY NOT NULL PRIMARY KEY,
	NombreArticulo varchar(50) NOT NULL,
	DescripcionArticulo varchar(100),
	esUsado bit NOT null,
	EstadoConservacion VARCHAR(10) NOT NULL CHECK (EstadoConservacion IN('Sin usar', 'Bueno', 'Regular')),
	ValorEnMercado money,
	FechaRegistro date NOT null,
	AntiguedadArticulo date,
	OrigenArticulo varchar(50),
	NotaAdicional varchar(100),
	FKidCategoria int NOT NULL,
	enEntidad bit NOT NULL,
	Estado VARCHAR(10) NOT NULL CHECK (EstadoConservacion IN('Rechazado','Pendiente','Listado','Donado')),
	CONSTRAINT fk_Categoria FOREIGN KEY (FKidCategoria)
        REFERENCES [Categoria](idCategoria)
)
);
GO