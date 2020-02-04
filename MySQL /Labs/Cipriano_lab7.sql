
/* LAB 7 data types.  
Use the my Guitar Shop database. Insert a comment into a blank editor within the  workbench that includes your name, what lab this is, and the date you submitted the file.  When you are finished with your queries save your work as lastnamelab7.sql and submit  for grading.  */

-- insert your comment here
/* Carlos Cipriano, Lab7 - 10/15/18

/* 1.Write a SELECT statement that returns these columns from the Order_items table.  order_id, item_price, discount_amount  
Use implicit conversion and the CONCAT function to insert a ‘$’ in the front of  the item_price and discount_amount values.  */

select order_id, concat('$', item_price) as item_price, concat('$', discount_amount) as discount_amount
from order_items;

/* 2.Write a SELECT statement that returns these fields from the Order_items table.  
order_id, item_price, discount_amount.  
USE the CONVERT function to explicitly convert the item_price and  discount_amount to characters.  */

select order_id, convert(item_price, char), convert(discount_amount, char)
from order_items
order by order_id;

/* 3.Write a SELECT statement that returns these columns from the Products table:  
The list_price column and a column that uses the FORMAT function 
 to return the list_price column with 1 digit to the right of the decimal  point */

select list_price,  format(list_price, 1)
from products; 

/* 4.Write a SELECT statement that returns these columns from the Products table:  
The list_price column and a column that uses the CAST function to  return the list_price column as an integer */

select list_price, cast(list_price as signed) from products;


 /* 5.  Display all columns and rows from the products table. Use a string function to change the display 
 of the product_code to all capital letters.*/

select product_id, category_id, ucase(product_code) as PRODUCT_CODE, product_name, description, 
list_price, discount_percent, date_added  
from products; 


/* 6  Return these columns from the orders table, customer_id, card_type and card_number. 
Use the substr and lpad functions to render the card number like this 
************9999 */

select customer_id, card_type, lpad(substr(card_number, -4, 10), 15, '*') as card_number from orders;

/* 7. Use the concat_ws function to render to display the customer last_name and first_name in this manner
Lackey, Toby. Also display the customer's email address 
(only list the customers whose email addresses have more than 15 characters) */

select concat_ws(',', last_name, first_name), email_address 
from customers
where length(email_address) = '15'; 

/* 8. Write a select statement that shows the product_id, product_code, the product_name, 
and the description for every product in the products table. Capitalize all of the text in the product_codes, 
and only show the first twenty characters of the product description */

select product_id, ucase(product_code) as PRODUCT_CODE, product_name, substr(description, 1, 20) 
from products;

/* 9. Display the customer_id and the phone_numbers of all addresses in the address table, 
format the phone numbers so that they look like this 123.456.7899 */

select customer_id, replace(phone, '-', '.') as phone_number from addresses;

/* 10. For each product, display the list_price, list_price rounded to 1 decimal place, 
list_price truncated to 1 decimal place, smallest integer >= list_price,
largest integer <= list_price, and a random number between 1 and 10 using the product id as a seed.*/

select list_price, round(list_price, 1), truncate(list_price, 1), ceiling(list_price), floor(list_price), rand(product_id)
from products;
