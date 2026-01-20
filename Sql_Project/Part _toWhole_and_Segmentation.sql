

-- Category wise Contribution-- 


With  Category_sales AS(
 Select 
   category,
   Sum(sales_amount) as total_sales
 from fact_sales f
 Left Join dim_products p on
 f.product_key=p.product_key
 Group by category
)
SELECT 
    category, 
    total_sales,
    SUM(total_sales) OVER() AS overall_sales,
    ROUND((total_sales / SUM(total_sales) OVER()) * 100, 2) AS percentage_contribution
FROM Category_sales
order by total_sales DESC ;



-- Data Segmentation


/*Segment products into cost ranges and 
count how many products fall into each segment*/

With Sales_ranges as (
Select 
  product_key,
  cost,
  product_name,
case 
  when cost<100 then "Below 100"
  when cost>100 And cost<500 then "100-500"
  when cost>500 And cost<1000 then "500-1000"
else "Above 1000"
end Cost_ranges
from dim_products
)
Select 
  cost_ranges,
  sum(Product_key) as Total_products
from Sales_ranges
group by cost_ranges
order by Total_products;


-- Group customers into three segments based on their spending behavior

With Spendings as(
Select 
  c.customer_key,
  Sum(sales_amount) as Total_Spending,
  Min(order_date) as First_order,
  Max(order_date) as Last_order,
  TIMESTAMPDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) as Lifespan
From customers c 
Left join  Fact_sales f 
On c.customer_key =f.customer_key 
group by customer_key
)
Select  
  Customer_segment,
  Count(customer_key) as total_customer
from
( 
select customer_key,
case 
  when lifespan>12 and total_spending>5000 Then "VIP"
  when lifespan>12 and total_spending<5000 Then "Regular"
Else "New"
End Customer_Segment
From Spendings) t
Group by Customer_segment
Order by total_customer;


