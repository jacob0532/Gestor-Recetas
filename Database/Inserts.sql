insert into usuario(nombre,correo,usuario,contrasena,telefono,administrador) values ('Daniel','dagger@estudiantec.cr','dagger','1234','79599499',1);

insert into departamento(nombre) values ('informática');

insert into subDepartamento(nombre,idDepartamento) values ('Postre',1);
insert into subDepartamento(nombre,idDepartamento) values ('Hardware',2);
insert into subDepartamento(nombre,idDepartamento) values ('Software',2);

insert into receta(nombre, idArea, idSubarea, descripcion, imagenes) values('Flan',1,2,'postre de leche con caramelo',null);
insert into receta(nombre, idArea, idSubarea, descripcion, imagenes) values('Google Chrome',2,2,'Instalar navegador chrome',null);
insert into receta(nombre, idArea, idSubarea, descripcion, imagenes) values('USB',2,1,'Reparar llave maya',null);

select * from subDepartamento;

SELECT idSubDepartamento, nombre, idDepartamento FROM subDepartamento WHERE idDepartamento=1;
	

select * from receta;
select * from ingrediente;