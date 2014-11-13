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
login_security_question enum ("What is your mother's maiden name?", "What was the model of your first car?", "What is your pet's name?") not null,
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

create table if not exists category (category_id bigint unsigned auto_increment primary key unique,
category_name varchar(25) not null);

create table if not exists products (product_id bigint unsigned not null auto_increment primary key unique,
category_id bigint unsigned not null,
product_year bigint unsigned not null,
product_make varchar(10) not null,
product_model varchar (20) not null,
product_color varchar (20) not null,
product_cost double unsigned not null,
product_margin double unsigned not null,
product_price double unsigned not null,
constraint category_products_idfk foreign key (category_id) references category (category_id));

create table if not exists sales (sales_id bigint unsigned not null auto_increment primary key unique,
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

create table if not exists invoice (invoice_number bigint unsigned not null auto_increment primary key unique,
sales_id bigint unsigned not null,
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
constraint sales_invoice_idfk foreign key (sales_id) references sales (sales_id),
constraint customer_invoice_idfk foreign key (customer_id) references customer (customer_id),
constraint account_invoice_idfk foreign key (account_number) references account (account_number));

alter table sales add constraint invoice_sales_idfk foreign key (invoice_number) references invoice (invoice_number);


