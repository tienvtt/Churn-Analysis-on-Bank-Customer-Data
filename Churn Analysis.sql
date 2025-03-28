create database bank_churn;
use bank_churn;

SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER;
-- EDA 

-- 1. Customer Churn Overview
-- What is the overall churn rate of the bank?
SELECT 
    (SUM(Exited) / COUNT(*)) * 100 AS Churn_Rate 
FROM bank_customers;

-- How many customers have churned, and how many have stayed?
SELECT 
    Exited AS Churn_Status,
    COUNT(*) AS Customer_Count
FROM bank_customers
GROUP BY Exited;

-- 2. Demographic Analysis of Churn
-- Which age groups have the highest churn rates?
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    (SUM(Exited) * 100.0 / COUNT(*)) AS Churn_Rate
FROM bank_customers
GROUP BY Age_Group
ORDER BY Churn_Rate DESC;

-- Does gender affect customer churn? Do males or females churn more?
SELECT 
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    (SUM(Exited) * 100.0 / COUNT(*)) AS Churn_Rate
FROM bank_customers
GROUP BY Gender
ORDER BY Churn_Rate DESC;

-- How does churn vary across different countries (France, Spain, Germany)?
SELECT 
    Geography,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    (SUM(Exited) * 100.0 / COUNT(*)) AS Churn_Rate
FROM bank_customers
GROUP BY Geography
ORDER BY Churn_Rate DESC;

-- 3. Financial and Product-Usage Analysis
-- How does a customer’s credit score impact their likelihood of churning?
SELECT 
    Exited AS Churn_Status,
    AVG(CreditScore) AS Avg_Credit_Score
FROM CUSTOMER
GROUP BY Exited;

-- Does account balance influence churn? Do customers with lower balances churn more?
SELECT 
    CASE 
        WHEN Balance = 0 THEN 'No Balance'
        WHEN Balance BETWEEN 1 AND 50000 THEN 'Low Balance'
        WHEN Balance BETWEEN 50001 AND 100000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS Balance_Category,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    (SUM(Exited) * 100.0 / COUNT(*)) AS Churn_Rate
FROM CUSTOMER
GROUP BY Balance_Category
ORDER BY Churn_Rate DESC;

-- How many bank products do churned customers typically use?
SELECT 
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    (SUM(Exited) * 100.0 / COUNT(*)) AS Churn_Rate
FROM CUSTOMER
GROUP BY NumOfProducts
ORDER BY Churn_Rate DESC;

-- Does having a credit card affect churn?
-- ✅ Are inactive customers more likely to churn?

-- 4. Customer Tenure & Loyalty Analysis
-- Do long-term customers (higher tenure) churn less compared to new customers?
-- At what tenure (years with the bank) do customers tend to churn the most?

-- 5. Salary & Churn Correlation
-- Does a higher estimated salary reduce the likelihood of churn?

-- What is the average salary of churned vs. non-churned customers?
SELECT 
    Exited AS Churn_Status,
    AVG(EstimatedSalary) AS Avg_Salary
FROM CUSTOMER
GROUP BY Exited;

