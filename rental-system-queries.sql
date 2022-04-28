-- 1
/*
Inserting new rental record.

Subquery used to obtain customer ID number for Angel.

CURDATE() used to obtain current date.

DATE_ADD() used to add 10 days to current date.
*/
INSERT INTO rental_records VALUES(
NULL,
'SBA1111A',
(
SELECT customer_id
FROM customers
WHERE name = 'Angel'),
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 10 DAY),
NULL
)

-- 2
/* 
Inserting another new rental record.

Subquery used to obtain customer ID number for Kumar.

CURDATE() and DATE_ADD() used again, except this time
there is a DATE_ADD() nested inside to obtain a future date.
*/
INSERT INTO rental_records VALUES(
NULL,
'GA5555E',
(
SELECT customer_id
FROM customers
WHERE name = 'Kumar'
),
DATE_ADD(CURDATE(), INTERVAL 1 DAY),
DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 3 MONTH),
NULL
)

-- 3
/*
This one didn't ask explicitly for category to be displayed,
but it would be really weird to sort by category without also
showing it.
*/
/*
Cross joined all three tables (rental_records, vehicles, customers)
and filter to show only those rows that have matching columns.

Sort results by category then start date.
*/
SELECT 
rental_records.start_date,
rental_records.end_date,
rental_records.veh_reg_no,
vehicles.brand,
vehicles.category,
customers.name
FROM rental_records,
vehicles,
customers
WHERE customers.customer_id = rental_records.customer_id
AND rental_records.veh_reg_no = vehicles.veh_reg_no
ORDER BY category, start_date;

-- 4
/*
Show all records from all rentals that have already ended
before today's date, which was obtained with CURDATE().
*/
SELECT *
FROM rental_records
WHERE end_date < CURDATE();

-- 5
/*
Cross join tables (rental_records and customers) and filter to
show only those rows with matching columns and where 2012-01-10 
is included between the start and end dates.
*/
SELECT
rental_records.veh_reg_no,
customers.name,
start_date,
end_date
FROM rental_records,
customers
WHERE
customers.customer_id = rental_records.customer_id
AND start_date < '2012-01-10'
AND end_date > '2012-01-10';

-- 6
/*
Cross join tables (rental_records and customers) and filter to
show only those rows with matching columns and where today's date, 
obtained using CURDATE() is included between the start and end dates. 

This includes rentals that may still be ongoing.
*/
SELECT
rental_records.veh_reg_no,
customers.name,
start_date,
end_date
FROM rental_records,
customers
WHERE
customers.customer_id = rental_records.customer_id
AND start_date <= CURDATE()
AND end_date >= CURDATE();

-- 7
/*
Cross join tables (rental_records and customers) and filter to
show only those rows with matching columns and show only the 
rental records where the rental period has any amount of overlap
with the date range '2012-01-03' to '2012-01-18'.
*/
SELECT
rental_records.veh_reg_no,
customers.name,
start_date,
end_date
FROM rental_records,
customers
WHERE
customers.customer_id = rental_records.customer_id
AND (
(start_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(end_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(start_date < '2012-01-03' AND end_date > '2012-01-18')
);

-- 8
/*
Perform a LEFT OUTER JOIN of the vehicles and rental_records table, where
the vehicle registration numbers match.

This preserves the vehicle records that do not have any rental records yet.

Filter to only show the records that are NOT INCLUDED in the subquery. 

The subquery returns records whose rental dates overlap with the 
date '2012-01-10'.
*/
SELECT
veh.veh_reg_no,
veh.brand,
veh.desc
FROM vehicles veh
LEFT JOIN rental_records rentRec
ON veh.veh_reg_no = rentRec.veh_reg_no
WHERE veh.veh_reg_no NOT IN (
SELECT veh_reg_no
FROM rental_records
WHERE start_date < '2012-01-10'
AND end_date > '2012-01-10'
);

-- 9
/*
Perform a LEFT OUTER JOIN of the vehicles and rental_records table, where
the vehicle registration numbers match.

This preserves the vehicle records that do not have any rental records yet.

Filter to only show the records that are NOT INCLUDED in the subquery. 

The subquery returns records whose rental dates overlap with the 
date range '2012-01-03' to '2012-01-18'.
*/
SELECT
veh.veh_reg_no,
veh.brand,
veh.desc
FROM vehicles veh
LEFT JOIN rental_records rentRec
ON veh.veh_reg_no = rentRec.veh_reg_no
WHERE veh.veh_reg_no NOT IN (
SELECT
veh_reg_no
FROM rental_records
WHERE (
(start_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(end_date BETWEEN '2012-01-03' AND '2012-01-18')
OR
(start_date < '2012-01-03' AND end_date > '2012-01-18')
)
);

-- 10
/*
Perform a LEFT OUTER JOIN of the vehicles and rental_records table, where
the vehicle registration numbers match.

This preserves the vehicle records that do not have any rental records yet.

Filter to only show the records that are NOT INCLUDED in the subquery. 

The subquery returns records whose rental dates overlap with the 
date range from today to 10 days from now.

CURDATE() used to obtain current date.

DATE_ADD() used to add 10 days to current date.
*/
SELECT
veh.veh_reg_no,
veh.brand,
veh.desc
FROM vehicles veh
LEFT JOIN rental_records rentRec
ON veh.veh_reg_no = rentRec.veh_reg_no
WHERE veh.veh_reg_no NOT IN (
SELECT
veh_reg_no
FROM rental_records
WHERE (
(start_date BETWEEN CURDATE() 
AND 
DATE_ADD(CURDATE(), INTERVAL 10 DAY))
)
);








