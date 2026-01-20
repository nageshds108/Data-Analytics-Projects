
Use Datawarehouseanalytics;

-- Analyse sales performance over time


SELECT 
  YEAR (ORDER_DATE) AS Order_Year ,
  MONTH(ORDER_DATE)  AS Order_Month,
  Sum(sales_amount) As Total_sales,
  Count(customer_key) as Total_Customers,
  Sum(Quantity) as Total_quantity
from fact_sales
group by order_year, order_month
order by order_year, order_month;


-- running total of sales  And average price over months and years

select order_date,
total_sales,
SUM(total_sales) Over( partition by order_date order by order_date) AS Running_Total_Sales,
AVG(avg_price) Over(order by order_date) AS Moving_average
from
(SELECT DATE_FORMAT(order_date, '%Y-%m-01') AS Order_Date,
Sum(sales_amount) As Total_sales,
Avg(price) as Avg_Price
From fact_sales
Where order_date IS NOT NULL
Group by DATE_FORMAT(order_date, '%Y-%m-01')
Order by DATE_FORMAT(order_date, '%Y-%m-01'))t;


-- Cumulative Analysis

Select 
  order_date,
  total_sales,
  SUM(total_sales) Over(order by order_date) AS Running_Total_Sales,
  AVG(avg_price) Over(order by order_date) AS Moving_average
From
 (SELECT DATE_FORMAT(order_date, '%Y-01-01') AS Order_Date,
   Sum(sales_amount) As Total_sales,
   Avg(price) as Avg_Price
From fact_sales
Where order_date IS NOT NULL
Group by DATE_FORMAT(order_date, '%Y-01-01')
Order by DATE_FORMAT(order_date, '%Y-01-01'))t;