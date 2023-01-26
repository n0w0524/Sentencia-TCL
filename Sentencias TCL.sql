create table peliculas (
id_pelicula int not null,
titulo varchar (255) not null,
duracion time not null,
año smallint (4) not null,
sinopsis varchar  (255),
primary key (id_pelicula));

create table directores (
id_director int not null,
nombre_director varchar (255) not null,
año_nacimiento_director smallint(4) not null,
primary key (id_director));

create table actores (
id_actor int not null auto_increment,
nombre_actor varchar (255) not null,
año_nacimiento_actor smallint(4) not null,
primary key (id_actor));


create table usuarios (
id_usuario int not null auto_increment,
nombre_usuario varchar (255) not null,
apellido_usuario varchar (255) not null,
usuario_login varchar (50) not null,
usuario_contraseña varchar (50) not null,
primary key (id_usuario));

CREATE TABLE acciones (
  `id_accion` INT NOT NULL AUTO_INCREMENT,
  `accion` VARCHAR(200) NULL,
  `fecha` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_accion`));

create table reseña (
id_reseña int not null auto_increment,
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
puntaje_imdb decimal,
primary key (id_reseña));

create table genero (
id_genero int not null auto_increment,
genero varchar (255) not null,
primary key (id_genero));

create table genero_peliculas (
id_genero int not null,
foreign key (id_genero) references genero (id_genero),
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
titulo_pelicula varchar (255) not null
);

create table dirigido_por (
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
id_director int not null,
foreign key (id_director) references directores(id_director),
titulo_pelicula varchar (255) not null
);

create table actuo_en (
id_actor int not null,
foreign key (id_actor) references actores(id_actor),
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
titulo_pelicula varchar (255) not null
);

create table reproducciones (
id_usuario int not null,
foreign key (id_usuario) references usuarios(id_usuarios),
id_pelicula int not null,
foreign key (id_pelicula) references peliculas(id_pelicula),
reproducciones int null);

/*Trigger para solicitar titulo obligatorio*/
DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `titulo_obligatorio` BEFORE INSERT ON `peliculas` FOR EACH ROW
BEGIN
if new.titulo is null then
set new.titulo = "Titulo Obligatorio";
END IF;
END
$$
DELIMITER ;

/*Trigger que almacena todas las acciones tomadas en la tabla peliculas en la tabla acciones*/

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `log_peliculas` AFTER INSERT ON `peliculas` FOR EACH ROW
BEGIN
insert into acciones (accion) value (concat("Se registró la pelicula:", new.titulo, "ID:", " ", new.id_pelicula ));
END$$
DELIMITER ;

insert into peliculas (id_pelicula,titulo, duracion, año, sinopsis) 
values 
(1,"Breve Encuentro", "1:26:00", 1945, "Al encontrarse con un extraño en una estación de tren, una mujer siente la tentación de engañar a su marido."),
(2,"Casablanca", "1:42:00", 1942, "Un cínico expatriado norteamericano, dueño de un café, se debate entre ayudar o no a su antigua amante y a su marido fugitivo a escapar de los nazis en el Marruecos frances."),
(3,"Antes del Amanecer", "1:41:00", 1995, "Un joven y una mujer se conocen en un tren en Europa y terminan pasando una noche juntos en Viena. Desafortunadamente, ambos saben que esta será probablemente la única noche que estén juntos."),
(4,"Antes del Atardecer", "1:20:00", 2004, "Nueve años después de conocerse, Jesse y Celine se reencuentran durante la gira del libro de Jesse en Francia."),
(5,"Al Final de la Escapada", "1:30:00", 1960, "Un ladrón de poca monta roba un coche y asesina de manera impulsiva a un motorista de la policía. Buscado por las autoridades, se reúne con una estudiante estadounidense de periodismo y trata de convencerla para que huya con él a Italia."),
(6,"Deseando Amar", "1:38:00", 2000, "Dos vecinos forman un fuerte vínculo después de que ambos sospechen de actividades extramatrimoniales de sus cónyuges. Sin embargo, acuerdan mantener su vínculo platónico para no cometer errores similares."),
(7,"El Apartamento", "2:05:00", 1960, "Al encontrarse con un extraño en una estación de tren, una mujer siente la tentación de engañar a su marido."),
(8,"Hannah y sus Hermanas", "1:47:00", 1986, "En el año que transcurre entre dos días de Acción de Gracias, el marido de Hanna se enamora de su hermana Lee, y su hipocondríaco exmarido empieza a salir con su hermana Holly."),
(9,"¡Olvídate de Mí!", "1:48:00", 2004, "Cuando su relación se deteriora, una pareja se somete a un proceso médico para borrar el uno al otro de su memoria."),
(10,"Una Habitación con Vistas", "1:48:00", 1985, "Lucy conoce a George en una pensión de Florencia y ambos comparten un breve romance antes de que Lucy regrese a casa, donde se compromete con Cecil. Sin embargo, no pasa mucho tiempo antes de que George vuelva a entrar en su vida.");

--  Sentencia Rollback, Commit
SET @@AUTOCOMMIT=0;
SET FOREIGN_KEY_CHECKS=off;SET SQL_SAFE_UPDATES = 0;
Start transaction;
Delete from peliculas  where id_pelicula = 4;
Delete from peliculas  where id_pelicula = 5;
Delete from peliculas  where id_pelicula = 6;
-- Rollback
-- commit
/* insert into peliculas (id_pelicula, titulo, duracion, año, sinopsis) 
values
(4,"Antes del Atardecer", "1:20:00", 2004, "Nueve años después de conocerse, Jesse y Celine se reencuentran durante la gira del libro de Jesse en Francia."),
(5,"Al Final de la Escapada", "1:30:00", 1960, "Un ladrón de poca monta roba un coche y asesina de manera impulsiva a un motorista de la policía. Buscado por las autoridades, se reúne con una estudiante estadounidense de periodismo y trata de convencerla para que huya con él a Italia."),
(6,"Deseando Amar", "1:38:00", 2000, "Dos vecinos forman un fuerte vínculo después de que ambos sospechen de actividades extramatrimoniales de sus cónyuges. Sin embargo, acuerdan mantener su vínculo platónico para no cometer errores similares."); */

select * from peliculas;

-- Sentencia Savepoint
start transaction;
insert into directores (id_director, nombre_director, año_nacimiento_director) values 
(1,"David Lean", "1908"),
(2,"Michael Curtiz", "1886"),
(3,"Richard Linklater", "1960"),
(4,"Jean-Luc Godard", "1930");
savepoint sp1;
insert into directores (id_director, nombre_director, año_nacimiento_director) values
(5,"Kar-Wai Wong", "1956"),
(6,"Billy Wilder", "1906"),
(7,"Woody Allen", "1935"),
(8,"James Ivory", "1928");
savepoint sp2;
insert into directores (id_director, nombre_director, año_nacimiento_director) values
(9,"Michel Gondry", "1963");
-- release savepoint sp1
-- commit

select * from directores;

insert into actores (nombre_actor, año_nacimiento_actor) values 
("Celia Johnson", 1908),
("Trevor Howard", 1913),
("Stanley Holloway", 1890),
("Humphrey Bogart", 1899),
("Ingrid Bergman", 1915),
("Paul Henreid", 1908),
("Ethan Hawke", 1970),
("Julie Delpy", 1969),
("Vernon Dobtcheff", 1934),
("Jean-Paul Belmondo", 1933),
("Jean Seberg", 1938),
("Daniel Boulanger", 1922),
("Tony Chiu-Wai Leung", 1962),
("Maggie Cheung", 1964),
("Jack Lemmon", 1925),
("Shirley MacLaine", 1934),
("Fred MacMurray", 1908),
("Mia Farrow", 1945),
("Dianne Wiest", 1946),
("Michael Caine", 1933),
("Jim Carrey", 1962),
("Kate Winslet", 1975),
("Tom Wilkinson", 1948),
("Helena Bonham Carter", 1966),
("Julian Sands", 1958),
("Maggie Smith", 1934);

insert into reseña (id_pelicula, puntaje_imdb) values
(1, 8.0),
(2, 8.5),
(3, 8.1),
(4, 8.1),
(5, 7.7),
(6, 8.1),
(7, 8.3),
(8, 7.9),
(9, 8.3),
(10, 7.2);

insert into genero (genero) values
("Romance"),
("Drama"),
("Comedia"),
("Accion"),
("Terror"),
("Ciencia Ficcion"),
("Fantasia"),
("Suspenso"),
("Infantil"),
("Animacion");

insert into genero_peliculas (id_genero, id_pelicula, titulo_pelicula) values 
(1,1, "Breve Encuentro"),
(1,2, "Casablanca"),
(1,3, "Antes del Amanecer"),
(1,4, "Antes del Atardecer"),
(1,5, "Al Final de la Escapada"),
(1,6, "El Apartamento"),
(1,7, "El Apartamento"),
(1,8, "Hannah y sus Hermanas"),
(1,9, "¡Olvídate de Mí!"),
(1,10, "Una Habitación con Vistas");

insert into dirigido_por (id_pelicula, id_director, titulo_pelicula) values 
(1,1, "Breve Encuentro"),
(2,2, "Casablanca"),
(3,3, "Antes del Amanecer"),
(4,3, "Antes del Atardecer"),
(5,4,"Al Final de la Escapada"),
(6,5, "Deseando Amar"),
(7,6, "El Apartamento"),
(8,7, "Hannah y sus Hermanas"),
(9,8, "¡Olvídate de Mí!"),
(10,9, "Una Habitación con Vistas");


insert into actuo_en (id_actor, id_pelicula, titulo_pelicula) values
(1,1, "Breve Encuentro"),
(2,1, "Breve Encuentro"),
(3,1, "Breve Encuentro"),
(4,2, "Casablanca"),
(5,2, "Casablanca"),
(6,2, "Casablanca"),
(7,3, "Antes del Amanecer"),
(8,3, "Antes del Amanecer"),
(9,4, "Antes del Atardecer"),
(10,5, "Al Final de la Escapada"),
(11,5, "Al Final de la Escapada"),
(12,5, "Al Final de la Escapada"),
(13,6, "Deseando Amar"),
(14,6, "Deseando Amar"),
(15,7, "El Apartamento"),
(16,7, "El Apartamento"),
(17,7, "El Apartamento"),
(18,8, "Hannah y sus Hermanas"),
(19,8, "Hannah y sus Hermanas"),
(20,8, "Hannah y sus Hermanas"),
(21,9, "¡Olvídate de Mí!"),
(22,9, "¡Olvídate de Mí!"),
(23,9, "¡Olvídate de Mí!"),
(24,10, "Una Habitación con Vistas"),
(25,10, "Una Habitación con Vistas"),
(26,10, "Una Habitación con Vistas");

/*Vista peliculas dirigidas por*/
create view pelicula_dirigida as
(select distinct titulo as pelicula, nombre_director as director from peliculas p join dirigido_por dp on (p.titulo = dp.titulo_pelicula) join directores d on (d.id_director = dp.id_director));

select * from pelicula_dirigida;

/*Vista peliculas aclamadas por la critica con un puntaje mayor a 7.5 en imdb*/
create view aclamadas_critica as
(select distinct titulo as pelicula, puntaje_imdb as puntaje from peliculas p join reseña r on (p.id_pelicula = r.id_pelicula)

where puntaje_imdb > 7.5)
order by puntaje_imdb;

select * from aclamadas_critica;

/*Vista peliculas actores que participaron en la pelicula*/
create view actores_peliculas as
(select distinct nombre_actor as actor, titulo as pelicula from peliculas p join actuo_en ae on (p.titulo = ae.titulo_pelicula) join actores a on (a.id_actor = ae.id_actor));

select * from actores_peliculas;


/*Vista genero de las peliculas*/
create view genero_pelicula as
(select distinct genero, titulo as pelicula from peliculas p join genero_peliculas gp on (p.titulo = gp.titulo_pelicula) join genero g on (g.id_genero = gp.id_genero));

select * from genero_pelicula;

/*Vista peliculas que salieron en los ultimos 50 años*/
create view peliculas_nuevas as
(select distinct titulo as pelicula, año  from peliculas where (año > 1973))
order by año;

select * from peliculas_nuevas;

/*Funcion para saber que director corresponde a cada ID*/
DELIMITER $$
CREATE FUNCTION `directores` (director int)
RETURNS varchar (255)
deterministic reads sql data
BEGIN

RETURN 
(select nombre_director from directores where id_director = director);
END$$

DELIMITER ;

/*Funcion para saber que actor corresponde a cada ID*/
DELIMITER $$
CREATE FUNCTION `actores` (actor int)
RETURNS varchar (255)
deterministic reads sql data
BEGIN

RETURN 
(select nombre_actor from actores where id_actor = actor);
END $$
DELIMITER //

