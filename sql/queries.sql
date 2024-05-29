-- Creación de tabla representantes_legales y agregar la aprimary key
CREATE TABLE "representantes_legales"(
    "id_representante" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NOT NULL,
    "profesion_empresa" TEXT NOT NULL,
    "relacion_ette" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telefono" TEXT NOT NULL
);
ALTER TABLE
    "representantes_legales" ADD PRIMARY KEY("id_representante");

-- Creación de tabla agentes y agregar la aprimary key

CREATE TABLE "agentes"(
    "id_agente" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NOT NULL,
    "perfil" TEXT NOT NULL,
    "email" VARCHAR(255) UNIQUE,
    "password" VARCHAR(255),
    "role" VARCHAR(255),
    "status" VARCHAR(255) SET DEFAULT 'active'
);
ALTER TABLE
    "agentes" ADD PRIMARY KEY("id_agente");

-- Creación de tabla historico_contactos y agregar la aprimary key
CREATE TABLE "historico_contactos"(
    "id_ultimo_contacto" SERIAL NOT NULL,
    "id_factura" BIGINT NOT NULL,
    "fecha" DATE NOT NULL,
    "motivo" TEXT NOT NULL,
    "comentarios" TEXT NOT NULL
);
ALTER TABLE
    "historico_contactos" ADD PRIMARY KEY("id_ultimo_contacto");

-- Creación de tabla facturas y agregar la aprimary key
CREATE TABLE "facturas"(
    "id_factura" SERIAL NOT NULL,
    "id_alumno" BIGINT NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,
    "fecha" DATE NOT NULL,
    "id_agente" BIGINT NOT NULL
);
ALTER TABLE
    "facturas" ADD PRIMARY KEY("id_factura");

-- Creación de tabla intereses y agregar la aprimary key

CREATE TABLE "intereses"(
    "id_interes" SERIAL NOT NULL,
    "id_alumno" BIGINT NOT NULL,
    "id_serviciog" INT NOT NULL,
);
ALTER TABLE
    "intereses" ADD PRIMARY KEY("id_interes");

-- Creación de tabla servicios_especificos y agregar la aprimary key

CREATE TABLE "servicios_especificos"(
    "id_servicioes" SERIAL NOT NULL,
    "id_serviciog" BIGINT NOT NULL,
    "nombre_servicio" VARCHAR(255) NOT NULL,
    "id_pais" BIGINT NOT NULL
);
ALTER TABLE
    "servicios_especificos" ADD PRIMARY KEY("id_servicioes");

-- Creación de tabla datos_facturacion y agregar la aprimary key

CREATE TABLE "datos_facturacion"(
    "id_facturacion" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NOT NULL,
    "domicilio" TEXT NOT NULL,
    "codigo_postal" TEXT NOT NULL,
    "ciudad" TEXT NOT NULL,
    "provincia" TEXT NOT NULL,
    "pais" TEXT NOT NULL,
    "dni" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "id_alumno" BIGINT NOT NULL
);
ALTER TABLE
    "datos_facturacion" ADD PRIMARY KEY("id_facturacion");

-- Creación de tabla alumnos y agregar la aprimary key

CREATE TABLE "alumnos"(
    "id_alumno" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NOT NULL,
    "fecha_nacimiento" DATE NOT NULL,
    "dni" TEXT NOT NULL,
    "nacionalidad" TEXT NOT NULL,
    "domicilio" TEXT NULL,
    "ciudad" TEXT NOT NULL,
    "provincia" TEXT NOT NULL,
    "pais" TEXT NOT NULL,
    "codigo_postal" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "colegio" TEXT NOT NULL,
    "curso" TEXT NOT NULL,
    "fecha_registro" DATE NOT NULL,
    "persona_recomendado" TEXT NOT NULL,
    "id_referencia" BIGINT NOT NULL
);
ALTER TABLE
    "alumnos" ADD PRIMARY KEY("id_alumno");

-- Creación de tabla paises y agregar la aprimary key

CREATE TABLE "paises"(
    "id_pais" SERIAL NOT NULL,
    "nombre" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "paises" ADD PRIMARY KEY("id_pais");

-- Creación de tabla lineas_factura y agregar la aprimary key

CREATE TABLE "lineas_factura"(
    "id_linea" SERIAL NOT NULL,
    "id_factura" BIGINT NOT NULL,
    "id_servicioes" BIGINT NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,
    "fecha" DATE NOT NULL
);
ALTER TABLE
    "lineas_factura" ADD PRIMARY KEY("id_linea");

-- Creación de tabla servicios_generales y agregar la aprimary key

CREATE TABLE "servicios_generales"(
    "id_serviciog" SERIAL NOT NULL,
    "nombre_servicio" TEXT NOT NULL
);
ALTER TABLE
    "servicios_generales" ADD PRIMARY KEY("id_serviciog");

-- Creación de tabla referencias y agregar la aprimary key

CREATE TABLE "referencias"(
    "id_referencia" SERIAL NOT NULL,
    "descripcion" TEXT NOT NULL
);

-- Crear la tabla 'representantes_alumnos'
CREATE TABLE representantes_alumnos (
    id_rep_al SERIAL PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_representante INT NOT NULL,
    CONSTRAINT fk_alumno FOREIGN KEY (id_alumno) REFERENCES "alumnos"(id_alumno),
    CONSTRAINT fk_representante FOREIGN KEY (id_representante) REFERENCES "representantes_legales"(id_representante)
);

ALTER TABLE
    "referencias" ADD PRIMARY KEY("id_referencia");

-- Establece una restricción de clave foránea en la tabla "intereses" que hace referencia al id del alumno en la tabla "alumnos"

ALTER TABLE
    "intereses" ADD CONSTRAINT "intereses_id_alumno_foreign" FOREIGN KEY("id_alumno") REFERENCES "alumnos"("id_alumno");

-- Define una restricción de clave foránea en la tabla "lineas_factura" que vincula el id del servicio específico con la tabla "servicios_especificos"
ALTER TABLE
    "lineas_factura" ADD CONSTRAINT "lineas_factura_id_servicioes_foreign" FOREIGN KEY("id_servicioes") REFERENCES "servicios_especificos"("id_servicioes");

-- Crea una restricción de clave foránea en la tabla "intereses" que referencia el id del servicio general en la tabla "servicios_generales"
ALTER TABLE
    "intereses" ADD CONSTRAINT "intereses_id_serviciog_foreign" FOREIGN KEY("id_serviciog") REFERENCES "servicios_generales"("id_serviciog");

-- Agrega una restricción de clave foránea en la tabla "facturas" que apunta al id del alumno en la tabla "alumnos"
ALTER TABLE
    "facturas" ADD CONSTRAINT "factura_id_alumno_foreign" FOREIGN KEY("id_alumno") REFERENCES "alumnos"("id_alumno");

-- Define una restricción de clave foránea en la tabla "servicios_especificos" que hace referencia al id del país en la tabla "paises"
ALTER TABLE
    "servicios_especificos" ADD CONSTRAINT "servicios_especificos_id_pais_foreign" FOREIGN KEY("id_pais") REFERENCES "paises"("id_pais");

-- Establece una restricción de clave foránea en la tabla "servicios_especificos" que vincula el id del servicio general con la tabla "servicios_generales"
ALTER TABLE
    "servicios_especificos" ADD CONSTRAINT "servicios_especificos_id_serviciog_foreign" FOREIGN KEY("id_serviciog") REFERENCES "servicios_generales"("id_serviciog");

-- Crea una restricción de clave foránea en la tabla "historico_contactos" que referencia el id de la factura en la tabla "facturas"
ALTER TABLE
    "historico_contactos" ADD CONSTRAINT "historico_contactos_id_factura_foreign" FOREIGN KEY("id_factura") REFERENCES "facturas"("id_factura");

-- Agrega una restricción de clave foránea en la tabla "alumnos" que apunta al id de referencia en la tabla "referencias"
ALTER TABLE
    "alumnos" ADD CONSTRAINT "alumno_id_referencia_foreign" FOREIGN KEY("id_referencia") REFERENCES "referencias"("id_referencia");

-- Define una restricción de clave foránea en la tabla "facturas" que hace referencia al id del agente en la tabla "agentes"
ALTER TABLE
    "facturas" ADD CONSTRAINT "factura_id_agente_foreign" FOREIGN KEY("id_agente") REFERENCES "agentes"("id_agente");

-- Establece una restricción de clave foránea en la tabla "lineas_factura" que vincula el id de la factura con la tabla "facturas"
ALTER TABLE
    "lineas_factura" ADD CONSTRAINT "lineas_factura_id_factura_foreign" FOREIGN KEY("id_factura") REFERENCES "facturas"("id_factura");

-- Crea una restricción de clave foránea en la tabla "datos_facturacion" que referencia el id del alumno en la tabla "alumnos"
ALTER TABLE
    "datos_facturacion" ADD CONSTRAINT "datos_facturacion_id_alumno_foreign" FOREIGN KEY("id_alumno") REFERENCES "alumnos"("id_alumno");

-- Agregar una columna 'interesado' a la tabla 'intereses'
ALTER TABLE intereses
ADD COLUMN interesado BOOLEAN  NOT NULL;




-- Insertar datos en la tabla 'agentes'
INSERT INTO "agentes" (nombre, apellidos, perfil, role) VALUES
    ('Mercedes', 'Gómez Badiola', 'Consultora académica','admin'),
    ('Emiliana', 'De Oteyza Pacanins', 'Psicóloga y coach','admin'),
    ('Belén', 'Ureña', 'Consultora académica','admin'),
    ('Patricia', 'Pizzolante De Oteyza', 'Psicóloga','admin'),
    ('Fiorella', 'Barroeta', 'Consultora académica','client'),
    ('Isabel', 'Segovia', 'Consultora Educativa y de programas de verano','client'),
    ('Andrea', 'Pizzolante', 'Administración','client'),
    ('Juan', 'González', 'Psicólogo','client'),
    ('Patricia', 'De Oteyza', 'Consultora académica','client'),
    ('Carmen', 'Olazabal', 'Consultora Académica y Agente comercial en Portugal','client'),
    ('Valentina', 'Gómez', 'Consultora Académica y Agente Comercial en Venezuela','client'),
    ('Lourdes', 'Urdaneta', 'Orientadora','client'),
    ('Carmen Irene', 'De Lisa', 'Psicóloga','client'),
    ('Diana', 'Rangel', 'Psicóloga','client'),
    ('Ana', 'Alameda', 'Psicóloga','client'),
    ('Bárbara', 'Calpe', 'Psicóloga','client'),
    ('Lorena', 'Valenti', 'Orientadora','client'),
    ('Nita', 'Aspiazu', 'Consultora académica','client'),
    ('Clara', 'Diez Domecq', 'Consultora académica y Agente comercial en Andalucía','client'),
    ('Paula', 'Arce', 'Agente comercial en Colombia','client'),
    ('Anne Marie', 'Riesco Cassel', 'Consultora académica y Agente comercial en Chile','client'),
    ('Pilar', 'Rodriguez Birrell', 'Consultora académica y Agente comercial en Chile','client');

-- Actualizar el estado de los agentes para que estén activos
UPDATE agentes
SET status = 'active';

-- Insertar datos en la tabla 'paises'
INSERT INTO "paises" (nombre) VALUES
('Holanda'), ('Estados Unidos'), ('Francia'), ('Suiza'), ('Alemania'), ('Canada'), ('Irlanda'), ('Inglaterra'), ('Escocia'), ('Italia'), ('Dinamarca'), ('España'), ('Australia'), ('Portugal');

-- Insertar datos en la tabla 'servicios_generales'
INSERT INTO "servicios_generales" ("nombre_servicio") VALUES
('Orientación Vocacional'),
('Orientación Profesional'),
('Año y Trimestre Escolar en el Extranjero'),
('Selección de Colegios en España'),
('Estudiar en España: Grados y Postgrados'),
('Estudiar en el Extranjero: Grados y Postgrados'),
('Preparación de Exámenes'),
('Campamentos'),
('Cursos Preuniversitarios'),
('Voluntariados'),
('Desarrollo personal');

-- Insertar datos en la tabla 'referencias'
INSERT INTO "referencias" (descripcion) VALUES
('Referencia (amigo, familiar, conocido)'),
('Redes Sociales (Instagram, Facebook, Whatsapp, Newsletter, LinkedIn)'),
('Página Web'),
('Institución (colegio, universidad, otras)');

-- Insertar datos en la tabla 'servicios_especificos'
INSERT INTO servicios_especificos (id_serviciog, nombre_servicio, id_pais) VALUES
(1, 'Orientación vocacional en España', 12),
(2, 'Orientación profesional en España', 12),
(5, 'Estudiar en España: Grados y Postgrados', 12),
(3, 'Año y trimestre escolar en Holanda', 1),
(3, 'Año y trimestre escolar en Estados Unidos', 2),
(3, 'Año y trimestre escolar en Francia', 3),
(3, 'Año y trimestre escolar en Suiza', 4),
(3, 'Año y trimestre escolar en Alemania', 5),
(3, 'Año y trimestre escolar en Canadá', 6),
(3, 'Año y trimestre escolar en Irlanda', 7),
(3, 'Año y trimestre escolar en Inglaterra', 8),
(3, 'Año y trimestre escolar en Escocia', 9),
(3, 'Año y trimestre escolar en Italia', 10),
(3, 'Año y trimestre escolar en Dinamarca', 11),
(3, 'Año y trimestre escolar en España', 12),
(3, 'Año y trimestre escolar en Australia', 13),
(3, 'Año y trimestre escolar en Portugal', 14),
(4, 'Selección de colegios en Holanda', 1),
(4, 'Selección de colegios en Estados Unidos', 2),
(4, 'Selección de colegios en Francia', 3),
(4, 'Selección de colegios en Suiza', 4),
(4, 'Selección de colegios en Alemania', 5),
(4, 'Selección de colegios en Canadá', 6),
(4, 'Selección de colegios en Irlanda', 7),
(4, 'Selección de colegios en Inglaterra', 8),
(4, 'Selección de colegios en Escocia', 9),
(4, 'Selección de colegios en Italia', 10),
(4, 'Selección de colegios en Dinamarca', 11),
(4, 'Selección de colegios en España', 12),
(4, 'Selección de colegios en Australia', 13),
(4, 'Selección de colegios en Portugal', 14),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Holanda', 1),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Estados Unidos', 2),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Francia', 3),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Suiza', 4),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Alemania', 5),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Canadá', 6),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Irlanda', 7),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Inglaterra', 8),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Escocia', 9),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Italia', 10),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Dinamarca', 11),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Australia', 13),
(6, 'Estudiar en el extranjero: Grados y Postgrados en Portugal', 14),
(7, 'Preparación de exámenes en Holanda', 1),
(7, 'Preparación de exámenes en Estados Unidos', 2),
(7, 'Preparación de exámenes en Francia', 3),
(7, 'Preparación de exámenes en Suiza', 4),
(7, 'Preparación de exámenes en Alemania', 5),
(7, 'Preparación de exámenes en Canadá', 6),
(7, 'Preparación de exámenes en Irlanda', 7),
(7, 'Preparación de exámenes en Inglaterra', 8),
(7, 'Preparación de exámenes en Escocia', 9),
(7, 'Preparación de exámenes en Italia', 10),
(7, 'Preparación de exámenes en Dinamarca', 11),
(7, 'Preparación de exámenes en España', 12),
(7, 'Preparación de exámenes en Australia', 13),
(7, 'Preparación de exámenes en Portugal', 14),
(8, 'Campamentos en Holanda', 1),
(8, 'Campamentos en Estados Unidos', 2),
(8, 'Campamentos en Francia', 3),
(8, 'Campamentos en Suiza', 4),
(8, 'Campamentos en Alemania', 5),
(8, 'Campamentos en Canadá', 6),
(8, 'Campamentos en Irlanda', 7),
(8, 'Campamentos en Inglaterra', 8),
(8, 'Campamentos en Escocia', 9),
(8, 'Campamentos en Italia', 10),
(8, 'Campamentos en Dinamarca', 11),
(8, 'Campamentos en España', 12),
(8, 'Campamentos en Australia', 13),
(8, 'Campamentos en Portugal', 14),
(9, 'Cursos preuniversitarios en Holanda', 1),
(9, 'Cursos preuniversitarios en Estados Unidos', 2),
(9, 'Cursos preuniversitarios en Francia', 3),
(9, 'Cursos preuniversitarios en Suiza', 4),
(9, 'Cursos preuniversitarios en Alemania', 5),
(9, 'Cursos preuniversitarios en Canadá', 6),
(9, 'Cursos preuniversitarios en Irlanda', 7),
(9, 'Cursos preuniversitarios en Inglaterra', 8),
(9, 'Cursos preuniversitarios en Escocia', 9),
(9, 'Cursos preuniversitarios en Italia', 10),
(9, 'Cursos preuniversitarios en Dinamarca', 11),
(9, 'Cursos preuniversitarios en España', 12),
(9, 'Cursos preuniversitarios en Australia', 13),
(9, 'Cursos preuniversitarios en Portugal', 14),
(10, 'Voluntariados en Holanda', 1),
(10, 'Voluntariados en Estados Unidos', 2),
(10, 'Voluntariados en Francia', 3),
(10, 'Voluntariados en Suiza', 4),
(10, 'Voluntariados en Alemania', 5),
(10, 'Voluntariados en Canadá', 6),
(10, 'Voluntariados en Irlanda', 7),
(10, 'Voluntariados en Inglaterra', 8),
(10, 'Voluntariados en Escocia', 9),
(10, 'Voluntariados en Italia', 10),
(10, 'Voluntariados en Dinamarca', 11),
(10, 'Voluntariados en España', 12),
(10, 'Voluntariados en Australia', 13),
(10, 'Voluntariados en Portugal', 14),
(11, 'Desarrollo personal en Holanda', 1),
(11, 'Desarrollo personal en Estados Unidos', 2),
(11, 'Desarrollo personal en Francia', 3),
(11, 'Desarrollo personal en Suiza', 4),
(11, 'Desarrollo personal en Alemania', 5),
(11, 'Desarrollo personal en Canadá', 6),
(11, 'Desarrollo personal en Irlanda', 7),
(11, 'Desarrollo personal en Inglaterra', 8),
(11, 'Desarrollo personal en Escocia', 9),
(11, 'Desarrollo personal en Italia', 10),
(11, 'Desarrollo personal en Dinamarca', 11),
(11, 'Desarrollo personal en España', 12),
(11, 'Desarrollo personal en Australia', 13),
(11, 'Desarrollo personal en Portugal', 14);

-- Insertar datos en la tabla 'alumnos'
INSERT INTO "alumnos" (nombre, apellidos, fecha_nacimiento, dni, nacionalidad, domicilio, ciudad, provincia, pais, codigo_postal, telefono, email, colegio, curso, fecha_registro, persona_recomendado, id_referencia) VALUES
('Carlos', 'García', '2008-09-13', '12345678A', 'Española', 'Calle Falsa 123', 'Madrid', 'Madrid', 'España', '28001', '600000001', 'carlos.garcia@example.com', 'Colegio A', '3º ESO', '2024-05-21', 'Pedro Sánchez', 1),
('María', 'Martínez', '2006-06-20', '87654321B', 'Mexicana', 'Calle Falsa 124', 'Ciudad de México', 'CDMX', 'México', '01000', '600000002', 'maria.martinez@example.com', 'Colegio B', '4º ESO', '2024-05-21', 'Laura Pérez', 2),
('José', 'Rodríguez', '2010-03-05', '13579246C', 'Argentina', 'Calle Falsa 125', 'Buenos Aires', 'Buenos Aires', 'Argentina', '1000', '600000003', 'jose.rodriguez@example.com', 'Colegio C', '2º Bach', '2024-05-21', 'Sofía Torres', 3),
('Ana', 'López', '2007-12-11', '24681359D', 'Colombiana', 'Calle Falsa 126', 'Bogotá', 'Cundinamarca', 'Colombia', '110111', '600000004', 'ana.lopez@example.com', 'Colegio D', '1º ESO', '2024-05-21', 'Carlos García', 4),
('Juan', 'González', '2005-08-29', '98765432E', 'Peruana', 'Calle Falsa 127', 'Lima', 'Lima', 'Perú', '15001', '600000005', 'juan.gonzalez@example.com', 'Colegio E', '1º Bach', '2024-05-21', 'Martina Romero', 1),
('Laura', 'Pérez', '2012-04-17', '74185296F', 'Chilena', 'Calle Falsa 128', 'Santiago', 'Santiago', 'Chile', '8320000', '600000006', 'laura.perez@example.com', 'Colegio A', '3º ESO', '2024-05-21', 'Diego Vargas', 2),
('Pedro', 'Sánchez', '2009-10-01', '15948726G', 'Venezolana', 'Calle Falsa 129', 'Caracas', 'Caracas', 'Venezuela', '1010', '600000007', 'pedro.sanchez@example.com', 'Colegio B', '4º ESO', '2024-05-21', 'Valeria Díaz', 3),
('Lucía', 'Ramírez', '2007-07-08', '85296374H', 'Cubana', 'Calle Falsa 130', 'La Habana', 'La Habana', 'Cuba', '10400', '600000008', 'lucia.ramirez@example.com', 'Colegio C', '2º Bach', '2024-05-21', 'Andrea Fernández', 4),
('Luis', 'Cruz', '2011-02-14', '36925814I', 'Boliviana', 'Calle Falsa 131', 'La Paz', 'La Paz', 'Bolivia', '9000', '600000009', 'luis.cruz@example.com', 'Colegio D', '1º ESO', '2024-05-21', 'Carlos García', 1),
('Sofía', 'Torres', '2006-11-23', '74125896J', 'Uruguaya', 'Calle Falsa 132', 'Montevideo', 'Montevideo', 'Uruguay', '11000', '600000010', 'sofia.torres@example.com', 'Colegio E', '1º Bach', '2024-05-21', 'Martina Romero', 2),
('Miguel', 'García', '2008-08-15', '12348765K', 'Española', 'Calle Falsa 133', 'Madrid', 'Madrid', 'España', '28001', '600000011', 'miguel.garcia@example.com', 'Colegio A', '3º ESO', '2024-05-21', 'Pedro Sánchez', 3),
('Carmen', 'Martínez', '2006-05-27', '87654321L', 'Mexicana', 'Calle Falsa 134', 'Ciudad de México', 'CDMX', 'México', '01000', '600000012', 'carmen.martinez@example.com', 'Colegio B', '4º ESO', '2024-05-21', 'Laura Pérez', 4),
('Javier', 'Rodríguez', '2010-02-10', '13579246M', 'Argentina', 'Calle Falsa 135', 'Buenos Aires', 'Buenos Aires', 'Argentina', '1000', '600000013', 'javier.rodriguez@example.com', 'Colegio C', '2º Bach', '2024-05-21', 'Sofía Torres', 1),
('Elena', 'López', '2007-11-13', '24681359N', 'Colombiana', 'Calle Falsa 136', 'Bogotá', 'Cundinamarca', 'Colombia', '110111', '600000014', 'elena.lopez@example.com', 'Colegio D', '1º ESO', '2024-05-21', 'Carlos García', 2),
('Pablo', 'Gómez', '2005-09-25', '12365478O', 'Uruguaya', 'Calle Falsa 137', 'Montevideo', 'Montevideo', 'Uruguay', '11000', '600000015', 'pablo.gomez@example.com', 'Colegio E', '1º Bach', '2024-05-21', 'Martina Romero', 3),
('Sara', 'Moreno', '2012-03-29', '78965432P', 'Ecuatoriana', 'Calle Falsa 138', 'Quito', 'Pichincha', 'Ecuador', '170150', '600000016', 'sara.moreno@example.com', 'Colegio A', '3º ESO', '2024-05-21', 'Diego Vargas', 4),
('Raúl', 'Hernández', '2008-06-18', '45698712Q', 'Paraguaya', 'Calle Falsa 139', 'Asunción', 'Central', 'Paraguay', '1209', '600000017', 'raul.hernandez@example.com', 'Colegio B', '4º ESO', '2024-05-21', 'Valeria Díaz', 1),
('Valeria', 'Suárez', '2006-01-22', '78945632R', 'Brasileña', 'Calle Falsa 140', 'Brasilia', 'Distrito Federal', 'Brasil', '70000', '600000018', 'valeria.suarez@example.com', 'Colegio C', '2º Bach', '2024-05-21', 'Andrea Fernández', 2),
('Alberto', 'Molina', '2009-04-19', '96325814S', 'Peruana', 'Calle Falsa 141', 'Lima', 'Lima', 'Perú', '15001', '600000019', 'alberto.molina@example.com', 'Colegio D', '1º ESO', '2024-05-21', 'Carlos García', 3),
('Patricia', 'Núñez', '2007-05-03', '25836914T', 'Venezolana', 'Calle Falsa 142', 'Caracas', 'Caracas', 'Venezuela', '1010', '600000020', 'patricia.nunez@example.com', 'Colegio E', '1º Bach', '2024-05-21', 'Martina Romero', 4);



-- Insertar datos en la tabla 'datos_facturacion'
INSERT INTO datos_facturacion(nombre, apellidos, domicilio, codigo_postal, ciudad, provincia, pais, dni, email, id_alumno) VALUES
('Manuel', 'García', 'Calle Falsa 123', '28001', 'Madrid', 'Madrid', 'España', '98765432A', 'manuel.garcia@example.com', 1),
('Patricia', 'Martínez', 'Calle Falsa 124', '01000', 'Ciudad de México', 'CDMX', 'México', '12345678B', 'patricia.martinez@example.com', 2),
('Eduardo', 'Rodríguez', 'Calle Falsa 125', '1000', 'Buenos Aires', 'Buenos Aires', 'Argentina', '87654321C', 'eduardo.rodriguez@example.com', 3),
('Carolina', 'López', 'Calle Falsa 126', '110111', 'Bogotá', 'Cundinamarca', 'Colombia', '13579246D', 'carolina.lopez@example.com', 4),
('Jorge', 'González', 'Calle Falsa 127', '15001', 'Lima', 'Lima', 'Perú', '24681359E', 'jorge.gonzalez@example.com', 5),
('Silvia', 'Pérez', 'Calle Falsa 128', '8320000', 'Santiago', 'Santiago', 'Chile', '74185296F', 'silvia.perez@example.com', 6),
('Fernando', 'Sánchez', 'Calle Falsa 129', '1010', 'Caracas', 'Caracas', 'Venezuela', '15948726G', 'fernando.sanchez@example.com', 7),
('Beatriz', 'Ramírez', 'Calle Falsa 130', '10400', 'La Habana', 'La Habana', 'Cuba', '85296374H', 'beatriz.ramirez@example.com', 8),
('Natalia', 'Cruz', 'Calle Falsa 131', '9000', 'La Paz', 'La Paz', 'Bolivia', '36925814I', 'natalia.cruz@example.com', 9),
('Ricardo', 'Torres', 'Calle Falsa 132', '11000', 'Montevideo', 'Montevideo', 'Uruguay', '74125896J', 'ricardo.torres@example.com', 10),
('Isabel', 'García', 'Calle Falsa 133', '28001', 'Madrid', 'Madrid', 'España', '12348765K', 'isabel.garcia@example.com', 11),
('Andres', 'Martínez', 'Calle Falsa 134', '01000', 'Ciudad de México', 'CDMX', 'México', '87654321L', 'andres.martinez@example.com', 12),
('Gabriela', 'Rodríguez', 'Calle Falsa 135', '1000', 'Buenos Aires', 'Buenos Aires', 'Argentina', '13579246M', 'gabriela.rodriguez@example.com', 13),
('Francisco', 'López', 'Calle Falsa 136', '110111', 'Bogotá', 'Cundinamarca', 'Colombia', '24681359N', 'francisco.lopez@example.com', 14),
('Mariela', 'Gómez', 'Calle Falsa 137', '11000', 'Montevideo', 'Montevideo', 'Uruguay', '12365478O', 'mariela.gomez@example.com', 15),
('Daniela', 'Moreno', 'Calle Falsa 138', '170150', 'Quito', 'Pichincha', 'Ecuador', '78965432P', 'daniela.moreno@example.com', 16),
('Roberto', 'Hernández', 'Calle Falsa 139', '1209', 'Asunción', 'Central', 'Paraguay', '45698712Q', 'roberto.hernandez@example.com', 17),
('Adriana', 'Suárez', 'Calle Falsa 140', '70000', 'Brasilia', 'Distrito Federal', 'Brasil', '78945632R', 'adriana.suarez@example.com', 18),
('Sergio', 'Molina', 'Calle Falsa 141', '15001', 'Lima', 'Lima', 'Perú', '96325814S', 'sergio.molina@example.com', 19),
('Lucia', 'Núñez', 'Calle Falsa 142', '1010', 'Caracas', 'Caracas', 'Venezuela', '25836914T', 'lucia.nunez@example.com', 20);

-- Insertar datos en la tabla 'facturas'
INSERT INTO "facturas"(id_alumno, precio, fecha, id_agente)
VALUES
(5, 2325.21, '2023-07-12 08:14:30', 9),
(2, 1874.68, '2022-05-18 15:27:49', 6),
(12, 4165.75, '2022-08-29 09:58:11', 17),
(10, 3154.29, '2023-02-04 21:43:20', 21),
(18, 2148.57, '2022-06-08 16:09:55', 10),
(14, 1278.36, '2022-07-25 12:37:08', 11),
(8, 3292.42, '2022-11-16 18:55:13', 19),
(11, 2905.83, '2022-11-30 04:22:41', 16),
(17, 1612.19, '2023-04-06 10:47:23', 15),
(19, 3423.55, '2022-05-30 20:08:57', 7),
(9, 4056.71, '2022-08-06 07:11:33', 13),
(6, 1789.14, '2023-01-14 22:31:28', 3),
(1, 3326.42, '2022-02-21 03:14:57', 4),
(20, 4549.93, '2022-11-08 19:58:34', 20),
(4, 2980.66, '2022-04-10 08:48:02', 1),
(13, 1885.77, '2023-06-19 13:37:55', 8),
(3, 2311.94, '2022-09-17 05:22:46', 5),
(15, 3742.28, '2022-10-23 17:50:09', 14),
(7, 4027.03, '2022-03-08 11:59:14', 2),
(16, 2976.39, '2022-12-15 23:46:28', 12);

-- Actualizar los correos electrónicos y contraseñas de los agentes basados en su id_agente
UPDATE "agentes"SET
    email = CASE id_agente
        WHEN 1 THEN 'mercedes.gomez@example.com'
        WHEN 2 THEN 'emiliana.otecyza@example.com'
        WHEN 3 THEN 'belen.urena@example.com'
        WHEN 4 THEN 'patricia.pizzolante@example.com'
        WHEN 5 THEN 'fiorella.barroeta@example.com'
        WHEN 6 THEN 'isabel.segovia@example.com'
        WHEN 7 THEN 'andrea.pizzolante@example.com'
        WHEN 8 THEN 'juan.gonzalez@example.com'
        WHEN 9 THEN 'patricia.otezya@example.com'
        WHEN 10 THEN 'carmen.olazabal@example.com'
        WHEN 11 THEN 'valentina.gomez@example.com'
        WHEN 12 THEN 'lourdes.urdaneta@example.com'
        WHEN 13 THEN 'carmenirene.delisa@example.com'
        WHEN 14 THEN 'diana.rangel@example.com'
        WHEN 15 THEN 'ana.alameda@example.com'
        WHEN 16 THEN 'barbara.calpe@example.com'
        WHEN 17 THEN 'lorena.valenti@example.com'
        WHEN 18 THEN 'nita.aspiazu@example.com'
        WHEN 19 THEN 'clara.diez@example.com'
        WHEN 20 THEN 'paula.arce@example.com'
        WHEN 21 THEN 'annemarie.riesco@example.com'
        WHEN 22 THEN 'pilar.rodriguez@example.com'
    END,
    password = CASE id_agente
        WHEN 1 THEN 'M3rc3d3s!23'
        WHEN 2 THEN 'Emili@na#2024'
        WHEN 3 THEN 'B3l3n*1234'
        WHEN 4 THEN 'P@trici@#5678'
        WHEN 5 THEN 'Fiorel!@8901'
        WHEN 6 THEN 'Is@b3l!456'
        WHEN 7 THEN 'Andr3@12345'
        WHEN 8 THEN 'Ju@ng0nz!789'
        WHEN 9 THEN 'P@trici@7890'
        WHEN 10 THEN 'C@rm3n#2024'
        WHEN 11 THEN 'V@l3ntin@!4567'
        WHEN 12 THEN 'L0urd3s#5678'
        WHEN 13 THEN 'C@rm3nIr3n3!9012'
        WHEN 14 THEN 'Di@na#7890'
        WHEN 15 THEN 'An@2024#@123'
        WHEN 16 THEN 'B@rb@r@456'
        WHEN 17 THEN 'L0r3na!@2023'
        WHEN 18 THEN 'N!t@Asp!2023'
        WHEN 19 THEN 'Cl@ra!123456'
        WHEN 20 THEN 'P@ul@2024#@12'
        WHEN 21 THEN 'Ann3Mari3!567'
        WHEN 22 THEN 'P!l@rRodr!5678'
    END;

--  Insertar datos en la tabla 'representantes_legales'
INSERT INTO representantes_legales (nombre, apellidos, profesion_empresa, relacion_estudiante, email, telefono, id_alumno)
VALUES
    ('Manuel', 'García', 'Abogado', 'Familiar', 'manuel.garcia@example.com', '600000001', 1),
    ('Marta', 'Fernández', 'Médico', 'Familiar', 'marta.fernandez@example.com', '600000021', 1),
    ('Patricia', 'Martínez', 'Contadora', 'Tutor', 'patricia.martinez@example.com', '600000002', 2),
    ('Eduardo', 'Rodríguez', 'Médico', 'Familiar', 'eduardo.rodriguez@example.com', '600000003', 3),
    ('Javier', 'Martínez', 'Abogado', 'Familiar', 'javier.martinez@example.com', '600000022', 3),
    ('Carolina', 'López', 'Ingeniero', 'Familiar', 'carolina.lopez@example.com', '600000004', 4),
    ('María', 'López', 'Ingeniera', 'Familiar', 'maria.lopez@example.com', '600000023', 4),
    ('Jorge', 'González', 'Empresario', 'Tutor', 'jorge.gonzalez@example.com', '600000005', 5),
    ('Silvia', 'Pérez', 'Psicóloga', 'Tutor', 'silvia.perez@example.com', '600000006', 6),
    ('Fernando', 'Sánchez', 'Abogado', 'Familiar', 'fernando.sanchez@example.com', '600000007', 7),
    ('Carlos', 'García', 'Contador', 'Familiar', 'carlos.garcia@example.com', '600000024', 7),
    ('Beatriz', 'Ramírez', 'Contadora', 'Tutor', 'beatriz.ramirez@example.com', '600000008', 8),
    ('Natalia', 'Cruz', 'Ingeniera', 'Familiar', 'natalia.cruz@example.com', '600000009', 9),
    ('Laura', 'González', 'Psicóloga', 'Familiar', 'laura.gonzalez@example.com', '600000025', 9),
    ('Ricardo', 'Torres', 'Empresario', 'Tutor', 'ricardo.torres@example.com', '600000010', 10),
    ('Isabel', 'García', 'Abogada', 'Familiar', 'isabel.garcia@example.com', '600000011', 11),
    ('Pablo', 'Pérez', 'Empresario', 'Familiar', 'pablo.perez@example.com', '600000026', 11),
    ('Andres', 'Martínez', 'Contador', 'Tutor', 'andres.martinez@example.com', '600000012', 12),
    ('Gabriela', 'Rodríguez', 'Médica', 'Familiar', 'gabriela.rodriguez@example.com', '600000013', 13),
    ('Martina', 'Sánchez', 'Contadora', 'Familiar', 'martina.sanchez@example.com', '600000027', 13),
    ('Francisco', 'López', 'Ingeniero', 'Familiar', 'francisco.lopez@example.com', '600000014', 14),
    ('Diego', 'Ramírez', 'Ingeniero', 'Familiar', 'diego.ramirez@example.com', '600000028', 14),
    ('Mariela', 'Gómez', 'Empresaria', 'Tutor', 'mariela.gomez@example.com', '600000015', 15),
    ('Daniela', 'Moreno', 'Psicóloga', 'Tutor', 'daniela.moreno@example.com', '600000016', 16),
    ('Roberto', 'Hernández', 'Abogado', 'Familiar', 'roberto.hernandez@example.com', '600000017', 17),
    ('Andrea', 'Cruz', 'Abogada', 'Familiar', 'andrea.cruz@example.com', '600000029', 17),
    ('Adriana', 'Suárez', 'Contadora', 'Tutor', 'adriana.suarez@example.com', '600000018', 18),
    ('Sergio', 'Molina', 'Ingeniero', 'Familiar', 'sergio.molina@example.com', '600000019', 19),
    ('Ricardo', 'Torres', 'Médico', 'Familiar', 'ricardo.torres2@example.com', '600000010', 19),
    ('Lucía', 'Núñez', 'Empresaria', 'Tutor', 'lucia.nunez@example.com', '600000020', 20);

--  Insertar datos en la tabla 'representantes_alumnos'
INSERT INTO representantes_alumnos (id_alumno, id_representante)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (3, 5),
    (4, 6),
    (4, 7),
    (5, 8),
    (6, 9),
    (7, 10),
    (7, 11),
    (8, 12),
    (9, 13),
    (9, 14),
    (10, 15),
    (11, 16),
    (11, 17),
    (12, 18),
    (13, 19),
    (13, 20);

--  Insertar datos en la tabla 'lineas_factura'
INSERT INTO lineas_factura (id_factura, id_servicioes, precio, fecha) VALUES
(1, 1, 1000.00, '2023-07-12'),
(1, 2, 1325.21, '2023-07-12'),
(2, 3, 1000.00, '2022-05-18'),
(2, 4, 874.68, '2022-05-18'),
(3, 5, 1000.00, '2022-08-29'),
(3, 6, 1665.75, '2022-08-29'),
(4, 7, 1000.00, '2023-02-04'),
(4, 8, 2154.29, '2023-02-04'),
(5, 9, 1000.00, '2022-06-08'),
(5, 10, 1148.57, '2022-06-08'),
(6, 11, 1000.00, '2022-07-25'),
(6, 12, 278.36, '2022-07-25'),
(7, 13, 1000.00, '2022-11-16'),
(7, 14, 2292.42, '2022-11-16'),
(8, 15, 1000.00, '2022-11-30'),
(8, 16, 1905.83, '2022-11-30'),
(9, 17, 1000.00, '2023-04-06'),
(9, 18, 612.19, '2023-04-06'),
(10, 19, 1000.00, '2022-05-30'),
(10, 20, 2423.55, '2022-05-30'),
(11, 21, 1000.00, '2022-08-06'),
(11, 22, 3056.71, '2022-08-06'),
(12, 23, 1000.00, '2023-01-14'),
(12, 24, 789.14, '2023-01-14'),
(13, 25, 1000.00, '2022-02-21'),
(13, 26, 2326.42, '2022-02-21'),
(14, 27, 1000.00, '2022-11-08'),
(14, 28, 3549.93, '2022-11-08'),
(15, 29, 1000.00, '2022-04-10'),
(15, 30, 1980.66, '2022-04-10'),
(16, 31, 1000.00, '2023-06-19'),
(16, 32, 885.77, '2023-06-19'),
(17, 33, 1000.00, '2022-09-17'),
(17, 34, 3111.94, '2022-09-17'),
(18, 35, 1000.00, '2022-10-23'),
(18, 36, 2742.28, '2022-10-23'),
(19, 37, 1000.00, '2022-03-08'),
(19, 38, 3027.03, '2022-03-08'),
(20, 39, 1000.00, '2022-12-15'),
(20, 40, 1976.39, '2022-12-15');

--  Insertar datos en la tabla 'historico_contactos'
INSERT INTO historico_contactos (id_agente, fecha, motivo, id_alumno, comentarios) VALUES
(1, '2022-01-15', 'seguimiento', 1, 'Llamada de seguimiento realizada con éxito.'),
(2, '2022-02-20', 'ofertas', 2, 'Se ofreció un nuevo descuento en la matrícula.'),
(3, '2022-03-10', 'incidencias', 3, 'Reporte de problema con el acceso a la plataforma.'),
(4, '2022-04-25', 'seguimiento', 4, 'Seguimiento sobre el progreso académico del alumno.'),
(5, '2022-05-13', 'ofertas', 5, 'Promoción de nuevos cursos de verano.'),
(6, '2022-06-07', 'incidencias', 6, 'Queja sobre la calidad del material entregado.'),
(7, '2022-07-18', 'seguimiento', 7, 'Llamada de seguimiento sobre la asistencia.'),
(8, '2022-08-21', 'ofertas', 8, 'Descuento especial por inscripción anticipada.'),
(9, '2022-09-30', 'incidencias', 9, 'Problema técnico con la plataforma virtual.'),
(10, '2022-10-11', 'seguimiento', 10, 'Revisión del plan de estudios con el tutor.'),
(11, '2022-11-03', 'ofertas', 11, 'Oferta de cursos adicionales para el próximo semestre.'),
(12, '2022-12-19', 'incidencias', 12, 'Problema con la facturación del último mes.'),
(13, '2023-01-05', 'seguimiento', 13, 'Revisión del rendimiento académico.'),
(14, '2023-02-23', 'ofertas', 14, 'Descuento por referir a un amigo.'),
(15, '2023-03-14', 'incidencias', 15, 'Retraso en la entrega del material de estudio.'),
(16, '2023-04-01', 'seguimiento', 16, 'Seguimiento sobre el uso de recursos adicionales.'),
(17, '2022-01-18', 'ofertas', 17, 'Promoción de clases particulares.'),
(18, '2022-02-25', 'incidencias', 18, 'Queja sobre el servicio de tutoría.'),
(19, '2022-03-22', 'seguimiento', 19, 'Llamada de seguimiento después del primer trimestre.'),
(20, '2022-04-08', 'ofertas', 20, 'Oferta especial para el curso de verano.'),
(21, '2022-05-16', 'incidencias', 1, 'Problema con la configuración de la cuenta.'),
(22, '2022-06-14', 'seguimiento', 2, 'Revisión de objetivos académicos.'),
(1, '2022-07-23', 'ofertas', 3, 'Descuento en cursos en línea.'),
(2, '2022-08-29', 'incidencias', 4, 'Problemas de conectividad en la plataforma.'),
(3, '2022-09-17', 'seguimiento', 5, 'Consulta sobre el progreso en las materias.'),
(4, '2022-10-25', 'ofertas', 6, 'Promoción de nuevos programas académicos.'),
(5, '2022-11-13', 'incidencias', 7, 'Reporte de problema con la descarga de archivos.'),
(6, '2022-12-04', 'seguimiento', 8, 'Revisión de rendimiento en exámenes.'),
(7, '2023-01-20', 'ofertas', 9, 'Oferta especial por la inscripción temprana.'),
(8, '2023-02-15', 'incidencias', 10, 'Problemas con la visualización de contenidos.'),
(9, '2023-03-28', 'seguimiento', 11, 'Seguimiento de la asistencia a clases.'),
(10, '2023-04-12', 'ofertas', 12, 'Descuento en programas de verano.'),
(11, '2022-01-11', 'incidencias', 13, 'Problemas de acceso a la cuenta del alumno.'),
(12, '2022-02-03', 'seguimiento', 14, 'Revisión del desempeño académico en el segundo trimestre.'),
(13, '2022-03-21', 'ofertas', 15, 'Promoción de cursos avanzados.'),
(14, '2022-04-30', 'incidencias', 16, 'Problema con la entrega de certificados.'),
(15, '2022-05-25', 'seguimiento', 17, 'Consulta sobre el progreso en los proyectos.'),
(16, '2022-06-05', 'ofertas', 18, 'Descuento por pago anual.'),
(17, '2022-07-30', 'incidencias', 19, 'Problemas con el contenido del curso.'),
(18, '2022-08-16', 'seguimiento', 20, 'Llamada de seguimiento sobre el plan de estudios.'),
(19, '2022-09-12', 'ofertas', 1, 'Promoción de eventos académicos.'),
(20, '2022-10-08', 'incidencias', 2, 'Reporte de problema con la evaluación en línea.'),
(21, '2022-11-27', 'seguimiento', 3, 'Seguimiento del progreso académico.'),
(22, '2022-12-14', 'ofertas', 4, 'Descuento en matrícula por inscripción anticipada.'),
(1, '2023-01-09', 'incidencias', 5, 'Problema con la calificación del examen.'),
(2, '2023-02-24', 'seguimiento', 6, 'Revisión de objetivos para el semestre.'),
(3, '2023-03-17', 'ofertas', 7, 'Promoción de cursos online.'),
(4, '2023-04-05', 'incidencias', 8, 'Reporte de problema con el material de estudio.'),
(5, '2022-01-27', 'seguimiento', 9, 'Consulta sobre el progreso en las asignaturas.'),
(6, '2022-02-14', 'ofertas', 10, 'Promoción de clases adicionales.'),
(7, '2022-03-06', 'incidencias', 11, 'Problema con la entrega de libros.'),
(8, '2022-04-24', 'seguimiento', 12, 'Revisión del desempeño académico.'),
(9, '2022-05-11', 'ofertas', 13, 'Descuento especial por la inscripción anticipada.'),
(10, '2022-06-28', 'incidencias', 14, 'Problema técnico con la plataforma de estudio.'),
(11, '2022-07-15', 'seguimiento', 15, 'Consulta sobre la asistencia a clases.'),
(12, '2022-08-03', 'ofertas', 16, 'Promoción de nuevos cursos de verano.'),
(13, '2022-09-25', 'incidencias', 17, 'Problema con el acceso a los recursos online.'),
(14, '2022-10-20', 'seguimiento', 18, 'Revisión de objetivos académicos alcanzados.'),
(15, '2022-11-08', 'ofertas', 19, 'Descuento en programas de estudio.'),
(16, '2022-12-30', 'incidencias', 20, 'Queja sobre el servicio de atención al cliente.');

