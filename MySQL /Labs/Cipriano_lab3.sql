/* Use the chinook database to complete this lab. */
/* Unless otherwise noted use explicit syntax for this lab */
/* Insert a comment line with your last name, which lab this is and the date*/ 
/* When you are finished save your work as a .sql script using the convention lastnamelab3.sql */ 
/* Submit this script for grading */

-- put your comment line(s) here  /* 9/16/2018 - Carlos Cipriano



/* 1. Write a select statement that joins the album table to the artist table and returns these columns for every Album in the database: AlbumId, Title, ArtistId, and the artist's Name */

select album.albumid, album.title, artist.artistid, artist.name as 'artist name'
from album 
join artist on album.artistid = artist.artistid;

select * from artist;

/* 2. For each Invoice in the database list the InvoiceId, the InvoiceDate, the CustomerId, and Total. 
Also include the customer's LastName, and Country. Add a clause so that the result is sorted by country A-Z, and within each country by invoice total - largest to smallest.  */

select i.invoiceid, i.invoicedate, c.customerid, i.total, c.lastname, c.country 
from invoice i
join customer c on c.customerid = i.invoiceid
order by country asc, total desc;

/* 3. Write a select statement that joins the invoice table to the invoice_line table and returns these columns: 
InvoiceId, InvoiceDate, CustomerId, Quantity, and UnitPrice. The query should  only return orders for customers 16, 34, 37. */

select distinct i.invoiceid, i.invoicedate, i.customerid, e.quantity, e.unitprice 
from invoice i
join invoiceline e on i.invoiceid = e.invoiceid
where customerid in ('16', '34', '37');

/* 4. Return the same result as question 3, but this time use implicit syntax */

select distinct i.invoiceid, i.invoicedate, i.customerid, e.quantity, e.unitprice 
from invoice i, invoiceline e
where e.invoiceid = i.invoiceid and 
customerid in ('16', '34', '37');

/* 5. Return the same result as question 3, but this time use the USING keyword */

select invoice_id, invoice_date, customer_id, quantity, unite_price from invoice
inner join customer using(costumer_id) where customer_id = '16, 34, 37';

/* 6. Return the same result as question 3, but this time use table aliases, 
you may use implicit syntax, the USING keyword, or any syntax you choose that works,  but use table aliases */ 

select distinct i.invoiceid as invoiceid, i.invoicedate as invoicedate,
i.customerid as customer_id, e.quantity as quantity, e.unitprice as 'unitprice' 
from invoice i, invoiceline e
where e.invoiceid = i.invoiceid and 
customerid in ('16', '34', '37');

/* 7. Write a select statement that joins the album and the track tables. 
Display these columns: AlbumId, Title, TrackId, Name, Composer, and Miliseconds. 
Only return rows where the composer contains the text 'Clapton' */

select a.albumid, a.title, t.trackid, t.name, t.composer, t.milliseconds
from album a
join track t on t.Albumid = a.Albumid 
where composer like '%clapton%';

/* 8. For each row in the invoiceline table return the following information: 
InvoiceId, TrackId, InvoiceDate, , CustomerId, customers' LastName, and Phone */
 
select i.invoiceid, i.trackid, e.invoicedate, c.customerid, c.lastname, c.phone 
from invoiceline i
join invoice e on i.invoiceid = e.invoiceid
join customer c on c.customerid = e.customerid;
 
/* 9. For every employee in the database write a query that shows the EmployeeId, 
the LastName, and the HireDate. If the employee has customers assigned to them display the CustomerId 
and the customer's email address. Sort the list so that employees without customers are listed at the top. 
Note: the tables are joined on a customer column called SupportRepId */

select employee.EmployeeId, employee.lastname, employee.hiredate, customer.customerid, customer.email
from employee 
left join customer on employee.employeeid = customer.supportrepid
order by customerid;

/* 10. Write a query that displays the AlbumId, the album Title, the TrackId, the Composer of the track,  
the MediaTypeId, and the media Name for any track whose composer contains 'Jimmy Page' and whose AlbumId is 44 
 */

select a.albumid, a.title, t.trackid, t.composer, t.mediatypeid, t.name 
from track t
inner join album a on a.albumid = t.albumid
where t.composer regexp 'Jimmy Page' and a.albumid like '44';

/* 11.  Join the customer table to itself so that only customers located in the same city and country 
as other customers are displayed. Display the CustomerId, the City, and Country for each customer. */ 

select distinct c1.customerid, c1.city, c1.country 
from customer c1 
join customer c2 on c1.city = c2.city
and c1.country = c2.country
and c1.firstname <> c2.firstname
order by c1.customerid;

/* 12.	Use the UNION operator to generate a result set consisting of four columns from the invoice table:  
InvoiceId, 
InvoiceDate,
Total,
And a calculated column called Destination: if the Invoice has a Country of USA display the words 'Domestic' otherwise 
display the words 'International'
 */

select 'domestic' as destination, invoiceid, invoicedate, total
from invoice
where billingcountry like 'USA'
union
select 'international' as destination, invoiceid, invoicedate, total
from invoice
where billingcountry not like 'USA';

/* 13. Produce a query that displays the employee FirstName, LastName, Customer FirstName, 
LastName, InvoiceId, InvoiceDate, Total, TrackId, track Name for every row in the invoiceline table.
 Use column aliases to distinguish the customer first and last name and the employee first and last name. */
 
select employee.firstname, employee.lastname, invoice.invoiceid, invoice.invoicedate, invoice.total,
customer.firstname, customer.lastname, track.trackid, track.name as 'track name'
from employee 
join customer on employee.employeeid = customer.supportrepid
join invoice on customer.customerid = invoice.customerid
join invoiceline on invoice.invoiceid = invoiceline.invoiceid
join track on track.trackid = invoiceline.trackid;

/* 14. Write a query that displays the CustomerId, the InvoiceDate, and the Total for any invoice 
that includes a track whose genre is 'Jazz' */

select c.customerid, i.invoicedate, i.total, g.name as 'genre'
from customer c 
join invoice i on i.customerid = c.customerid
join invoiceline l on i.invoiceid = l.invoiceid
join track t on t.trackid = l.trackid
join genre g on t.trackid = g.genreid
where g.name  = 'Jazz';

/* 15. For every artist whose Name starts with 'A' or 'B' display the artist Name, any AlbumId and album Name 
associated with the artists, any TrackId and track Names associated with the artists, and the associated GenreId 
and genre Names associated with the track. Use column aliases to distinguish the four Name columns
(note: there are some artists who have no albumns) */

select artist.name as 'artist name', album.albumid, album.title as 'album name',
track.trackid, track.name as 'track name', genre.genreid, genre.Name as 'genre name'
from artist
left join album on album.artistid = artist.artistid
left join track on track.albumid = album.albumid
left join genre on track.trackid = genre.genreid
where artist.name like 'A%' or artist.name like 'B%';

