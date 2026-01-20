Use Datawarehouseanalytics;


-- Comparing yearly performance to average sales and previous year sales-- 


With Yearly_product_sales AS (
 Select 
    YEAR(s.order_date) As order_year,
    p.product_name,
    Sum(s.sales_amount) AS current_sales
From fact_sales s 
Left join dim_products p 
On s.product_key=p.product_key
Where s.order_date is not null
Group by year(s.order_date), p.product_name
 )
 Select  
   order_year,
   product_name,
   current_sales,
   Avg(current_sales) over(partition by product_name) AS avg_sales,
   current_sales-avg(current_sales) over(partition by product_name) As diff_avg,
   
 Case when current_sales-avg(current_sales) over(partition by product_name) >0 Then "Above Avergae"
      when current_sales-avg(current_sales) over(partition by product_name) <0 Then "below Avergae"
      else "avg"
End Avg_change,

lag(current_sales) over (partition by product_name order by order_year )as py_year,
current_sales-lag(current_sales) over (partition by product_name order by order_year ) as diff_py,

 case when current_sales-lag(current_sales) over (partition by product_name order by order_year ) >0 Then "Increase"
      when current_sales-lag(current_sales) over (partition by product_name order by order_year ) <0 Then "Decrease"
      else "No Change"
End PY_change

From yearly_product_sales
Order by product_name , order_year;


-- Comparing Monthly performance to average sales and previous year sales-- 


With Monthly_product_sales AS (
Select 
  DATE_FORMAT(s.order_date, '%Y-%m-01') AS order_month,
  p.product_name,
  Sum(s.sales_amount) AS current_sales
  From fact_sales s left join
  dim_products p on s.product_key=p.product_key
  where s.order_date is not null
Group by DATE_FORMAT(s.order_date, '%Y-%m-01'), p.product_name
 )
 Select  
   order_month ,
   product_name, 
   current_sales,
   Avg(current_sales) over(partition by product_name) AS avg_sales,
   current_sales-avg(current_sales) over(partition by product_name) As diff_avg,
 case when current_sales-avg(current_sales) over(partition by product_name) >0 Then "Above Avergae"
      when current_sales-avg(current_sales) over(partition by product_name) <0 Then "below Avergae"
      else "avg"
end Avg_change,

lag(current_sales) over (partition by product_name order by order_month )as py_month,
current_sales-lag(current_sales) over (partition by product_name order by order_month ) as diff_pm,

 case when current_sales-lag(current_sales) over (partition by product_name order by order_month ) >0 Then "Increase"
      when current_sales-lag(current_sales) over (partition by product_name order by order_month ) <0 Then "Decrease"
      else "No Change"
end PM_change

from monthly_product_sales
order by product_name , order_month;
