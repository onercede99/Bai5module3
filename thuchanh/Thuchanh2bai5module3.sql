delimiter //

create procedure findallcustomers()

begin select * from customers;

end // 

delimiter ;

call findallcustomers();

delimiter //

drop procedure if exists `findallcustomers`//

create procedure findallcustomers()

begin select * from customers where customernumber = 175;

end // 

