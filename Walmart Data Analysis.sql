use walmartsales ;

describe sales ;

select time,
	case 
		when time <= '12:00:00' then 'Morning'
		when time between '12:00:00' and '16:00:00' then 'Afternoon'
        else 'Evening'
    end as 'time_of_day'
 from sales ;
 
 alter table sales add column time_of_day varchar(20) ;

select * from sales ;
update sales 
set time_of_day = 
case 
	when time <= '12:00:00' then 'Morning'
	when time between '12:00:00' and '16:00:00' then 'Afternoon'
	else 'Evening'
end ;

select 
	date,
    dayname(date) as dayname
from sales ;

alter table sales add column dayname varchar(10) ;

update sales set dayname = dayname(date) ;

select dayname from sales ;

select date,monthname(date) from sales ;

alter table sales add column monthname varchar(10) ;
update sales set monthname = monthname(date) ;

select * from sales ;

select distinct city from sales ;

select 
	distinct city,
    branch
from sales 
order by branch
;
# How many unique product lines does the data have?
select distinct product_line 
from sales ;

select payment,count(payment) as count
from sales
group by payment 
order by count desc ;

select product_line,count(product_line) as count
from sales
group by product_line 
order by count desc 
limit 3 ;

select 
	monthname,
	round(sum(total),2) as total_revenue 
from sales 
group by monthname
order by total_revenue desc ;

select monthname,sum(cogs) total_cogs
from sales 
group by monthname
order by total_cogs desc ;

select product_line , round(sum(total),2) as total_revenue
from sales 
group by product_line
order by total_revenue desc;

 select branch,city , round(sum(total),2) as total_revenue
from sales 
group by branch,city
order by total_revenue desc;

select 
	product_line,
    max(tax_pct) as Value
from sales 
group by product_line 
order by value desc ;


select branch,sum(quantity) as qwt
from sales 
group by branch 
having qwt > (select avg(quantity) from sales) ;

select branch,sum(quantity) 
from sales
group by branch ;

select gender,product_line,count(gender) as count
from sales 
group by gender,product_line
order by count desc
;

select avg(rating) from sales ;

select product_line,round(avg(rating),2) as rating
from sales
group by product_line 
order by rating desc ;

SELECT branch, AVG(quantity) as avg_branch FROM sales GROUP BY branch
HAVING avg_branch> (SELECT AVG(quantity) as avg_qtysold FROM sales);

select
	product_line,
    round(avg(total),2) as avg_sales,
    (case
		when AVG(total) > (SELECT AVG(total) FROM sales) then "Good"
        else "Bad"
	end) as remarks
from sales
group by product_line ;

-- Number of sales made in each time of the day per weekday 
select dayname,time_of_day,count(*) as number_of_sales
from sales 
group by dayname,time_of_day ;	

-- Which of the customer types brings the most revenue?
select
	customer_type,
	round(sum(total),2)as total_revenue
from sales
group by customer_type
order by total_revenue;	

-- Which city has the largest tax/VAT percent?
select
	city,
    ROUND(sum(tax_pct), 2) AS total_tax_pct
from sales
group by city 
order by total_tax_pct desc ;

-- Which customer type pays the most in VAT?
select
	customer_type,
	sum(tax_pct) AS total_tax
from sales
group by customer_type
order by total_tax desc ;

-- ------------------------- customers----------------------------

-- How many unique customer types does the data have?
select
	distinct customer_type
from sales ;

-- How many unique payment methods does the data have?
select
	distinct payment
from sales;


-- What is the most common customer type?
select
	customer_type,
	count(*) as customer_count
from sales
group by customer_type
order by customer_count desc;

-- Which customer type buys the most?
select
	customer_type,sum(quantity) as total_quantity
from sales
group by customer_type
order by total_quantity;

-- What is the gender of most of the customers?
SELECT
	gender,
	count(*) as gender_count
from sales
group by gender
order by gender_count desc ;

-- What is the gender distribution per branch?
select branch,gender,count(branch) as count
from sales 
group by branch,gender 
order by branch ;

-- Which time of the day do customers give most ratings?
select time_of_day,count(rating) as highest_rating 
from sales where rating >= 8.0 
group by time_of_day
order by highest_rating desc ;

-- Which time of the day do customers give most ratings per branch?
select time_of_day,branch,count(rating) as highest_rating 
from sales where rating >= 8.0 
group by time_of_day,branch 
order by highest_rating desc ;

-- Which day fo the week has the best avg ratings?
select dayname,avg(rating) as avg_rating
from sales 
group by dayname
;

-- Which day of the week has the best average ratings per branch?
select branch,dayname,avg(rating) as avg_rating
from sales 
group by branch,dayname
order by branch
;

select branch,dayname,rating 
from sales 
where rating >= (select avg(rating) from sales)
order by rating ;