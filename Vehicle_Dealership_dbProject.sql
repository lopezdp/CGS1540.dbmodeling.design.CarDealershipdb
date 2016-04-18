#Group 3 – Project.db
#David Lopez
#mySQL database schema

create database if not exists Vehicle_Dealership_dbProject;

use Vehicle_Dealership_dbProject;

create table if not exists Customer (customer_id bigint unsigned not null auto_increment primary key unique,
customer_first_name varchar (50) not null,
customer_last_name varchar (50) not null,
customer_street varchar (25) not null,
customer_city varchar (25) not null,
customer_state varchar (5) not null,
customer_zip varchar(5) not null,
customer_phone varchar(10) not null,
customer_email varchar(50) not null);

create table if not exists Login (login_id bigint unsigned not null auto_increment primary key unique,
customer_id bigint unsigned not null,
login_user_id varchar(15) not null,
login_user_password varchar(32) not null,
login_salt char(128) not null,
login_security_question enum ("What is your mother's maiden name?", "What was the model of your 
first car?", "What is your pet's name?") not null,
login_security_answer varchar(25) not null,
constraint customer_login_idfk foreign key (customer_id) references customer (customer_id));

create table if not exists Account (account_number bigint unsigned not null auto_increment primary key unique,
customer_id bigint unsigned not null,
account_bank_number bigint unsigned not null,
account_bank_name varchar(50) not null,
account_credit_line bigint unsigned not null,
account_status enum ("Good Standing", "Past Due", "Delinquent") not null,
account_balance bigint not null,
account_timestamp timestamp not null,
constraint customer_account_idfk foreign key (customer_id) references customer (customer_id));

create table if not exists Category (category_id bigint unsigned auto_increment primary key unique,
category_name varchar(25) not null);

create table if not exists Products (product_id bigint unsigned not null auto_increment primary key unique,
category_id bigint unsigned not null,
product_year bigint unsigned not null,
product_make varchar(10) not null,
product_model varchar (20) not null,
product_color varchar (20) not null,
product_cost double unsigned not null,
product_margin double unsigned not null,
product_price double unsigned not null,
constraint category_products_idfk foreign key (category_id) references category (category_id));

create table if not exists Sales (sales_id bigint unsigned not null auto_increment primary key unique,
invoice_number bigint unsigned not null,
customer_id bigint unsigned not null,
product_id bigint unsigned not null,
sales_session_time timestamp not null,
sales_price double unsigned not null,
sales_tax double unsigned not null,
sales_total double unsigned not null,
sales_refunded double unsigned not null,
sales_restock enum ("Item Restocked"),
#constraint invoice_sales_idfk foreign key (invoice_number) references invoice (invoice_number),
constraint customer_sales_idfk foreign key (customer_id) references customer (customer_id),
constraint product_sales_idfk foreign key (product_id) references products (product_id));

create table if not exists Invoice (invoice_number bigint unsigned not null auto_increment primary key unique,
customer_id bigint unsigned not null,
account_number bigint unsigned not null,
invoice_session_time timestamp not null,
invoice_price double unsigned not null,
invoice_tax double unsigned not null,
invoice_total double unsigned not null,
invoice_terminal enum ("Office Terminal", "Online Terminal", "Phone Terminal") not null,
invoice_location enum ("Location 1", "Location 2", "Location 3") not null,
invoice_voided enum ("void"),
invoice_pmt_method enum ("Cash", "Check", "Bill to Account") not null,
constraint customer_invoice_idfk foreign key (customer_id) references Customer (customer_id),
constraint account_invoice_idfk foreign key (account_number) references Account (account_number));

alter table Sales add constraint invoice_sales_idfk foreign key (invoice_number) references invoice (invoice_number);

#insert data
insert into Account values (1,1, 8402554, "Bank of America", 100000, 1, 25000, current_date()),
(2,1, 8402554, "Citibank", 50000, 1, 25000, current_date()),
(3,2, 8444554, "Bank United", 25000, 2, 25000, current_date()),
(4,3, 8402332, "TD Bank", 100000, 3, 125000, current_date()),
(5,2, 1235545, "Chase Bank", 75000, 1, 25000, current_date()),
(6,5, 8841234, "Suntrust", 100000, 1, 25000, current_date()),
(7,2, 7897894, "US Century", 100000, 1, 65000, current_date()),
(8,4, 8654454, "Bank of America", 125000, 1, 25000, current_date()),
(9,3, 3214554, "Bank of America", 200000, 1, 55000, current_date()),
(10,2, 1255554, "TD Bank", 100000, 1, 25000, current_date()),
(11,1, 2516435, "First Financial", 100000, 1, 25000, current_date()),
(12,5, 8251665, "Bank of Delaware", 100000, 1, 25000, current_date()),
(13,1, 9956213, "Bank of America", 100000, 1, 25000, current_date());

INSERT INTO Invoice VALUES(1, 1, 1, current_date(), 9200, 250, 9450, 1, 1, 0, 3), 
(2, 2, 2, current_date(), 3200, 250, 3450, 1, 1, 0, 3), 
(3, 3, 3, current_date(), 5200, 250, 3450, 1, 1, 0, 3), 
(4, 4, 4, current_date(), 7200, 250, 7450, 1, 1, 0, 3), 
(5, 5, 5, current_date(), 4200, 250, 4450, 1, 1, 0, 3), 
(6, 1, 6, current_date(), 6200, 250, 6450, 1, 1, 0, 3), 
(7, 2, 7, current_date(), 5200, 250, 5450, 1, 1, 0, 3), 
(8, 3, 8, current_date(), 9200, 250, 9450, 1, 1, 0, 3), 
(9, 4, 9, current_date(), 6200, 250, 6450, 1, 1, 0, 3), 
(10, 5, 10, current_date(), 3200, 250, 3450, 1, 1, 0, 3); 

insert into Customer values (1, "david", "lopez", "1234 Maple St", "South Bend", "Oh", "33155", "305-555-5555", "abc@msn.com"),
(2, "regina", "wilson", "1234 Pine St", "South Bend", "Oh", "33155", "305-665-5665", "def@msn.com"),
(3, "Jose", "Zapata", "4434 Coconut St", "South Bend", "Oh", "33155", "305-577-5577", "hij@msn.com"),
(4, "Reinaldo", "Seguinot", "5534 Palm Ave", "South Bend", "Oh", "33155", "305-885-5885", "lmn@msn.com"); 

insert into Category values (1, "Exotic Cars"),
(2, "Trucks & SUV"),
(3, "Sedans"),
(4, "Coupe"),
(5, "Compacts");

INSERT INTO Sales(invoice_number, customer_id, product_id, sales_session_time, sales_price, sales_tax, sales_total, sales_refunded, sales_restock) 
VALUES (1, 3, 4, current_time(), 83333, 2333, 106666, 0, 0),
(1, 3, 4, current_time(), 83333, 2333, 106666, 0, 0),
(1, 3, 4, current_time(), 83333, 2333, 106666, 0, 0),
(2, 2, 2, current_date(), 3200, 250, 3450, 0, 0),
(3, 3, 3, current_date(), 5200, 250, 3450, 0, 0),
(3, 3, 3, current_date(), 5200, 250, 3450, 0, 0),
(3, 3, 3, current_date(), 5200, 250, 3450, 0, 0),
(7, 2, 3, current_date(), 6200, 250, 6450, 0, 0);

INSERT INTO Products VALUES(1, 1, 2015, "Ferrari", "458 Spider", "Yellow", 185000, 50000, 235000),
(2, 2, 2014, "Ford", "F150", "White", 20000, 5000, 25000),
(3, 3, 2014, "Lincoln", "LS", "Black", 40000, 10000, 50000),
(4, 4, 2014, "Honda", "Civic", "Green", 17000, 3000, 20000),
(5, 5, 2014, "Toyota", "Prius", "Brown", 16000, 4000, 20000);

SELECT customer_last_name, customer_first_name, Account.account_bank_name, 
Account.account_status, Invoice.invoice_total, product_make, product_model, category_name
FROM Invoice 

JOIN Customer ON Invoice.customer_id = Customer.customer_id 
JOIN Account ON Customer.customer_id = Account.customer_id
JOIN Sales ON Invoice.invoice_number = Sales.invoice_number
JOIN Products ON Sales.product_id = Products.product_id
JOIN Category ON Products.category_id = Category.category_id

ORDER BY 1

SELECT Category.category_name, sum(sales_total) 
FROM Sales 

JOIN Products ON Sales.product_id = Products.product_id
JOIN Category ON Products.category_id = Category.category_id

GROUP BY Products.category_id 
ORDER BY 1;

select Customer.customer_last_name, sum(sales_total)
from Sales

JOIN Customer ON Sales.customer_id = Customer.customer_id

Group by Customer.customer_last_name
Order by 1;

#INSERT sample data

use Vehicle_Dealership_dbProject;
insert into Customer values (1, "david", "lopez", "1234 Maple St", "South Bend", "Oh", "33155", "305-555-5555", "abc@msn.com"),
(2, "regina", "wilson", "1234 Pine St", "South Bend", "Oh", "33155", "305-665-5665", "def@msn.com"),
(3, "Jose", "Zapata", "4434 Coconut St", "South Bend", "Oh", "33155", "305-577-5577", "hij@msn.com"),
(4, "Reinaldo", "Seguinot", "5534 Palm Ave", "South Bend", "Oh", "33155", "305-885-5885", "lmn@msn.com"); 

use Vehicle_Dealership_dbProject;

#account_number, customer_id, account_bank_number, account_bank_name, account_credit_line, 

account_status, account_balance, account_timestamp

insert into Account values (1,1, 8402554, "Bank of America", 100000, 1, 25000, current_date()),

(2,1, 8402554, "Citibank", 50000, 1, 25000, current_date()),

(3,2, 8444554, "Bank United", 25000, 2, 25000, current_date()),

(4,3, 8402332, "TD Bank", 100000, 3, 125000, current_date()),

(5,2, 1235545, "Chase Bank", 75000, 1, 25000, current_date()),

(6,5, 8841234, "Suntrust", 100000, 1, 25000, current_date()),

(7,2, 7897894, "US Century", 100000, 1, 65000, current_date()),

(8,4, 8654454, "Bank of America", 125000, 1, 25000, current_date()),

(9,3, 3214554, "Bank of America", 200000, 1, 55000, current_date()),

(10,2, 1255554, "TD Bank", 100000, 1, 25000, current_date()),

(11,1, 2516435, "First Financial", 100000, 1, 25000, current_date()),

(12,5, 8251665, "Bank of Delaware", 100000, 1, 25000, current_date()),

(13,1, 9956213, "Bank of America", 100000, 1, 25000, current_date());

use Vehicle_Dealership_dbProject;

insert into Category values (1, "Exotic Cars"),

(2, "Trucks & SUV"),

(3, "Sedans"),

(4, "Coupe"),

(5, "Compacts");

INSERT INTO Products VALUES(1, 1, 2015, "Ferrari", "458 Spider", "Yellow", 185000, 50000, 235000),

(2, 2, 2014, "Ford", "F150", "White", 20000, 5000, 25000),

(3, 3, 2014, "Lincoln", "LS", "Black", 40000, 10000, 50000),

(4, 4, 2014, "Honda", "Civic", "Green", 17000, 3000, 20000),

(5, 5, 2014, "Toyota", "Prius", "Brown", 16000, 4000, 20000);

use Vehicle_Dealership_dbProject;

use Vehicle_Dealership_dbProject;

SELECT customer_last_name, customer_first_name, Account.account_bank_name, 

Account.account_status, Invoice.invoice_total, product_make, product_model, category_name

FROM Invoice 

JOIN Customer ON Invoice.customer_id = Customer.customer_id 

JOIN Account ON Customer.customer_id = Account.customer_id

JOIN Sales ON Invoice.invoice_number = Sales.invoice_number

JOIN Products ON Sales.product_id = Products.product_id

JOIN Category ON Products.category_id = Category.category_id

ORDER BY 1;

SELECT Category.category_name, sum(sales_total) 

FROM Sales 

JOIN Products ON Sales.product_id = Products.product_id

JOIN Category ON Products.category_id = Category.category_id

GROUP BY Products.category_id 

ORDER BY 1;

select Customer.customer_last_name, sum(sales_total)

from Sales

JOIN Customer ON Sales.customer_id = Customer.customer_id

Group by Customer.customer_last_name

Order by 1;

SELECT product_make, product_model, product_year, sum(sales_total) 

FROM Sales JOIN Products ON Sales.product_id = Products.product_id 

GROUP BY product_make, product_model, product_year ORDER BY 4 DESC;

SELECT customer_last_name, customer_first_name, account_status, invoice_total, 

invoice_session_time 

FROM Account JOIN Customer ON Account.customer_id = Customer.customer_id JOIN Invoice ON 

Customer.customer_id = Invoice.customer_id 

WHERE account_status = 3;

SELECT * FROM Customer;

SELECT * FROM Products;

INSERT INTO Sales(invoice_number, customer_id, product_id, sales_session_time, sales_price, 

sales_tax, sales_total, sales_refunded, sales_restock) VALUES

(1, 3, 4, current_time(), 83333, 2333, 106666, 0, 0),

(1, 3, 4, current_time(), 83333, 2333, 106666, 0, 0),

(1, 3, 4, current_time(), 83333, 2333, 106666, 0, 0),

(2, 2, 2, current_date(), 3200, 250, 3450, 0, 0),

(3, 3, 3, current_date(), 5200, 250, 3450, 0, 0),

(3, 3, 3, current_date(), 5200, 250, 3450, 0, 0),

(3, 3, 3, current_date(), 5200, 250, 3450, 0, 0),

(7, 2, 3, current_date(), 6200, 250, 6450, 0, 0);

use Vehicle_Dealership_dbProject;

INSERT INTO Invoice VALUES(1, 1, 1, current_date(), 9200, 250, 9450, 1, 1, 0, 3), 

(2, 2, 2, current_date(), 3200, 250, 3450, 1, 1, 0, 3), 

(3, 3, 3, current_date(), 5200, 250, 3450, 1, 1, 0, 3), 

(4, 4, 4, current_date(), 7200, 250, 7450, 1, 1, 0, 3), 

(5, 5, 5, current_date(), 4200, 250, 4450, 1, 1, 0, 3), 

(6, 6, 6, current_date(), 6200, 250, 6450, 1, 1, 0, 3), 

(7, 7, 7, current_date(), 5200, 250, 5450, 1, 1, 0, 3), 

(8, 8, 8, current_date(), 9200, 250, 9450, 1, 1, 0, 3), 

(9, 9, 9, current_date(), 6200, 250, 6450, 1, 1, 0, 3), 

(10, 10, 10, current_date(), 3200, 250, 3450, 1, 1, 0, 3); 

#Joins & Data Reporting

use Vehicle_Dealership_dbProject;

SELECT customer_last_name, customer_first_name, Account.account_bank_name, 

Account.account_status, Invoice.invoice_total, product_make, product_model, category_name

FROM Invoice 

JOIN Customer ON Invoice.customer_id = Customer.customer_id 

JOIN Account ON Customer.customer_id = Account.customer_id

JOIN Sales ON Invoice.invoice_number = Sales.invoice_number

JOIN Products ON Sales.product_id = Products.product_id

JOIN Category ON Products.category_id = Category.category_id

ORDER BY 1;

SELECT Category.category_name, sum(sales_total) 

FROM Sales 

JOIN Products ON Sales.product_id = Products.product_id

JOIN Category ON Products.category_id = Category.category_id

GROUP BY Products.category_id 

ORDER BY 1;

select Customer.customer_last_name, sum(sales_total)

from Sales

JOIN Customer ON Sales.customer_id = Customer.customer_id

Group by Customer.customer_last_name

Order by 1;

SELECT product_make, product_model, product_year, sum(sales_total) 

FROM Sales JOIN Products ON Sales.product_id = Products.product_id 

GROUP BY product_make, product_model, product_year ORDER BY 4 DESC;

SELECT customer_last_name, customer_first_name, account_status, invoice_total, 

invoice_session_time 

FROM Account JOIN Customer ON Account.customer_id = Customer.customer_id JOIN Invoice ON 

Customer.customer_id = Invoice.customer_id 

WHERE account_status = 3;

SELECT * FROM Customer;

SELECT * FROM Products;
