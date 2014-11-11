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
constraint foreign key (customer_id) references customer (customer_id));

create table if not exists Account (account_number bigint unsigned not null auto_increment primary key unique,
customer_id bigint unsigned not null,
account_bank_number bigint unsigned not null,
account_bank_name varchar(50) not null,
account_credit_line bigint unsigned not null,
account_status enum ("Good Standing", "Past Due", "Delinquent") not null,
account_balance bigint not null,
account_timestamp timestamp not null,
constraint foreign key (customer_id) references customer (customer_id));

create table if not exists invoice (invoice_number bigint unsigned not null auto_increment primary key unique,
sales_id bigint unsigned not null,
customer_id bigint unsigned not null,
account_number bigint unsigned not null,
invoice_session_time timestamp not null,
invoice_price double unsigned not null,
invoice_tax double unsigned not null




);
