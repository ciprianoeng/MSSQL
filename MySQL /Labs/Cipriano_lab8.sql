
/* lab 8
Compose and test 10 queries that answer the questions below. 
when you are finished submit under the chapter 9 lesson folder. */

-- insert your name date and which lab this is below 
/* Carlos Cipriano 10/19/2018 */


/* 1. Write a select statement that generates a random number, 
the square root, as well as the the floor and the ceiling values 
of for the discount amount from the row in the order items table that
 has an order_id of 1. For the floor and ceiling functions use the discount_amount column, 
 for the rand function use the item_id, for the sqrt function use the product _id */
 
select rand(item_id) as random_number, sqrt(product_id) as square_root,
floor(discount_amount) as floor_value, ceiling(discount_amount) as ceiling_value 
from order_items
where order_id = 1;

/* 2. Use now and curtime functions to display these values on your system */

select now(), curtime();

/* 3. Use the dayofweek function to only return orders shipped on Thursdays or Fridays. 
Display the order_id, customer_id, ship_date, the day of the week, 
and customer last name from the  orders and customers table that meet the criteria */

select ship_date
from orders
where dayofweek(ship_date) like (5) or dayofweek(ship_date) like (6);

/* 4. Display all columns and rows from the products table where the product's date added is in the second quarter of 2012. 
Hint you will need to use two functions in the WHERE clause, YEAR and QUARTER*/

select * 
from products
where year(date_added) like (2012) and quarter(date_added) like (2);

/* 5. Use the extract function to return all orders that were placed after twelve noon on any given day. */

select order_date
from orders
where extract(hour from order_date) >= '12';

/*or*/

select order_date
from orders
where hour(order_date) >= '12';

/* 6. Display the order_id, customer_id, the order_date, ship_date, and the number of days between 
the order_date and ship_date for each order. If an order has no ship_date omit the order */

select order_id, customer_id, order_date, ship_date, datediff(ship_date, order_date) as num_days
from orders
where ship_date is not null;

/* 7. Use a case function to display the following information from the products table. 
The product_id, the list_price, the product_code and the words "No discount", if the the discount_percent is zero, 
"Acceptable discount" if the discount_percent is 15.00, and "High discount" for all others. Name this column Discount_Rating */

select product_id, list_price, product_code, 
case discount_percent
    when '0' then 'no discount' 
    when '15.00' then 'acceptable discount'
    else 'high discount' end as discount_rating
from products;

/* 8. Use the date format function to display the order_ids and order_dates for all orders. 
Display the order_date in this format 10/26/14 06:15:00 PM *, use a column alias of your choice for the formatted date*/

select order_id, date_format(order_date, '%m-%d-%Y  %h:%i:%s %p') as order_date_format
from orders;

/* 9.  USE an IF statement to display the customer_id, the city, state, and the address_id 
as well as the words "pacific time" for the addresses in CA or OR*.
 
Display all addresses in the table and the words "not pacific" if the state is any other than CA or OR */

select customer_id, city, if(state = 'CA' or state = 'OR', 'pacific time', 'not pacific') as geographic_time
from addresses;

/* 10. Replace the null condition with the words "not shipped" in the orders table. 
List all orders and sort the list so that the "not shipped" orders are listed first */

select ifnull(ship_date,'not shipped')
from orders
order by ship_date is null desc;




