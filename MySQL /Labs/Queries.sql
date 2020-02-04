
/*LAB12 / QUERIES / CARLOS CIPRIANO */

/*USERS: 
1.DBA
2.IT SUPPORT
3.MANAGERS */


/*USER:DBA*/
/*1.:*/
use Cipriano_lab10;

/*2. Find the last updated time of the MySQL Table:*/
SELECT UPDATE_TIME
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'Cipriano_lab10'
AND TABLE_NAME = 'Customer';

/*or*/
	
SHOW TABLE STATUS FROM Cipriano_lab10 LIKE 'Customer';

/*3.Script using Performance_schema:*/
SELECT 
	pl.id 'PROCESS ID'
	,trx.trx_started
	,esh.event_name 'EVENT NAME'
	,esh.sql_text 'SQL'
FROM information_schema.innodb_trx AS trx
INNER JOIN information_schema.processlist pl 
	ON trx.trx_mysql_thread_id = pl.id
INNER JOIN performance_schema.threads th 
	ON th.processlist_id = trx.trx_mysql_thread_id
INNER JOIN performance_schema.events_statements_history esh 
	ON esh.thread_id = th.thread_id
WHERE trx.trx_started < CURRENT_TIME - INTERVAL 59 SECOND
  AND pl.user <> 'system_user'
ORDER BY esh.EVENT_ID;

/*4.Find the size of Database:*/
SELECT 
	table_schema AS Database_Name
	,ROUND(SUM(data_length + index_length) / 1024 / 1024, 1) AS SizeInMB
FROM information_schema.tables
GROUP BY table_schema;


/*5.Find the size of Table:*/
SELECT 
	table_name AS TableName
	,ROUND(((data_length + index_length) / 1024 / 1024), 2) AS SizeInMB
FROM information_schema.TABLES
WHERE table_schema = 'Cipriano_lab10'
AND table_name = 'Offices';

/*6.*/
INSERT INTO Employees (last_name, first_name, email)
VALUES (Gartner, Will, ciprianoeng@gmail.com);


/*7.*/
DELETE last_name, clast_name FROM employee JOIN customer 
WHERE employeeid.employee = employeeid.customer 





/*Queries: user IT Support:*/

/*1.*/
SHOW DATABASES;


/*2.*/
CREATE USER 'localhost' IDENTIFIED BY 'Employee.User';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP
ON employees.*
TO 'localhost';

/*3.*/
SELECT USER, HOST, PASSWORD FROM mysql.user;
SELECT CURRENT_USER();

/*4.*/ 
CREATE VIEW clients AS SELECT * FROM customers;

/*5.*/
UPDATE user 
SET password = PASSWORD('dolphin')
WHERE user = 'DBA' AND 
      host = 'localhost';

/*6.*/
Drop database Cipriano_lab10;

use Cipriano_lab10;


/* Queries: user Managers:*/

/*1.*/
SELECT COLUNMNAME FROM TABLENAME; 
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;

/*2.*/
SELECT 
    SUM(salary)
FROM
    employees
ORDER BY employee_id DESC;

/*3.*/
SELECT COUNT(*) as num
FROM offices
WHERE territory = 'europe';


/*4.*/
SELECT SUM(salary)
FROM employees
WHERE employee_id in (select employee_id FROM customers);


/*5.*/
SELECT e.employee_id, c.customer_id, e.email
FROM employees e 
JOIN customers c ON e.employee_id = c.employee_id
ORDER BY customer_id;



