alter table customers add index idx_customername(customerName);

explain select * from customers where customername = 'Land of Toys Inc.';

alter table customers add index idx_full_name(contactFirstName, contactLastName);


alter table customers drop index idx_full_name;