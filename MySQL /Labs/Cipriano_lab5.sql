/* Use  the Chinook  database loaded into your installation of
MySQL to complete this assignment. 

Coding summary queries
Insert your queries below the instruction comments.
When you are finished with all of the select statements, save the file as a .sql script using this
naming convention
lastnamelab5.sql.
Submit the .sql file for grading. 
************************************************************************
TEST YOUR QUERIES BEFORE SUBMITTING!!!!
***********************************************************************
If you don't understand the expected results required of a certain question please contact your instructor before you submit the assignment */

/* Carlos Cipriano, 9/29/2018, Lab - 05 */




/*  1. Write a SELECT statement that returns the count of the number of artists in the artist table.*/

select count(*) from artist as num;

/*  2. Write a SELECT statements that displays the highest invoice, lowest invoice, and average invoice of all of the invoices in the invoice table. 
Use the Total to determine each of these. Use column aliases of your choosing for each of these, 
and round the average summary to two decimal places. */

select max(total) as highest_invoice, min(total) as lowest_invoice, round(avg(total), 0) as average_invoice
from invoice; 

/*  3. Count each TrackId that exists in the invoiceline table, but only count each TrackId one time */ 

select distinct count(TrackId) as 'Number of TrackId'
from invoiceline;

/*  4. Provide the total dollar amount of all of the invoices in the invoice table for all invoices with a BillingCountry  of 'Brazil', 'Chile', or 'Argentina' */

select BillingCountry, sum(Total) as Total_dollar_amount
from Invoice 
where BillingCountry in ('Brazil', 'Chile', 'Argentina')
group by BillingCountry with rollup;

/*I put with rollup for fun*/

/* 5. Count the number of invoices by each BillingCountry. 
To count each instance of an invoice in the data you must use a GROUP BY function - display the country name and the counts. */

select BillingCountry,
count(*) as num
from invoice
group by BillingCountry;

/* 6. Count the number of tracks for each genre. Display the GenreId and the Name of the genre as well as the counts. */ 

select genre.genreid, genre.Name as 'Genre', count(trackid) as 'num of trackids'
from track 
join genre  on track.trackid = genre.genreid
group by Genreid;

/*  7. Write a SELECT statement that returns the average length
 of each track by album as shown in the Miliseconds column of the track table, 
 return the AlbumId, the album Title, the ArtistId, and the Name of the artist */

select distinct a.ArtistId, a.AlbumId, a.Title, t.Name, 
avg(Milliseconds) as avg_length
from Track t
Join Album a on a.albumid = t.albumid
group by ArtistId;

/* 8. For each state in the United States that exists in the customer table, determine the number of CustomerId,
 List the State and the number of customers. 
Don't list customers in countries other than the USA.  */

select CustomerId, State, count(*) Number_of_Customers
from Customer
where Country = 'USA'
group by State;

/* 9. Provide the total dollar amount of invoices for each customer in the Invoice table that has more than one invoice, 
return the CustomerId and this totalled amount */ 

select customerid, sum(total) 
from invoice
group by customerid 
having count(total) > 1;

/* 10. Write a SELECT statement that totals all the invoice amounts by SupportRepId. Return the supportrepid and the total. 
Sort the results so that the supportrepid with the largest total of invoices is at the top. */

select SupportRepId, count(*) as Totals
from Customer
Inner Join Invoice using(CustomerId)
group by SupportRepId
order by SupportRepId asc;

/* 11. For each album in the database, display the AlbumId, the album's Name, the shortest track, 
the longest track and the average track length (as shown in the miliseconds column of the track table). */

select AlbumId, Title, min(Milliseconds) as shortest_track , max(Milliseconds) as longest_track , avg(Milliseconds) as average_track
from track
Join Album using(AlbumId)
group by AlbumId, Title;

/* 12. Write a SELECT statement that returns one row for each employee in the employee table. 
Additionally return the count of customers for each employee.
 If the employee has no associated customers  list the employee anyway.
 Display the  employee first name and last name and the  count of customers. */

select e.FirstName, e.LastName, count(customerid) as 'Customer/Employee'
from customer c
left join employee e on e.EmployeeId = c.CustomerId
where c.customerid = e.employeeid 
group by e.FirstName, e.LastName 
order by customerid;

/* 13. Use the ROLLUP function and a group by function to total all invoiceline Quantities by invoice in the invoiceline table 
as well as a grand total of all the quantities. 

Display the InvoiceId and the total Quantity for each invoice as well as the grand total. */

select Invoicelineid, Invoiceid, sum(quantity) as InvoiceLine_Total_Quantity
from invoiceline
group by Invoiceid with rollup;

/*  14. Use two grouping levels and the ROLLUP function to count the number of customers by  country, and within each country by state*/

select CustomerId, Country, State, count(*) number_of_customer
from customer
group by Country, State with rollup;

/* 15. List the top 5 artists in terms of total sales.
 List the artist Name,
 and the sum of all invoices by the artist, 
 biggest (in terms of total sales, to smallest).
 
 Hint : to do this you will need to join artist to album to track to invoiceline to invoice, sum the Total of each invoice, 
 group by the artist name or artistid and sort the list in descending order with a limit clause. */


select r.artistid, r.name, sum(total) as Top_5_Sales
from invoice i
left join invoiceline e
on i.invoiceid = e.invoiceid
join track t on t.trackid = e.trackid
Join album a on a.albumid = t.albumid
join artist r on a.artistid = r.artistid
group by artistid 
order by sum(total) desc limit 5;
