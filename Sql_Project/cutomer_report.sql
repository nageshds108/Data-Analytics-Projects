Use Datawarehouseanalytics;


Create View Customer_report as
With Base_query as (
Select 
  order_number,
  product_key,
  order_date,
  sales_amount,
  quantity,
  c.customer_key,
  c.customer_number,
  concat(first_name," ",last_name) as Customer_name,
  TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
from fact_sales f 
left join customers c
on c.customer_key=f.customer_key
where order_date And c.customer_key  is Not null
),

Customer_aggregation as

(Select 
customer_key,
customer_number,
customer_name,
age,
Count(distinct order_number) As total_orders,
Sum(sales_amount) As total_sales,
Sum(quantity) As total_quantity,
Count(distinct product_key) As total_products,
Max(order_date) As last_order_date,
TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) As Lifespan
From Base_query
Group By customer_key,
customer_number,
customer_name,
age)
Select
  *,
  -- Product Segmentation
  case 
    when lifespan>12 and total_sales>5000 Then "VIP"
    when lifespan>12 and total_sales<5000 Then "Regular"
    else "New"
  end Customer_Segment,

  case 
    when age<20 then "Under 20"
    when age between 20 and 29 then "20-29"
    when age between 30 and 39  then "30-39"
    when age between 40 and 49  then "40-49"
  else "Above 50"
end Age_group,

-- Recency in months
TIMESTAMPDIFF(month, last_order_date, CURDATE()) AS recency,


  -- Average Order Value
  case 
    when total_sales=0 then 0
    else total_sales/total_orders
  End As avg_order_value,
  
  -- Average Monthly Spend
  case 
    when lifespan=0 then total_sales 
    else total_sales/lifespan
  End As avg_monthly_spend
from customer_aggregation;


SELECT * FROM CUSTOMER_REPORT
