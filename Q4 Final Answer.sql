/*Query Slide-4: This code is to return the top 10 paying customers and how much their total payments per month*/

WITH Cusinfo AS (SELECT DISTINCT c.customer_id AS CID, 
			   CONCAT(c.first_name,' ',c.last_name) AS Customer_Name, 
			   SUM(p.amount) OVER (PARTITION BY c.customer_id) AS Tot_Pay
			   FROM customer AS c
			   JOIN payment AS p                                                        /* This is a subquery to make a column wiht the full name of the customers, and to return the top 10 paying customers */
			   	ON c.customer_id = p.customer_id
			   ORDER BY 3
			   LIMIT 10),
				


	Payinfo AS (SELECT DISTINCT Customer_ID AS CID, 
			   CONCAT(DATE_PART('month',p.payment_date),'-', DATE_PART('year',p.payment_date)) AS PayDate,
			   COUNT(p.payment_id) AS Total_Orders,
			   SUM(p.amount) AS Total_Pay                                              /* This is a subquery to count for the total orders per month and year, and the sum of the purchases amount per Customer */
			   FROM payment AS p
			   GROUP BY 1, 2)


SELECT Cusinfo.Customer_Name, payinfo.paydate,  payinfo.total_pay
FROM payinfo
JOIN Cusinfo
	ON Cusinfo.CID = payinfo.CID
	ORDER BY 2, 3 DESC;