CREATE TABLE SALESPEOPLE (
    SNUM INT PRIMARY KEY,
    SNAME VARCHAR(50),
    CITY VARCHAR(50),
    COMM DECIMAL(5, 2)
);
SHOW TABLES;
INSERT INTO SALESPEOPLE (SNUM, SNAME, CITY, COMM)
VALUES
    (1001, 'Peel', 'London', 0.12),
    (1002, 'Serres', 'San Jose', 0.13),
    (1004, 'Motika', 'London', 0.11),
    (1007, 'Rafkin', 'Barcelona', 0.15),
    (1003, 'Axelrod', 'New York', 0.10);
SHOW TABLES;
SELECT * FROM SALESPEOPLE;
CREATE TABLE CUST (
    CNUM INT PRIMARY KEY,
    CNAME VARCHAR(50),
    CITY VARCHAR(50),
    RATING INT,
    SNUM INT,
    FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)
);
INSERT INTO CUST (CNUM, CNAME, CITY, RATING, SNUM) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);
SELECT * FROM CUST;
-- Create the ORDERS Table
CREATE TABLE ORDERS (
    ONUM INT PRIMARY KEY,
    AMT DECIMAL(10, 2),
    ODATE DATE,
    CNUM INT,
    SNUM INT,
    FOREIGN KEY (CNUM) REFERENCES CUST(CNUM),
    FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)
);
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES
(3001, 18.69, '1994-10-03', 2008, 1007),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1001),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);
SELECT * FROM ORDERS;
SET FOREIGN_KEY_CHECKS = 1 ;
#1.Display snum,sname,city and comm of all salespeople.
Select snum, sname, city, comm
from SALESPEOPLE;
-- 2.Display all snum without duplicates from all orders.
Select distinct snum 
from ORDERS;
-- 3.Display names and commissions of all salespeople in london.
Select sname,comm from SALESPEOPLE  where city = "London";
-- 4.All customers with rating of 100.
Select cname 
from cust
where rating = 100;
 -- 5.Produce orderno, amount and date form all rows in the order table.
Select onum, amt, odate
from orders;
-- 6.All customers in San Jose, who have rating more than 200.
Select cname
from cust
where rating > 200;
-- 7. All customers who were either located in San Jose or had a rating above 200.
Select cname  from cust
where city = "San Jose" or
           rating > 200;
-- 8.All orders for more than $1000.
Select * 
from orders
where amt > 1000;
 -- 9.Names and citires of all salespeople in london with commission above 0.10.
Select sname, city
from SALESPEOPLE
where comm > 0.10 and
           city = "London";
 -- 10.All customers excluding those with rating <= 100 unless they are located in Rome.
Select cname
from cust
where rating <= 100 or
           city = "Rome";
-- 11. All salespeople either in Barcelona or in london.
Select sname, city
from SALESPEOPLE
where city in ("Barcelona","London");
-- 12.All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
Select sname, comm
from SALESPEOPLE
where comm > 0.10 and comm < 0.12;
-- 13.  All customers with NULL values in city column.
Select cname
from cust
where city is null;
 -- 14.  All orders taken on Oct 3Rd   and Oct 4th  1994.
Select *
 from orders 
where odate in ("03-OCT-94","04-OCT-94");
-- 15.  All customers serviced by peel or Motika.
SELECT C.CNUM, C.CNAME, C.CITY, C.RATING
FROM CUST C
JOIN SALESPEOPLE S ON C.SNUM = S.SNUM
WHERE S.SNAME IN ('Peel', 'Motika');
 -- 16.  All customers whose names begin with a letter from A to B.
    Select CNAME
from cust
where cname like "A%" or
            cname like "B%";
 -- 17.  All orders except those with 0 or NULL value in amt field.
Select onum
from orders
where amt != 0 or
amt is not null;
-- 18.  Count the number of salespeople currently listing orders in the order table.
Select count(distinct snum)
from orders;
-- 19.  Largest order taken by each salesperson, datewise.
Select odate, snum, max(amt)
from orders
group by odate, snum
order by odate,snum;
-- 20.  Largest order taken by each salesperson with order value more than $3000.
Select odate, snum, max(amt)
from orders
where amt > 3000
group by odate, snum
order by odate,snum;


    -- 21.  Which day had the hightest total amount ordered.
SELECT ODATE, SUM(AMT) AS Total_Amount
FROM ORDERS
GROUP BY ODATE
ORDER BY Total_Amount DESC
LIMIT 1;

    
   -- 22.  Count all orders for Oct 3rd.
Select count(*)
from orders
where odate = "94-10-03";
 -- 23.  Count the number of different non NULL city values in customers table.
Select count(distinct city)
from cust;
 --  24.  Select each customer’s smallest order.
Select cnum, min(amt)
from orders
group by cnum;
 -- 25.  First customer in alphabetical order whose name begins with G.
Select min(cname)
from cust
where cname like "G%";
 -- 26.  Get the output like “ For dd/mm/yy there are _ orders.
	SELECT 
    DATE_FORMAT(ODATE, '%d/%m/%y') AS formatted_date,  -- Format the date as dd/mm/yy
    COUNT(ONUM) AS total_orders,                       -- Count the number of orders for each date
    CONCAT('For ', DATE_FORMAT(ODATE, '%d/%m/%y'), ' there are ', COUNT(ONUM), ' orders.') AS order_summary
FROM 
    ORDERS
GROUP BY 
    ODATE
ORDER BY 
    ODATE;

-- 27.  Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
Select onum, snum, amt, amt * 0.12
from orders
order by snum;
--  28.  Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).
Select 'For the city (' || city || '), the highest rating is : (' || 
max(rating) || ')'
from cust
group by city;
 -- 29.  Display the totals of orders for each day and place the results in descending order.
Select odate, count(onum)
from orders
group by odate
order by count(onum);
 -- 30.  All combinations of salespeople and customers who shared a city. (ie same city).
Select sname, cname
from SALESPEOPLE, cust
where SALESPEOPLE.city = cust.city;
 --  31.  Name of all customers matched with the salespeople serving them.
Select cname, sname
from cust, SALESPEOPLE
where cust.snum = SALESPEOPLE.snum;
 -- 32.  List each order number followed by the name of the customer who made the order.
Select onum, cname
from orders, cust
where orders.cnum = cust.cnum;
 -- 33.  Names of salesperson and customer for each order after the order number.
Select onum, sname, cname
from orders, cust, SALESPEOPLE
where orders.cnum = cust.cnum and
           orders.snum =SALESPEOPLE.snum;
 -- 34.  Produce all customer serviced by salespeople with a commission above 12%.
Select cname, sname, comm
from cust, SALESPEOPLE
where comm > 0.12 and
           cust.snum = SALESPEOPLE.snum;
-- 35.  Calculate the amount of the salesperson’s commission on each order with a rating above 100.
Select sname, amt * comm
from orders, cust, SALESPEOPLE
where rating > 100 and
          SALESPEOPLE.snum = cust.snum and
          SALESPEOPLE.snum = orders.snum and
          cust.cnum = orders.cnum;
 -- 36.  Find all pairs of customers having the same rating.
SELECT C1.CNUM AS Customer1, C1.CNAME AS Customer1_Name, C2.CNUM AS Customer2, C2.CNAME AS Customer2_Name, C1.RATING
FROM CUST C1
JOIN CUST C2 ON C1.RATING = C2.RATING
WHERE C1.CNUM < C2.CNUM;
  -- 37.  Find all pairs of customers having the same rating, each pair coming once only.
Select a.cname, b.cname,a.rating
from cust a, cust b
where a.rating = b.rating and
          a.cnum != b.cnum and
  	                a.cnum < b.cnum;
-- 38.  Policy is to assign three salesperson to each customers. Display all such combinations.
SELECT C.CNUM, C.CNAME, S1.SNUM AS SALESPEOPLE1, S1.SNAME AS SALESPEOPLE1_Name,
       S2.SNUM AS SALESPEOPLE2, S2.SNAME AS SALESPEOPLE2_Name,
       S3.SNUM AS SALESPEOPLE3, S3.SNAME AS SALESPEOPLE3_Name
FROM CUST C
JOIN SALESPEOPLE S1 ON C.SNUM = S1.SNUM
JOIN SALESPEOPLE S2 ON C.SNUM != S2.SNUM
JOIN SALESPEOPLE S3 ON C.SNUM != S3.SNUM
WHERE S1.SNUM < S2.SNUM AND S2.SNUM < S3.SNUM;
-- 39.  Display all customers located in cities where salesman serres has customer.
SELECT C.CNUM, C.CNAME, C.CITY, C.RATING
FROM CUST C
WHERE C.CITY IN (
    SELECT C1.CITY
    FROM CUST C1
    JOIN SALESPEOPLE S ON C1.SNUM = S.SNUM
    WHERE S.SNAME = 'Serres'
);
--  40.  Find all pairs of customers served by single salesperson.
Select cname from cust
 where snum in (select snum from cust
                group by snum
                having count(snum) > 1);

Select distinct a.cname
from cust a ,cust b
where a.snum = b.snum and a.rowid != b.rowid;
 --  41.  Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
Select a.sname, b.sname
from SALESPEOPLE a, SALESPEOPLE b
where a.snum > b.snum and
      a.city = b.city;
-- 42.  Produce all pairs of orders by given customer, names that customers and eliminates duplicates.
Select c.cname, a.onum, b.onum
from orders a, orders b, cust c
where a.cnum = b.cnum and 
          a.onum > b.onum and
                      c.cnum = a.cnum;
 -- 43.  Produce names and cities of all customers with the same rating as Hoffman.
Select cname, city
from cust
where rating = (select rating
            		        from cust
              where cname = 'Hoffman')
and cname != 'Hoffman';
-- 44.  Extract all the orders of Motika.
Select Onum
from orders
where snum = ( select snum
   from SALESPEOPLE
   where sname = "Motika");
 -- 45.  All orders credited to the same salesperson who services Hoffman.
Select onum, sname, cname, amt
from orders a, SALESPEOPLE b, cust c
where a.snum = b.snum and
          a.cnum = c.cnum and
          a.snum = ( select snum
 from orders  where cnum = ( select cnum  from cust
                             where cname = "Hoffman"));
-- 46.  All orders that are greater than the average for Oct 4.
Select * 
from orders
where amt > ( select avg(amt) 
                        from orders
                                    where odate = "94-10-03");
 -- 47.  Find average commission of salespeople in london.
Select avg(comm)
from SALESPEOPLE
where city = "London";


-- 48.  Find all orders attributed to salespeople servicing customers in london.
Select snum, cnum 
from orders
where cnum in (select cnum 
  from cust
where city = "London");
-- 49.  Extract commissions of all salespeople servicing customers in London.
Select comm 
from SALESPEOPLE
where snum in (select snum
                          from cust
                          where city = "London");


-- 50.  Find all customers whose cnum is 1000 above the snum of serres.
Select cnum, cname from cust
where cnum > ( select snum+1000 
                          from SALESPEOPLE
                          where sname = "Serres");
 --  51.  Count the customers with rating  above San Jose’s average.
Select cnum, rating
from cust
where rating > ( select avg(rating) 
                           from cust
                           where city = "San Jose");

-- 52 Obtain all orders for the customer named Cisnerous.
SELECT o.*
FROM ORDERS o
JOIN CUST c ON o.CNUM = c.CNUM
WHERE c.CNAME = 'Cisnerous';
-- 53 Produce the names and rating of all customers who have above average orders.
SELECT c.CNAME, c.RATING
FROM CUST c
WHERE c.CNUM IN (
    SELECT o.CNUM
    FROM ORDERS o
    WHERE o.AMT > COALESCE((SELECT AVG(AMT) FROM ORDERS), 0)
);
-- 54 Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT s.SNAME, SUM(o.AMT) AS TotalAmount
FROM SALESPEOPLE s
JOIN ORDERS o ON s.SNUM = o.SNUM
GROUP BY s.SNAME
HAVING SUM(o.AMT) > (SELECT MAX(AMT) FROM ORDERS);
-- 55 Find all customers with order on 3rd Oct
SELECT c.*
FROM CUST c
JOIN ORDERS o ON c.CNUM = o.CNUM
WHERE o.ODATE = '1994-10-03';
-- 56 Find names and numbers of all salesperson who have more than one customer.
SELECT s.SNAME, s.SNUM
FROM SALESPEOPLE s
WHERE s.SNUM IN (
    SELECT SNUM
    FROM CUST
    GROUP BY SNUM
    HAVING COUNT(*) > 1
);
-- 57  Check if the correct salesperson was credited with each sale.
SELECT o.ONUM, o.CNUM, o.SNUM, c.SNUM AS CustomerSalesperson
FROM ORDERS o
JOIN CUST c ON o.CNUM = c.CNUM
WHERE o.SNUM != c.SNUM;
-- 58 Find all orders with above average amounts for their customers.
SELECT o.*
FROM ORDERS o
WHERE o.AMT > (SELECT AVG(AMT) FROM ORDERS WHERE CNUM = o.CNUM);
-- 59  Find the sums of the amounts from order table grouped by date.
SELECT ODATE, SUM(AMT) AS SumAmount
FROM ORDERS
GROUP BY ODATE
HAVING SUM(AMT) > ((SELECT MAX(AMT) FROM ORDERS) + 2000);
-- 60 Find names and numbers of all customers with ratings equal to the maximum for their city.
SELECT c.CNAME, c.CNUM
FROM CUST c
WHERE c.RATING = (
    SELECT MAX(RATING)
    FROM CUST
    WHERE CITY = c.CITY
);
-- 61 Find all salespeople who have customers in their cities who they don’t service.
SELECT DISTINCT s.SNAME
FROM SALESPEOPLE s
JOIN CUST c ON s.SNUM != c.SNUM AND s.CITY = c.CITY;
SELECT s.SNAME
FROM SALESPEOPLE s
WHERE EXISTS (
    SELECT 1
    FROM CUST c
    WHERE c.SNUM != s.SNUM AND c.CITY = s.CITY
);
-- 62 Extract cnum, cname and city from customer table if and only if one or more of the customers in the table are located in San Jose.
SELECT c.CNUM, c.CNAME, c.CITY
FROM CUST c
WHERE EXISTS (SELECT 1 FROM CUST WHERE CITY = 'San Jose');
-- 63 Find salespeople no. who have multiple customers.
SELECT SNUM
FROM CUST
GROUP BY SNUM
HAVING COUNT(*) > 1;
-- 64 Find salespeople number, name and city who have multiple customers.
SELECT s.SNUM, s.SNAME, s.CITY
FROM SALESPEOPLE s
WHERE s.SNUM IN (
    SELECT SNUM
    FROM CUST
    GROUP BY SNUM
    HAVING COUNT(*) > 1
);
-- 65 Find salespeople who serve only one customer.
SELECT s.SNUM, s.SNAME
FROM SALESPEOPLE s
LEFT JOIN CUST c ON s.SNUM = c.SNUM
GROUP BY s.SNUM, s.SNAME
HAVING COUNT(c.CNUM) = 1;
-- 66  Extract rows of all salespeople with more than one current order.
SELECT s.*
FROM SALESPEOPLE s
WHERE s.SNUM IN (
    SELECT SNUM
    FROM ORDERS
    GROUP BY SNUM
    HAVING COUNT(*) > 1
);
-- 67    Find all salespeople who have customers with a rating of 300. (use EXISTS)
SELECT s.*
FROM SALESPEOPLE s
WHERE EXISTS (
    SELECT 1
    FROM CUST c
    WHERE c.SNUM = s.SNUM AND c.RATING = 300
);
-- 68 Find all salespeople who have customers with a rating of 300. (use Join).
SELECT DISTINCT s.*
FROM SALESPEOPLE s
JOIN CUST c ON s.SNUM = c.SNUM
WHERE c.RATING = 300;
-- 69  Select all salespeople with customers located in their cities who are not assigned to them. (use EXISTS).
SELECT s.*
FROM SALESPEOPLE s
WHERE EXISTS (
    SELECT 1
    FROM CUST c
    WHERE c.CITY = s.CITY AND c.SNUM != s.SNUM
);
-- 70  Extract from customers table every customer assigned the a salesperson
SELECT c.*
FROM CUST c
WHERE c.SNUM IN (
    SELECT SNUM
    FROM ORDERS
    GROUP BY SNUM
    HAVING COUNT(DISTINCT CNUM) > 1
);
-- 71 Find salespeople with customers located in their cities ( using both ANY and IN).
SELECT s.*
FROM SALESPEOPLE s
WHERE s.SNUM IN (
    SELECT c.SNUM
    FROM CUST c
    WHERE c.CITY = s.CITY
);
-- 72  Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
SELECT s.*
FROM SALESPEOPLE s
WHERE EXISTS (
    SELECT 1
    FROM CUST c
    WHERE c.SNUM = s.SNUM AND c.CNAME > s.SNAME
);
-- 73   Select customers who have a greater rating than any customer in rome.
SELECT c.*
FROM CUST c
WHERE c.RATING > COALESCE((SELECT MAX(RATING) FROM CUST WHERE CITY = 'Rome'),0);
-- 74 Select all orders that had amounts that were greater that atleast one of the orders from Oct 6th.
SELECT o.*
FROM ORDERS o
WHERE o.AMT > COALESCE((SELECT MIN(AMT) FROM ORDERS WHERE ODATE = '1994-10-06'),0);
-- 75  Find all orders with amounts smaller than any amount for a customer in San Jose. (Both using ANY and without ANY)
SELECT o.*
FROM ORDERS o
WHERE o.AMT < COALESCE((
    SELECT MIN(AMT)
    FROM ORDERS
    WHERE CNUM IN (SELECT CNUM FROM CUST WHERE CITY = 'San Jose')), (SELECT MAX(AMT) from ORDERS) +1);
-- 76 Select those customers whose ratings are higher than every customer in Paris. ( Using both ALL and NOT EXISTS).
SELECT c.*
FROM CUST c
WHERE c.RATING > COALESCE((SELECT MAX(RATING) FROM CUST WHERE CITY = 'Paris'),-1);
-- 77 Select all customers whose ratings are equal to or greater than ANY of the Seeres.
SELECT c.*
FROM CUST c
WHERE c.RATING >= COALESCE((SELECT MIN(RATING) FROM CUST WHERE CNAME = 'Serres'),0);
-- 78 Find all salespeople who have no customers located in their city. ( Both using ANY and ALL)
SELECT o.* FROM ORDERS o WHERE EXISTS (SELECT 1 FROM CUST WHERE CITY = 'London');
-- 79 Find all orders for amounts greater than any for the customers in London
SELECT o.*
FROM ORDERS o
WHERE o.AMT > COALESCE((
    SELECT MIN(AMT)
    FROM ORDERS
    WHERE CNUM IN (SELECT CNUM FROM CUST WHERE CITY = 'London')),0);
-- 80  Find all salespeople and customers located in london.
SELECT SNUM AS ID, SNAME AS Name, CITY, COMM AS Value, NULL AS Rating
FROM SALESPEOPLE
WHERE CITY = 'London'
UNION ALL
SELECT CNUM AS ID, CNAME AS Name, CITY, NULL AS Value, RATING
FROM CUST
WHERE CITY = 'London';
-- 81 For every salesperson, dates on which highest and lowest orders were brought.
SELECT s.SNAME,
    (SELECT ODATE FROM ORDERS WHERE SNUM = s.SNUM ORDER BY AMT DESC LIMIT 1) AS HighestOrderDate,
    (SELECT ODATE FROM ORDERS WHERE SNUM = s.SNUM ORDER BY AMT ASC LIMIT 1) AS LowestOrderDate
FROM SALESPEOPLE s;
-- 82 List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
SELECT s.SNAME,
    CASE
        WHEN EXISTS (SELECT 1 FROM CUST c WHERE c.SNUM = s.SNUM AND c.CITY = s.CITY) THEN 'Has Customers in City'
        ELSE 'No Customers in City'
    END AS CustomerInCity
FROM SALESPEOPLE s;
-- 83 Append strings to the selected fields, indicating weather or not a given salesperson was matched to a customer in his city.
SELECT s.SNAME || ' - ' ||
    CASE
        WHEN EXISTS (SELECT 1 FROM CUST c WHERE c.SNUM = s.SNUM AND c.CITY = s.CITY) THEN 'Matched'
        ELSE 'Not Matched'
    END AS SalespersonMatch
FROM SALESPEOPLE s;
-- 84  Create a union of two queries that shows the names, cities and ratings of all customers. 
SELECT CNAME, CITY, RATING, 'High Rating' AS RatingCategory
FROM CUST
WHERE RATING >= 200
UNION ALL
SELECT CNAME, CITY, RATING, 'Low Rating' AS RatingCategory
FROM CUST
WHERE RATING < 200;
-- 85 Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
SELECT SNAME AS Name, SNUM AS Number
FROM SALESPEOPLE
WHERE SNUM IN (SELECT SNUM FROM ORDERS GROUP BY SNUM HAVING COUNT(*) > 1)
UNION
SELECT CNAME AS Name, CNUM AS Number
FROM CUST
WHERE CNUM IN (SELECT CNUM FROM ORDERS GROUP BY CNUM HAVING COUNT(*) > 1)
ORDER BY Name;
-- 86 Form a union of three queries. Have the first select the snums of all salespeople in San Jose, then second the cnums of all customers in San Jose and the third the onums of all orders on Oct. 3
SELECT SNUM
FROM SALESPEOPLE
WHERE CITY = 'San Jose'
UNION
SELECT CNUM
FROM CUST
WHERE CITY = 'San Jose'
UNION ALL
SELECT ONUM
FROM ORDERS
WHERE ODATE = '1994-10-03';
-- 87 Produce all the salespeople in London who had at least one customer there.
SELECT DISTINCT s.SNAME
FROM SALESPEOPLE s
JOIN CUST c ON s.SNUM = c.SNUM
WHERE s.CITY = 'London' AND c.CITY = 'London';
-- 88  Produce all the salespeople in London who did not have customers there.
SELECT s.SNAME
FROM SALESPEOPLE s
WHERE s.CITY = 'London'
  AND NOT EXISTS (
    SELECT 1
    FROM CUST c
    WHERE s.SNUM = c.SNUM AND c.CITY = 'London'
  );
-- 89  We want to see salespeople matched to their customers without excluding those salespeople
-- First part of the query: Get salespeople with their assigned customers
SELECT S.SNUM, S.SNAME, S.CITY AS SALESPERSON_CITY, C.CNAME AS CUSTOMER_NAME, C.CITY AS CUSTOMER_CITY
FROM SALESPEOPLE S
LEFT OUTER JOIN CUST C ON S.SNUM = C.SNUM
-- UNION to include salespeople with no assigned customers
UNION
-- Second part of the query: Get salespeople with no customers assigned
SELECT S.SNUM, S.SNAME, S.CITY AS SALESPERSON_CITY, NULL AS CUSTOMER_NAME, NULL AS CUSTOMER_CITY
FROM SALESPEOPLE S
WHERE S.SNUM NOT IN (SELECT DISTINCT SNUM FROM CUST);






























































