insert into usuario(nombre,correo,usuario,contrasena,telefono,administrador) values ('Daniel','dagger@estudiantec.cr','dagger','1234','79599499',1);

insert into departamento(nombre) values ('informática');

insert into subDepartamento(nombre,idDepartamento) values ('Postre',1);
insert into subDepartamento(nombre,idDepartamento) values ('Hardware',2);

select * from departamento;