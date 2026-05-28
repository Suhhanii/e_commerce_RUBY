
for create database 
CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT,
    uname VARCHAR(20) ,
    pwd VARCHAR(20) ,
    contact INT ,
    email VARCHAR(20) ,
    type VARCHAR(10) ,
    PRIMARY KEY (id),
    KEY (uname)
);

.. tells Ruby to look one folder up

product 
(Primary key)id, name,(Forain Key)category, price, stock
create table product(id int AUTO_INCREMENT PRIMARY KEY, name varchar(20),category varchar(20),price decimal(10,2),stock bigint, FOREIGN KEY (category) REFERENCES category(name));


category
id, (Primary Key)name
create table category(id int AUTO_INCREMENT UNIQUE,name varchar(20) PRIMARY KEY);

cart
create table cart(id int auto_increment PRIMARY KEY,product_id int,quantity int CHECK (quantity >= 0), foreign key (product_id) references product(id));

*global config username and email 
Is It Permanent
change it
unset it
edit .gitconfig
git config --global user.name "Suhani"

*local config username and email , only accessable for local folder 
git config --global user.name "suhani"
git config --global user.email "suhanikaushal57@gmail.com"

*for check local config
git config --list

*for check global config
git config -- global --list



send
method missing
definemethod


for create orders table
create table orders(id int auto_increment primary key,user_id int, status varchar(20),total_amount decimal(10,2),place_at timestamp default current_timestamp, foreign key(user_id) references user(id), foreign key(status) references status(status));

for create order_item table
create table order_item(id int auto_increment primary key,order_id int,product_id int,quantity int,price decimal(10,2),subtotal decimal(10,2), foreign key (product_id) references product(id), foreign key(order_id) references orders(id));

status table 
describe status;;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| status | varchar(20) | NO   | PRI | NULL    |       |
+--------+-------------+-------------------------------

