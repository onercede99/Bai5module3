create database demo;

use demo;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode INT NOT NULL,
    productName VARCHAR(50) NOT NULL,
    productPrice DECIMAL(15 , 2 ),
    productAmount INT,
    productDescription VARCHAR(255),
    productStatus VARCHAR(50)
);

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus) VALUES
(1001, 'iPhone 15 Pro', 999.99, 50, 'Flagship smartphone with A17 Pro chip', 'In stock'),
(1002, 'Samsung Galaxy S23 Ultra', 1199.99, 35, 'Premium Android phone with S Pen', 'In stock'),
(1003, 'MacBook Pro 14" M2', 1999.00, 20, 'Professional laptop with M2 Pro chip', 'Low stock'),
(1004, 'Dell XPS 15', 1499.99, 15, 'Windows ultrabook with OLED display', 'In stock'),
(1005, 'Sony WH-1000XM5', 399.99, 40, 'Premium noise-cancelling headphones', 'In stock'),
(1006, 'Apple Watch Series 9', 429.00, 0, 'Latest Apple smartwatch with S9 chip', 'Out of stock'),
(1007, 'Logitech MX Master 3S', 99.99, 60, 'Advanced wireless mouse for productivity', 'In stock'),
(1008, 'Bose QuietComfort 45', 329.00, 25, 'Noise-cancelling Bluetooth headphones', 'In stock'),
(1009, 'iPad Air M1', 599.00, 10, 'Thin and light tablet with M1 chip', 'Low stock'),
(1010, 'Amazon Echo Dot 5th Gen', 49.99, 100, 'Smart speaker with Alexa', 'In stock');

alter table Products add index idx_productcode(productCode);

alter table Products add index idx_name_price(productName, productPrice);

explain select * from Products where productCode = 1003;

explain select * from Products 
where productName = 'Samsung Galaxy S23 Ultra' and productPrice = 1999.99;

CREATE VIEW view_product AS
    SELECT 
        productCode, productName, productPrice, productStatus
    FROM
        Products;

alter view view_product as
select productCode, productName,productPrice,productAmount,productStatus
from Products where productStatus IN ('In stock', 'Low stock');

drop view view_product;

delimiter //

create procedure getallproducts()
begin select * from Products;
end //

delimiter ;

call getallproducts();

delimiter //

create procedure addproduct(
in p_productCode int,
in p_productName varchar(50),
in p_productPrice decimal(15,2),
in p_productAmount int,
in p_productDescription varchar(255),
in p_productStatus varchar(50)
)
begin insert into Products(
productCode,
productName,
productPrice,
productAmount,
productDescription,
productStatus
) values (
p_productCode,
p_productName,
p_productPrice,
p_productAmount,
p_productDescription,
p_productStatus
);
SELECT 
    *
FROM
    Products
WHERE
    Id = LAST_INSERT_ID();
end //

delimiter ;

call addproduct(1011, 'Google pixel 7', 699.99,30,'Android smartphone with G2', 'Instock');

delimiter //

create procedure updateproduct(
in p_id int,
in p_productCode int,
in p_productName varchar(50),
in p_productPrice decimal(15,2),
in p_productAmount int,
in p_productDescription varchar(255),
in p_productStatus varchar(50)
)
begin update Products set
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
where Id = p_id ;
select * from Products where Id = p_id;
end //

delimiter //

call updateproduct(5, 1005, 'Sony WH-1000XM5', 349.99, 35, 'Premium noise-cancelling headphones (New Version)', 'In stock');

delimiter //

create procedure deleteproduct(in p_id int)
begin declare product_count int;
select count(*) into product_count from Products where Id = p_id;
if product_count > 0 then 
delete from Products where Id = p_id;
select concat('Product with ID ', p_id, ' has been deleted') as message;
else select concat('Product with ID ', p_id, ' not found') as message;
end if;
end //

delimiter ;

call deleteproduct(8);
