CREATE VIEW customer_views AS
    SELECT 
        customernumber, customername, phone
    FROM
        customers;
        
SELECT 
    *
FROM
    customer_views;
    
CREATE OR REPLACE VIEW customer_view AS
    SELECT 
        customernumber,
        customername,
        contactfirstname,
        contactlastname,
        phone
    FROM
        customers
    WHERE
        city = 'Nantes';
        
drop view customer_views;
    