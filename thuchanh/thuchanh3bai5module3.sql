delimiter //

create procedure getcusbyid

(in cusnum int(11))

begin select * from customers where customernumber = cusnum;

end //

delimiter ;

call getcusbyid(175);

delimiter //

create procedure getcustomerscountbycity(
in in_city varchar(50),
out total int)

begin select count(customernumber)
into total from customers where city = in_city;
end//

delimiter ;

call getcustomerscountbycity('lyon',@total);
SELECT @total;

delimiter //

create procedure setcounter(
inout counter int,
in inc int
)
begin set counter = counter + inc;
end//
delimiter ;

set @counter =1;
call setcounter(@counter,1);
call setcounter(@counter,1);
call setcounter(@counter,5);
select @counter;