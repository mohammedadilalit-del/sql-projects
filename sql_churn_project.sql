--See All Data From Table
select * from bank_churn_data;
--Total Customers 
 select count(churn) as total_customer from bank_churn_data;
 --Avg Utilization Ratio
 select round(avg(utilization_ratio),2)  as avg_ratio  from bank_churn_data;
 --Average Credit Limit
 select round(avg(credit_limit),2) as avg_credit from bank_churn_data;
 --Average Age
 select avg(customer_age) as avg_age from bank_churn_data;
 -- 2. Average Balance by Income Level
 select income, avg(balance)as avg_balance from bank_churn_data
 group by income 
 order by avg_balance desc;
 -- 3. Customers by Marital Status
SELECT marital_status, COUNT(clientnum) AS Customer_Count 
FROM bank_churn_data 
GROUP BY marital_status 
ORDER BY Customer_Count DESC;
-- 4. Customers Segmentation by Age Group
select 
case 
when customer_age between 18 and 25 then '0-25'
when customer_age between 26and 50 then '26-50'
when customer_age between 51 and 75 then '51-75'
else '75+'
end as age_group,
count(clientnum) as total_customer
from bank_churn_data 
group by case 
when customer_age between 18 and 25 then '0-25'
when customer_age between 26and 50 then '26-50'
when customer_age between 51 and 75 then '51-75'
else '75+'
end 
order by total_customer desc;
-- 5. Highest Credit Utilization Customers (Top 10)
select top 10 churn, clientnum, gender, income , marital_status, credit_limit from bank_churn_data 
group by churn, clientnum, gender, income , marital_status, credit_limit 
order by credit_limit desc;
--Customers with High Credit Limit but Low Balance (Top 10)
SELECT TOP 10
    clientnum, 
    customer_age, 
    income, 
    credit_limit, 
    balance, 
    ROUND((balance * 100.0 / credit_limit), 2) AS Balance_Percentage
FROM bank_churn_data
WHERE balance < (0.2 * credit_limit)
ORDER BY Balance_Percentage ASC;
--Customers with the Longest Relationship (Top 10 by Tenure)
select top 10
clientnum, 
    customer_age, 
    income, 
    credit_limit, 
    balance, 
    months_on_book
    from bank_churn_data
    group by clientnum, 
    customer_age, 
    income, 
    credit_limit, 
    balance, 
    months_on_book
    order by months_on_book desc; 
--Average Dependent Count by Income Group
select income,
round(avg(dependent_count) ,2)  as avg_dependent_count 
from bank_churn_data 
group by income ;
--Credit Utilization Index (High-Risk Customers)
select clientnum, 
    customer_age, 
    income, 
    credit_limit, 
    balance, 
    months_on_book,
    round((utilization_ratio*100),2) as utilization_ration, 
    case 
    when utilization_ratio > 0.8 then 'high risk'
    when utilization_ratio between 0.5 and 0.8 then 'moderate risk'
    else 'low risk'
    end as risk_ratio
    from bank_churn_data
    order by utilization_ration desc;
--Longest Relationship Customers (VIP Segmentation)

SELECT 
    clientnum, 
    customer_age, 
    months_on_book, 
    income, 
    balance, 
    credit_limit
FROM bank_churn_data
WHERE months_on_book > 53
ORDER BY balance DESC;







