
/*Carloc Cipriano*/



/*1. user* adm*/ 

CREATE VIEW SQL_Developer AS SELECT * FROM Customers, Offices, Employees;

CREATE USER 'adm'@'localhost';

GRANT DROP, SELECT, DELETE, UPDATE, SUPER, SHUTDOWN, FILE, INDEX, INSERT, LOCK TABLES, PROCESS, RELOAD, EXECUTE ON Cipriano_lab11.* To 'adm'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;

/*OR*/

GRANT ALL PRIVILEGES ON Cipriano_lab11.* To 'adm'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;


/* Role Description / adm: has the role of The role may include capacity planning, installation, 
configuration, database design, migration,performance monitoring, security, troubleshooting, 
as well as backup and data recovery./ Has acess to the whole server to secure, upgrade and backup info.*/


/*2. user* SQL_Developer*/ 

CREATE VIEW SQL_Developer AS SELECT * FROM Customers, Offices, Employees;

CREATE USER 'SQL_Developer'@'localhost';

GRANT SELECT, EXECUTE, FILE, ALTER, PROCESS, INSERT,  DELETE, CREATE, UPDATE ON Cipriano_lab11.* To 'SQL_Developer'@'localhost' IDENTIFIED BY 'password';

/* Role Description / Developer: has the role to test, insert, alter, create, update, create and delete database information. It has configuraion,
creating, testing, alter, update and develpment acess.



/*3. user* Plublic*/ 

CREATE VIEW adm AS SELECT first_name, last_name FROM customers;

CREATE USER 'Public'@'localhost';

GRANT SELECT ON Cipriano_lab11.* To 'Public'@'localhost' IDENTIFIED BY 'password';


/* Role Description / Public: have read only role because they just need to visualize information./ Acess to table info.*/

