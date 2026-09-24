CREATE TABLE retail_sales (
    category VARCHAR(50),
    city VARCHAR(100),
    country VARCHAR(100),
    customer_id VARCHAR(30),
    customer_name VARCHAR(100),
    discount NUMERIC(5,2),
    market VARCHAR(50),
    order_date DATE,
    order_id VARCHAR(30),
    order_priority VARCHAR(20),
    product_id VARCHAR(50),
    product_name TEXT,
    profit NUMERIC(12,2),
    quantity INT,
    region VARCHAR(50),
    row_id INT,
    sales NUMERIC(12,2),
    segment VARCHAR(50),
    ship_date DATE,
    ship_mode VARCHAR(30),
    shipping_cost NUMERIC(12,2),
    state VARCHAR(100),
    sub_category VARCHAR(100),

    order_year INT,
    quarter VARCHAR(10),
    month_number INT,
    month_name VARCHAR(20),
    week_number INT,
    day_name VARCHAR(20),
    weekend VARCHAR(10),

    delivery_days INT,
    profit_margin NUMERIC(10,2),

    discount_category VARCHAR(30),
    sales_band VARCHAR(30),
    order_size VARCHAR(30),
    profit_category VARCHAR(30),
    season VARCHAR(20),

    order_count INT,
    customer_type VARCHAR(30)
);

/*==========================================================================================================================================

RetailChainIQ – Master SQL Script

Table of Contents

Part 1 : Data Validation & Business KPIs
Part 2 : Sales Analysis
Part 3 : Customer Analysis
Part 4 : Product Analysis
Part 5 : Regional & Market Analysis
Part 6 : Time Series Analysis
Part 7 : Profit, Discount & Shipping Analysis
Part 8 : Advanced PostgreSQL
Part 9 : Dashboard SQL
Part 10 : Interview SQL

========================================================*/
/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
File Name    : 01_Data_Validation_And_Business_KPIs.sql

Description:
This SQL script performs the initial validation of the RetailChainIQ dataset
and calculates key business KPIs. These queries help verify data quality
before moving into advanced business analysis and dashboard development.

Dataset      : retail_sales
Total Queries: 10

====================================================================================================================*/


/*====================================================================================================
Q1. BUSINESS QUESTION:
How many total transaction records are present in the dataset?

Purpose:
This validates whether the data has been imported successfully.

Expected Output:
One row containing the total number of records.
====================================================================================================*/

SELECT
    COUNT(*) AS total_records
FROM retail_sales;



/*====================================================================================================
Q2. BUSINESS QUESTION:
How many unique customers have placed orders?

Purpose:
Measures the size of the customer base.

Business Use:
Useful for Customer Analytics and Executive Dashboard KPIs.
====================================================================================================*/

SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;



/*====================================================================================================
Q3. BUSINESS QUESTION:
How many unique orders were placed?

Purpose:
Determines the total order volume.

Business Use:
Useful for calculating Average Order Value (AOV).
====================================================================================================*/

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM retail_sales;



/*====================================================================================================
Q4. BUSINESS QUESTION:
How many different products were sold?

Purpose:
Measures product diversity.

Business Use:
Useful for Product Portfolio Analysis.
====================================================================================================*/

SELECT
    COUNT(DISTINCT product_id) AS total_products
FROM retail_sales;



/*====================================================================================================
Q5. BUSINESS QUESTION:
What is the total revenue generated?

Purpose:
Calculates overall company sales.

Business Use:
One of the most important executive KPIs.
====================================================================================================*/

SELECT
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales;



/*====================================================================================================
Q6. BUSINESS QUESTION:
What is the total profit earned?

Purpose:
Calculates the overall business profit.

Business Use:
Executive KPI used to evaluate business performance.
====================================================================================================*/

SELECT
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales;



/*====================================================================================================
Q7. BUSINESS QUESTION:
What is the average sales amount per transaction?

Purpose:
Measures the average value of each transaction.

Business Use:
Useful for identifying customer purchasing behaviour.
====================================================================================================*/

SELECT
    ROUND(AVG(sales),2) AS average_sales_per_transaction
FROM retail_sales;



/*====================================================================================================
Q8. BUSINESS QUESTION:
What is the average profit generated per transaction?

Purpose:
Calculates profitability at the transaction level.

Business Use:
Used to evaluate overall operational efficiency.
====================================================================================================*/

SELECT
    ROUND(AVG(profit),2) AS average_profit_per_transaction
FROM retail_sales;



/*====================================================================================================
Q9. BUSINESS QUESTION:
What is the average discount offered to customers?

Purpose:
Measures the company's overall discount strategy.

Business Use:
Helps determine whether heavy discounting is affecting profitability.
====================================================================================================*/

SELECT
    ROUND(AVG(discount),4) AS average_discount
FROM retail_sales;



/*====================================================================================================
Q10. BUSINESS QUESTION:
What is the average shipping cost per order?

Purpose:
Measures logistics expenses.

Business Use:
Useful for transportation cost optimisation.
====================================================================================================*/

SELECT
    ROUND(AVG(shipping_cost),2) AS average_shipping_cost
FROM retail_sales;
/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
File Name    : 02_Sales_Analysis.sql

Description:
This SQL script analyses sales performance across different business
dimensions such as category, sub-category, geography, customer segment,
and products.

Dataset      : retail_sales
Total Queries: 15

====================================================================================================================*/


/*====================================================================================================
Q11. BUSINESS QUESTION:
Which product categories generate the highest total sales?

Purpose:
Identify the best-performing product categories.

Business Use:
Helps management allocate inventory and marketing budgets.
====================================================================================================*/

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;



/*====================================================================================================
Q12. BUSINESS QUESTION:
Which sub-categories generate the highest revenue?

Purpose:
Identify the best-selling sub-categories.

Business Use:
Useful for assortment planning.
====================================================================================================*/

SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY sub_category
ORDER BY total_sales DESC;



/*====================================================================================================
Q13. BUSINESS QUESTION:
Which customer segment contributes the highest revenue?

Purpose:
Measure sales contribution by customer segment.

Business Use:
Helps identify the most valuable customer group.
====================================================================================================*/

SELECT
    segment,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY segment
ORDER BY total_sales DESC;



/*====================================================================================================
Q14. BUSINESS QUESTION:
Which market generates the highest sales?

Purpose:
Evaluate market performance.

Business Use:
Supports regional expansion decisions.
====================================================================================================*/

SELECT
    market,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY market
ORDER BY total_sales DESC;



/*====================================================================================================
Q15. BUSINESS QUESTION:
Which region generates the highest sales?

Purpose:
Compare regional sales performance.

Business Use:
Useful for regional business strategy.
====================================================================================================*/

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY region
ORDER BY total_sales DESC;



/*====================================================================================================
Q16. BUSINESS QUESTION:
Which countries contribute the highest revenue?

Purpose:
Rank countries by total sales.

Business Use:
Supports international business planning.
====================================================================================================*/

SELECT
    country,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY country
ORDER BY total_sales DESC;



/*====================================================================================================
Q17. BUSINESS QUESTION:
Which states generate the highest revenue?

Purpose:
Identify top-performing states.

Business Use:
Supports local marketing strategies.
====================================================================================================*/

SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY state
ORDER BY total_sales DESC
LIMIT 20;



/*====================================================================================================
Q18. BUSINESS QUESTION:
Which cities generate the highest sales?

Purpose:
Identify top-performing cities.

Business Use:
Useful for city-level sales strategy.
====================================================================================================*/

SELECT
    city,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY city
ORDER BY total_sales DESC
LIMIT 20;



/*====================================================================================================
Q19. BUSINESS QUESTION:
Which products generate the highest revenue?

Purpose:
Identify the highest-selling products.

Business Use:
Supports inventory optimisation.
====================================================================================================*/

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 20;



/*====================================================================================================
Q20. BUSINESS QUESTION:
Which products generate the lowest sales?

Purpose:
Identify underperforming products.

Business Use:
Useful for product rationalisation.
====================================================================================================*/

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY product_name
ORDER BY total_sales ASC
LIMIT 20;



/*====================================================================================================
Q21. BUSINESS QUESTION:
What are the top 10 customers by sales?

Purpose:
Identify high-value customers.

Business Use:
Useful for loyalty and retention programmes.
====================================================================================================*/

SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;



/*====================================================================================================
Q22. BUSINESS QUESTION:
What is the average sales amount by category?

Purpose:
Measure average transaction value within each category.

Business Use:
Useful for pricing analysis.
====================================================================================================*/

SELECT
    category,
    ROUND(AVG(sales),2) AS average_sales
FROM retail_sales
GROUP BY category
ORDER BY average_sales DESC;



/*====================================================================================================
Q23. BUSINESS QUESTION:
Which shipping mode handles the highest sales?

Purpose:
Evaluate shipping channel performance.

Business Use:
Supports logistics optimisation.
====================================================================================================*/

SELECT
    ship_mode,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY ship_mode
ORDER BY total_sales DESC;



/*====================================================================================================
Q24. BUSINESS QUESTION:
Which order priority contributes the highest sales?

Purpose:
Analyse revenue by order priority.

Business Use:
Helps understand operational priorities.
====================================================================================================*/

SELECT
    order_priority,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY order_priority
ORDER BY total_sales DESC;



/*====================================================================================================
Q25. BUSINESS QUESTION:
What percentage of total sales does each category contribute?

Purpose:
Measure category contribution to total revenue.

Business Use:
Useful for executive dashboards and Pareto analysis.
====================================================================================================*/

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(
        (SUM(sales) * 100.0) /
        (SELECT SUM(sales) FROM retail_sales),
        2
    ) AS sales_percentage
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

====================================================================================================================*/
/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
File Name    : 03_Customer_Analysis.sql

Description:
This SQL script analyses customer behaviour, purchasing patterns,
customer value, and customer segmentation.

Dataset      : retail_sales
Total Queries: 15

====================================================================================================================*/


/*====================================================================================================
Q26. BUSINESS QUESTION:
Which customers generated the highest sales?

Purpose:
Identify top revenue-generating customers.

Business Use:
Useful for loyalty programmes and VIP customer identification.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 20;



/*====================================================================================================
Q27. BUSINESS QUESTION:
Which customers generated the highest profit?

Business Use:
Identify the most profitable customers.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 20;



/*====================================================================================================
Q28. BUSINESS QUESTION:
Which customers placed the highest number of orders?

Business Use:
Identify repeat customers.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY total_orders DESC
LIMIT 20;



/*====================================================================================================
Q29. BUSINESS QUESTION:
What is the Average Order Value (AOV) for each customer?

Business Use:
Measure customer spending behaviour.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS average_order_value
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY average_order_value DESC;



/*====================================================================================================
Q30. BUSINESS QUESTION:
Which customers purchased the highest quantity of products?

Business Use:
Identify bulk buyers.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY total_quantity DESC
LIMIT 20;



/*====================================================================================================
Q31. BUSINESS QUESTION:
How many customers belong to each customer segment?

Business Use:
Understand customer segmentation.
====================================================================================================*/

SELECT
    segment,
    COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales
GROUP BY segment
ORDER BY total_customers DESC;



/*====================================================================================================
Q32. BUSINESS QUESTION:
What is the total sales generated by each customer segment?

Business Use:
Measure segment contribution.
====================================================================================================*/

SELECT
    segment,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY segment
ORDER BY total_sales DESC;



/*====================================================================================================
Q33. BUSINESS QUESTION:
Which customer segment generates the highest profit?

Business Use:
Identify the most profitable segment.
====================================================================================================*/

SELECT
    segment,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY segment
ORDER BY total_profit DESC;



/*====================================================================================================
Q34. BUSINESS QUESTION:
Which customer type contributes the highest sales?

Business Use:
Analyse newly engineered customer categories.
====================================================================================================*/

SELECT
    customer_type,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY customer_type
ORDER BY total_sales DESC;



/*====================================================================================================
Q35. BUSINESS QUESTION:
Which customer type generates the highest profit?

Business Use:
Compare profitability across customer types.
====================================================================================================*/

SELECT
    customer_type,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY customer_type
ORDER BY total_profit DESC;



/*====================================================================================================
Q36. BUSINESS QUESTION:
What is the average sales value for each customer segment?

Business Use:
Evaluate customer spending by segment.
====================================================================================================*/

SELECT
    segment,
    ROUND(AVG(sales),2) AS average_sales
FROM retail_sales
GROUP BY segment
ORDER BY average_sales DESC;



/*====================================================================================================
Q37. BUSINESS QUESTION:
Which customers received the highest total discount?

Business Use:
Identify customers receiving heavy discounts.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(discount),2) AS total_discount
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY total_discount DESC
LIMIT 20;



/*====================================================================================================
Q38. BUSINESS QUESTION:
Which customers incurred the highest shipping cost?

Business Use:
Analyse logistics costs by customer.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY total_shipping_cost DESC
LIMIT 20;



/*====================================================================================================
Q39. BUSINESS QUESTION:
Which customers generated a loss (negative profit)?

Business Use:
Identify unprofitable customer relationships.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY customer_id, customer_name
HAVING SUM(profit) < 0
ORDER BY total_profit;



/*====================================================================================================
Q40. BUSINESS QUESTION:
Rank customers based on total sales.

Business Use:
Identify the highest-value customers using SQL ranking.
====================================================================================================*/

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY sales_rank;
====================================================================================================================*/
/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
Part         : 4
File Name    : 04_Product_Analysis.sql

Description:
This SQL script analyses product performance, profitability,
sales contribution, and inventory-related insights.

Dataset      : retail_sales
Total Queries: 15

====================================================================================================================*/


/*====================================================================================================
Q41. BUSINESS QUESTION:
Which products generated the highest total profit?

Business Use:
Identify the most profitable products.
====================================================================================================*/

SELECT
    product_id,
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY product_id, product_name
ORDER BY total_profit DESC
LIMIT 20;



/*====================================================================================================
Q42. BUSINESS QUESTION:
Which products generated the lowest profit?

Business Use:
Identify loss-making or low-margin products.
====================================================================================================*/

SELECT
    product_id,
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY product_id, product_name
ORDER BY total_profit ASC
LIMIT 20;



/*====================================================================================================
Q43. BUSINESS QUESTION:
Which products sold the highest quantity?

Business Use:
Identify fast-moving products.
====================================================================================================*/

SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY product_id, product_name
ORDER BY total_quantity DESC
LIMIT 20;



/*====================================================================================================
Q44. BUSINESS QUESTION:
Which products sold the lowest quantity?

Business Use:
Identify slow-moving products.
====================================================================================================*/

SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY product_id, product_name
ORDER BY total_quantity ASC
LIMIT 20;



/*====================================================================================================
Q45. BUSINESS QUESTION:
What is the average sales amount for each product category?

Business Use:
Compare average sales across categories.
====================================================================================================*/

SELECT
    category,
    ROUND(AVG(sales),2) AS average_sales
FROM retail_sales
GROUP BY category
ORDER BY average_sales DESC;



/*====================================================================================================
Q46. BUSINESS QUESTION:
What is the average profit for each sub-category?

Business Use:
Evaluate profitability across sub-categories.
====================================================================================================*/

SELECT
    sub_category,
    ROUND(AVG(profit),2) AS average_profit
FROM retail_sales
GROUP BY sub_category
ORDER BY average_profit DESC;



/*====================================================================================================
Q47. BUSINESS QUESTION:
Which product categories have the highest total quantity sold?

Business Use:
Understand customer demand by category.
====================================================================================================*/

SELECT
    category,
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY category
ORDER BY total_quantity DESC;



/*====================================================================================================
Q48. BUSINESS QUESTION:
Which sub-categories receive the highest average discount?

Business Use:
Analyse pricing and promotional strategies.
====================================================================================================*/

SELECT
    sub_category,
    ROUND(AVG(discount),4) AS average_discount
FROM retail_sales
GROUP BY sub_category
ORDER BY average_discount DESC;



/*====================================================================================================
Q49. BUSINESS QUESTION:
Which products received the highest total discount?

Business Use:
Identify heavily discounted products.
====================================================================================================*/

SELECT
    product_name,
    ROUND(SUM(discount),2) AS total_discount
FROM retail_sales
GROUP BY product_name
ORDER BY total_discount DESC
LIMIT 20;



/*====================================================================================================
Q50. BUSINESS QUESTION:
Which products incurred the highest shipping cost?

Business Use:
Analyse logistics cost by product.
====================================================================================================*/

SELECT
    product_name,
    ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail_sales
GROUP BY product_name
ORDER BY total_shipping_cost DESC
LIMIT 20;



/*====================================================================================================
Q51. BUSINESS QUESTION:
What percentage of total sales does each category contribute?

Business Use:
Support executive dashboards and Pareto analysis.
====================================================================================================*/

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(
        SUM(sales) * 100.0 /
        (SELECT SUM(sales) FROM retail_sales),
        2
    ) AS sales_percentage
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;



/*====================================================================================================
Q52. BUSINESS QUESTION:
Which products have generated negative profit?

Business Use:
Identify products that consistently lose money.
====================================================================================================*/

SELECT
    product_id,
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY product_id, product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;



/*====================================================================================================
Q53. BUSINESS QUESTION:
Rank products based on total sales.

Business Use:
Identify the highest-selling products.
====================================================================================================*/

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM retail_sales
GROUP BY product_name
ORDER BY sales_rank;



/*====================================================================================================
Q54. BUSINESS QUESTION:
Rank products based on total profit.

Business Use:
Identify the most profitable products.
====================================================================================================*/

SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit,
    DENSE_RANK() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
FROM retail_sales
GROUP BY product_name
ORDER BY profit_rank;



/*====================================================================================================
Q55. BUSINESS QUESTION:
Which product category has the highest profit margin?

Business Use:
Compare category profitability.

Profit Margin = (Profit / Sales) × 100
====================================================================================================*/

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(
        (SUM(profit) * 100.0) / NULLIF(SUM(sales),0),
        2
    ) AS profit_margin_percentage
FROM retail_sales
GROUP BY category
ORDER BY profit_margin_percentage DESC;



/*====================================================================================================================
/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
Part         : 5
File Name    : 05_Regional_Market_Analysis.sql

Description:
This SQL script analyses sales and profitability across markets,
regions, countries, states, and cities to support business expansion
and regional performance evaluation.

Dataset      : retail_sales
Total Queries: 15

====================================================================================================================*/


/*====================================================================================================
Q56. BUSINESS QUESTION:
Which markets generate the highest total sales?

Business Use:
Identify the strongest performing markets.
====================================================================================================*/

SELECT
    market,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY market
ORDER BY total_sales DESC;



/*====================================================================================================
Q57. BUSINESS QUESTION:
Which markets generate the highest profit?

Business Use:
Measure market profitability.
====================================================================================================*/

SELECT
    market,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY market
ORDER BY total_profit DESC;



/*====================================================================================================
Q58. BUSINESS QUESTION:
Which regions generate the highest sales?

Business Use:
Compare regional sales performance.
====================================================================================================*/

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY region
ORDER BY total_sales DESC;



/*====================================================================================================
Q59. BUSINESS QUESTION:
Which regions generate the highest profit?

Business Use:
Evaluate regional profitability.
====================================================================================================*/

SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY region
ORDER BY total_profit DESC;



/*====================================================================================================
Q60. BUSINESS QUESTION:
Which countries generate the highest sales?

Business Use:
Identify the best-performing countries.
====================================================================================================*/

SELECT
    country,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY country
ORDER BY total_sales DESC
LIMIT 20;



/*====================================================================================================
Q61. BUSINESS QUESTION:
Which countries generate the highest profit?

Business Use:
Measure country-level profitability.
====================================================================================================*/

SELECT
    country,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY country
ORDER BY total_profit DESC
LIMIT 20;



/*====================================================================================================
Q62. BUSINESS QUESTION:
Which states generate the highest sales?

Business Use:
Evaluate state-level business performance.
====================================================================================================*/

SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY state
ORDER BY total_sales DESC
LIMIT 20;



/*====================================================================================================
Q63. BUSINESS QUESTION:
Which cities generate the highest sales?

Business Use:
Identify top-performing cities.
====================================================================================================*/

SELECT
    city,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY city
ORDER BY total_sales DESC
LIMIT 20;



/*====================================================================================================
Q64. BUSINESS QUESTION:
Which cities generate the highest profit?

Business Use:
Measure city-level profitability.
====================================================================================================*/

SELECT
    city,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY city
ORDER BY total_profit DESC
LIMIT 20;



/*====================================================================================================
Q65. BUSINESS QUESTION:
Which regions sold the highest quantity of products?

Business Use:
Understand regional demand.
====================================================================================================*/

SELECT
    region,
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY region
ORDER BY total_quantity DESC;



/*====================================================================================================
Q66. BUSINESS QUESTION:
Which markets offer the highest average discount?

Business Use:
Analyse promotional strategies across markets.
====================================================================================================*/

SELECT
    market,
    ROUND(AVG(discount),4) AS average_discount
FROM retail_sales
GROUP BY market
ORDER BY average_discount DESC;



/*====================================================================================================
Q67. BUSINESS QUESTION:
Which regions incur the highest shipping cost?

Business Use:
Optimise logistics and transportation expenses.
====================================================================================================*/

SELECT
    region,
    ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail_sales
GROUP BY region
ORDER BY total_shipping_cost DESC;



/*====================================================================================================
Q68. BUSINESS QUESTION:
What is the profit margin for each market?

Business Use:
Compare market profitability.

Formula:
(Profit / Sales) × 100
====================================================================================================*/

SELECT
    market,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(
        (SUM(profit) * 100.0) / NULLIF(SUM(sales),0),
        2
    ) AS profit_margin_percentage
FROM retail_sales
GROUP BY market
ORDER BY profit_margin_percentage DESC;



/*====================================================================================================
Q69. BUSINESS QUESTION:
Rank countries based on total sales.

Business Use:
Identify top-performing countries using window functions.
====================================================================================================*/

SELECT
    country,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS country_sales_rank
FROM retail_sales
GROUP BY country
ORDER BY country_sales_rank;



/*====================================================================================================
Q70. BUSINESS QUESTION:
Which region performs best within each market?

Business Use:
Identify the top region inside every market.
====================================================================================================*/

SELECT *
FROM (
    SELECT
        market,
        region,
        ROUND(SUM(sales),2) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY market
            ORDER BY SUM(sales) DESC
        ) AS region_rank
    FROM retail_sales
    GROUP BY market, region
) ranked_regions
WHERE region_rank = 1;


/*====================================================================================================================
ALTER TABLE retail_sales
ALTER COLUMN order_date TYPE DATE
USING TO_DATE(order_date, 'DD-MM-YYYY');


/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
Part         : 7
File Name    : 07_Profit_Discount_Shipping_Analysis.sql

Description:
This SQL script analyzes profitability, discounts, and shipping costs
to identify opportunities for cost optimization and profit improvement.

Dataset      : retail_sales
Total Queries: 15

====================================================================================================================*/


/*====================================================================================================
Q86. BUSINESS QUESTION:
What is the overall profit margin of the business?

Business Use:
Measure the company's overall profitability.

Formula:
Profit Margin = (Profit / Sales) × 100
====================================================================================================*/

SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(
        (SUM(profit) * 100.0) / NULLIF(SUM(sales),0),
        2
    ) AS profit_margin_percentage
FROM retail_sales;



/*====================================================================================================
Q87. BUSINESS QUESTION:
Which categories generate the highest profit margin?

====================================================================================================*/

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(
        (SUM(profit) * 100.0) /
        NULLIF(SUM(sales),0),
        2
    ) AS profit_margin
FROM retail_sales
GROUP BY category
ORDER BY profit_margin DESC;



/*====================================================================================================
Q88. BUSINESS QUESTION:
Which sub-categories are operating at a loss?

====================================================================================================*/

SELECT
    sub_category,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;



/*====================================================================================================
Q89. BUSINESS QUESTION:
Which regions are generating negative profit?

====================================================================================================*/

SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY region
HAVING SUM(profit) < 0
ORDER BY total_profit;



/*====================================================================================================
Q90. BUSINESS QUESTION:
Which products are heavily discounted?

====================================================================================================*/

SELECT
    product_name,
    ROUND(AVG(discount),4) AS average_discount
FROM retail_sales
GROUP BY product_name
ORDER BY average_discount DESC
LIMIT 20;



/*====================================================================================================
Q91. BUSINESS QUESTION:
Which products have high discounts but low profits?

====================================================================================================*/

SELECT
    product_name,
    ROUND(AVG(discount),4) AS average_discount,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY product_name
ORDER BY average_discount DESC, total_profit ASC
LIMIT 20;



/*====================================================================================================
Q92. BUSINESS QUESTION:
Which shipping mode incurs the highest shipping cost?

====================================================================================================*/

SELECT
    ship_mode,
    ROUND(SUM(shipping_cost),2) AS total_shipping_cost
FROM retail_sales
GROUP BY ship_mode
ORDER BY total_shipping_cost DESC;



/*====================================================================================================
Q93. BUSINESS QUESTION:
Which shipping mode generates the highest profit?

====================================================================================================*/

SELECT
    ship_mode,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY ship_mode
ORDER BY total_profit DESC;



/*====================================================================================================
Q94. BUSINESS QUESTION:
Which categories receive the highest average discount?

====================================================================================================*/

SELECT
    category,
    ROUND(AVG(discount),4) AS average_discount
FROM retail_sales
GROUP BY category
ORDER BY average_discount DESC;



/*====================================================================================================
Q95. BUSINESS QUESTION:
Which customer segments receive the highest discounts?

====================================================================================================*/

SELECT
    segment,
    ROUND(AVG(discount),4) AS average_discount
FROM retail_sales
GROUP BY segment
ORDER BY average_discount DESC;



/*====================================================================================================
Q96. BUSINESS QUESTION:
How many transactions are profitable vs loss-making?

====================================================================================================*/

SELECT
    CASE
        WHEN profit >= 0 THEN 'Profitable'
        ELSE 'Loss'
    END AS transaction_status,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY transaction_status;



/*====================================================================================================
Q97. BUSINESS QUESTION:
Classify orders based on sales amount.

====================================================================================================*/

SELECT
    CASE
        WHEN sales >= 1000 THEN 'High Value'
        WHEN sales >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_category,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY order_category
ORDER BY total_orders DESC;



/*====================================================================================================
Q98. BUSINESS QUESTION:
Which orders generated the highest profit?

====================================================================================================*/

SELECT
    order_id,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY order_id
ORDER BY total_profit DESC
LIMIT 20;



/*====================================================================================================
Q99. BUSINESS QUESTION:
Which orders generated the highest losses?

====================================================================================================*/

SELECT
    order_id,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY order_id
ORDER BY total_profit ASC
LIMIT 20;



/*====================================================================================================
Q100. BUSINESS QUESTION:
What percentage of orders are profitable?

====================================================================================================*/

SELECT
    ROUND(
        COUNT(CASE WHEN profit >= 0 THEN 1 END) * 100.0 /
        COUNT(*),
        2
    ) AS profitable_order_percentage
FROM retail_sales;



/*====================================================================================================================

/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
Part         : 8
File Name    : 08_Advanced_PostgreSQL.sql

Description:
Advanced PostgreSQL analysis using CTEs, Window Functions,
Ranking Functions, Running Totals, Pareto Analysis,
and Executive-Level Business Insights.

Dataset      : retail_sales
Total Queries: 20

====================================================================================================================*/


/*====================================================================================================
Q101. BUSINESS QUESTION:
Rank customers based on total sales.
====================================================================================================*/

SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER(ORDER BY SUM(sales) DESC) AS sales_rank
FROM retail_sales
GROUP BY customer_name;



/*====================================================================================================
Q102. BUSINESS QUESTION:
Assign a unique row number to every customer.
====================================================================================================*/

SELECT
    customer_name,
    SUM(sales) AS total_sales,
    ROW_NUMBER() OVER(ORDER BY SUM(sales) DESC) AS row_num
FROM retail_sales
GROUP BY customer_name;



/*====================================================================================================
Q103. BUSINESS QUESTION:
Assign dense ranking to products based on profit.
====================================================================================================*/

SELECT
    product_name,
    SUM(profit) AS total_profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) AS profit_rank
FROM retail_sales
GROUP BY product_name;



/*====================================================================================================
Q104. BUSINESS QUESTION:
Divide customers into four spending groups.
====================================================================================================*/

SELECT
    customer_name,
    SUM(sales) AS total_sales,
    NTILE(4) OVER(ORDER BY SUM(sales) DESC) AS customer_quartile
FROM retail_sales
GROUP BY customer_name;



/*====================================================================================================
Q105. BUSINESS QUESTION:
Calculate cumulative sales by month.
====================================================================================================*/

WITH monthly_sales AS
(
SELECT
DATE_TRUNC('month',order_date) AS month,
SUM(sales) AS total_sales
FROM retail_sales
GROUP BY month
)

SELECT
month,
total_sales,
SUM(total_sales)
OVER(ORDER BY month) AS running_sales
FROM monthly_sales;



/*====================================================================================================
Q106. BUSINESS QUESTION:
Compare each month's sales with previous month.
====================================================================================================*/

WITH monthly_sales AS
(
SELECT
DATE_TRUNC('month',order_date) month,
SUM(sales) total_sales
FROM retail_sales
GROUP BY month
)

SELECT
month,
total_sales,
LAG(total_sales)
OVER(ORDER BY month) previous_month_sales
FROM monthly_sales;



/*====================================================================================================
Q107. BUSINESS QUESTION:
Predict next month's sales using LEAD().
====================================================================================================*/

WITH monthly_sales AS
(
SELECT
DATE_TRUNC('month',order_date) month,
SUM(sales) total_sales
FROM retail_sales
GROUP BY month
)

SELECT
month,
total_sales,
LEAD(total_sales)
OVER(ORDER BY month) next_month_sales
FROM monthly_sales;



/*====================================================================================================
Q108. BUSINESS QUESTION:
Find the top-selling product in every category.
====================================================================================================*/

WITH ranked_products AS
(
SELECT
category,
product_name,
SUM(sales) total_sales,
ROW_NUMBER() OVER(
PARTITION BY category
ORDER BY SUM(sales) DESC
) rn
FROM retail_sales
GROUP BY category,product_name
)

SELECT *
FROM ranked_products
WHERE rn=1;



/*====================================================================================================
Q109. BUSINESS QUESTION:
Find the most profitable customer in every region.
====================================================================================================*/

WITH ranked_customers AS
(
SELECT
region,
customer_name,
SUM(profit) total_profit,
ROW_NUMBER() OVER(
PARTITION BY region
ORDER BY SUM(profit) DESC
) rn
FROM retail_sales
GROUP BY region,customer_name
)

SELECT *
FROM ranked_customers
WHERE rn=1;



/*====================================================================================================
Q110. BUSINESS QUESTION:
Calculate a 3-month moving average of sales.
====================================================================================================*/

WITH monthly_sales AS
(
SELECT
DATE_TRUNC('month',order_date) month,
SUM(sales) total_sales
FROM retail_sales
GROUP BY month
)

SELECT
month,
ROUND(AVG(total_sales)
OVER(
ORDER BY month
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
),2) moving_average
FROM monthly_sales;



/*====================================================================================================
Q111. BUSINESS QUESTION:
Calculate cumulative profit.
====================================================================================================*/

SELECT
order_date,
profit,
SUM(profit)
OVER(
ORDER BY order_date
) AS cumulative_profit
FROM retail_sales;



/*====================================================================================================
Q112. BUSINESS QUESTION:
Find top 5 products by profit.
====================================================================================================*/

SELECT
product_name,
SUM(profit) total_profit
FROM retail_sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 5;



/*====================================================================================================
Q113. BUSINESS QUESTION:
Find bottom 5 products by profit.
====================================================================================================*/

SELECT
product_name,
SUM(profit) total_profit
FROM retail_sales
GROUP BY product_name
ORDER BY total_profit
LIMIT 5;



/*====================================================================================================
Q114. BUSINESS QUESTION:
Perform Pareto Analysis (80/20 Rule).
====================================================================================================*/

WITH sales_data AS
(
SELECT
product_name,
SUM(sales) total_sales
FROM retail_sales
GROUP BY product_name
),

pareto AS
(
SELECT
product_name,
total_sales,
SUM(total_sales)
OVER(ORDER BY total_sales DESC) running_sales,
SUM(total_sales)
OVER() overall_sales
FROM sales_data
)

SELECT
product_name,
total_sales,
ROUND(running_sales*100.0/overall_sales,2) cumulative_percentage
FROM pareto;



/*====================================================================================================
Q115. BUSINESS QUESTION:
Find customers whose sales are above average.
====================================================================================================*/

SELECT
customer_name,
SUM(sales) total_sales
FROM retail_sales
GROUP BY customer_name
HAVING SUM(sales)>
(
SELECT AVG(sales)
FROM retail_sales
);



/*====================================================================================================
Q116. BUSINESS QUESTION:
Find products with above-average profit.
====================================================================================================*/

SELECT
product_name,
SUM(profit) total_profit
FROM retail_sales
GROUP BY product_name
HAVING SUM(profit)>
(
SELECT AVG(profit)
FROM retail_sales
);



/*====================================================================================================
Q117. BUSINESS QUESTION:
Find category contribution to total sales.
====================================================================================================*/

SELECT
category,
SUM(sales) total_sales,
ROUND(
SUM(sales)*100/
SUM(SUM(sales)) OVER(),
2
) contribution_percentage
FROM retail_sales
GROUP BY category;



/*====================================================================================================
Q118. BUSINESS QUESTION:
Find customers with more than 10 orders.
====================================================================================================*/

SELECT
customer_name,
COUNT(DISTINCT order_id) total_orders
FROM retail_sales
GROUP BY customer_name
HAVING COUNT(DISTINCT order_id)>10;



/*====================================================================================================
Q119. BUSINESS QUESTION:
Find average sales by region using CTE.
====================================================================================================*/

WITH regional_sales AS
(
SELECT
region,
AVG(sales) avg_sales
FROM retail_sales
GROUP BY region
)

SELECT *
FROM regional_sales;



/*====================================================================================================
Q120. BUSINESS QUESTION:
Display the top 10 customers by sales.
====================================================================================================*/

SELECT
customer_name,
SUM(sales) total_sales
FROM retail_sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;


/*====================================================================================================================

/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
Part         : 9
File Name    : 09_Dashboard_SQL.sql

Description:
This SQL script contains dashboard-ready SQL queries that support
Power BI visualizations, executive KPI cards, and management reporting.

Dataset      : retail_sales
Total Queries: 15

====================================================================================================================*/


/*====================================================================================================
Q121. BUSINESS QUESTION:
Display the Executive KPI Summary.

Business Use:
Power BI KPI Cards
====================================================================================================*/

SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;



/*====================================================================================================
Q122. BUSINESS QUESTION:
Display category-wise sales and profit.

Business Use:
Clustered Bar Chart
====================================================================================================*/

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;



/*====================================================================================================
Q123. BUSINESS QUESTION:
Display sub-category performance.

Business Use:
Treemap
====================================================================================================*/

SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY sub_category
ORDER BY total_sales DESC;



/*====================================================================================================
Q124. BUSINESS QUESTION:
Display sales by customer segment.

Business Use:
Donut Chart
====================================================================================================*/

SELECT
    segment,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY segment
ORDER BY total_sales DESC;



/*====================================================================================================
Q125. BUSINESS QUESTION:
Display sales by market.

Business Use:
Filled Map
====================================================================================================*/

SELECT
    market,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY market
ORDER BY total_sales DESC;



/*====================================================================================================
Q126. BUSINESS QUESTION:
Display sales by region.

Business Use:
Bar Chart
====================================================================================================*/

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY region
ORDER BY total_sales DESC;



/*====================================================================================================
Q127. BUSINESS QUESTION:
Display Top 10 Customers.

Business Use:
Leaderboard Table
====================================================================================================*/

SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;



/*====================================================================================================
Q128. BUSINESS QUESTION:
Display Top 10 Products.

Business Use:
Leaderboard Table
====================================================================================================*/

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;



/*====================================================================================================
Q129. BUSINESS QUESTION:
Display monthly sales trend.

Business Use:
Line Chart
====================================================================================================*/

SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY month
ORDER BY month;



/*====================================================================================================
Q130. BUSINESS QUESTION:
Display monthly profit trend.

Business Use:
Line Chart
====================================================================================================*/

SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY month
ORDER BY month;



/*====================================================================================================
Q131. BUSINESS QUESTION:
Display sales by shipping mode.

Business Use:
Column Chart
====================================================================================================*/

SELECT
    ship_mode,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY ship_mode
ORDER BY total_sales DESC;



/*====================================================================================================
Q132. BUSINESS QUESTION:
Display average discount by category.

Business Use:
Column Chart
====================================================================================================*/

SELECT
    category,
    ROUND(AVG(discount),4) AS average_discount
FROM retail_sales
GROUP BY category
ORDER BY average_discount DESC;



/*====================================================================================================
Q133. BUSINESS QUESTION:
Display Top 10 Cities by Sales.

Business Use:
Map Visualization
====================================================================================================*/

SELECT
    city,
    ROUND(SUM(sales),2) AS total_sales
FROM retail_sales
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;



/*====================================================================================================
Q134. BUSINESS QUESTION:
Display Top 10 States by Profit.

Business Use:
Filled Map
====================================================================================================*/

SELECT
    state,
    ROUND(SUM(profit),2) AS total_profit
FROM retail_sales
GROUP BY state
ORDER BY total_profit DESC
LIMIT 10;



/*====================================================================================================
Q135. BUSINESS QUESTION:
Create an Executive Dashboard Summary.

Business Use:
Executive KPI Panel
====================================================================================================*/

SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT product_id) AS total_products,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(discount),4) AS average_discount,
    ROUND(AVG(shipping_cost),2) AS average_shipping_cost,
    ROUND((SUM(profit)*100.0)/NULLIF(SUM(sales),0),2) AS profit_margin
FROM retail_sales;



/*====================================================================================================================

/*====================================================================================================================

Project Name : RetailChainIQ – Multi-Store Retail Analytics Platform
Author       : Aryan Rai
Database     : PostgreSQL
Part         : 10
File Name    : 10_Interview_SQL.sql

Description:
Advanced SQL interview-style business questions using PostgreSQL.

Dataset      : retail_sales
Total Queries: 15

====================================================================================================================*/


/*====================================================================================================
Q136. BUSINESS QUESTION:
Find the second highest-selling customer.
====================================================================================================*/

SELECT customer_name,
       total_sales
FROM
(
    SELECT customer_name,
           SUM(sales) AS total_sales,
           DENSE_RANK() OVER(ORDER BY SUM(sales) DESC) AS sales_rank
    FROM retail_sales
    GROUP BY customer_name
) ranked
WHERE sales_rank = 2;



/*====================================================================================================
Q137. BUSINESS QUESTION:
Find the top 3 products within each category.
====================================================================================================*/

SELECT *
FROM
(
    SELECT category,
           product_name,
           SUM(sales) AS total_sales,
           ROW_NUMBER() OVER(
               PARTITION BY category
               ORDER BY SUM(sales) DESC
           ) AS rn
    FROM retail_sales
    GROUP BY category, product_name
) ranked_products
WHERE rn <= 3;



/*====================================================================================================
Q138. BUSINESS QUESTION:
Find customers whose total sales are above the overall average customer sales.
====================================================================================================*/

WITH customer_sales AS
(
    SELECT customer_name,
           SUM(sales) AS total_sales
    FROM retail_sales
    GROUP BY customer_name
)

SELECT *
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
);



/*====================================================================================================
Q139. BUSINESS QUESTION:
Find the customer with the highest profit in each market.
====================================================================================================*/

SELECT *
FROM
(
    SELECT market,
           customer_name,
           SUM(profit) AS total_profit,
           RANK() OVER(
               PARTITION BY market
               ORDER BY SUM(profit) DESC
           ) AS market_rank
    FROM retail_sales
    GROUP BY market, customer_name
) ranked
WHERE market_rank = 1;



/*====================================================================================================
Q140. BUSINESS QUESTION:
Find products that were never sold at a loss.
====================================================================================================*/

SELECT product_name
FROM retail_sales
GROUP BY product_name
HAVING MIN(profit) >= 0;



/*====================================================================================================
Q141. BUSINESS QUESTION:
Find the top-performing category in every region.
====================================================================================================*/

SELECT *
FROM
(
    SELECT region,
           category,
           SUM(sales) AS total_sales,
           ROW_NUMBER() OVER(
               PARTITION BY region
               ORDER BY SUM(sales) DESC
           ) AS rn
    FROM retail_sales
    GROUP BY region, category
) ranked
WHERE rn = 1;



/*====================================================================================================
Q142. BUSINESS QUESTION:
Calculate each customer's contribution to total sales.
====================================================================================================*/

SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(
        SUM(sales) * 100.0 /
        SUM(SUM(sales)) OVER(),
        2
    ) AS sales_contribution_percentage
FROM retail_sales
GROUP BY customer_name
ORDER BY total_sales DESC;



/*====================================================================================================
Q143. BUSINESS QUESTION:
Identify customers with more than one order but below-average total profit.
====================================================================================================*/

WITH customer_summary AS
(
    SELECT
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(profit) AS total_profit
    FROM retail_sales
    GROUP BY customer_name
)

SELECT *
FROM customer_summary
WHERE total_orders > 1
AND total_profit <
(
    SELECT AVG(total_profit)
    FROM customer_summary
);



/*====================================================================================================
Q144. BUSINESS QUESTION:
Find the longest gap (in days) between consecutive orders for each customer.
====================================================================================================*/

WITH customer_orders AS
(
    SELECT
        customer_name,
        order_date,
        LAG(order_date) OVER(
            PARTITION BY customer_name
            ORDER BY order_date
        ) AS previous_order_date
    FROM retail_sales
)

SELECT
    customer_name,
    MAX(order_date - previous_order_date) AS longest_gap_days
FROM customer_orders
WHERE previous_order_date IS NOT NULL
GROUP BY customer_name
ORDER BY longest_gap_days DESC;



/*====================================================================================================
Q145. BUSINESS QUESTION:
Find the top-selling product for each year.
====================================================================================================*/

SELECT *
FROM
(
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        product_name,
        SUM(sales) AS total_sales,
        ROW_NUMBER() OVER(
            PARTITION BY EXTRACT(YEAR FROM order_date)
            ORDER BY SUM(sales) DESC
        ) AS rn
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM order_date), product_name
) ranked
WHERE rn = 1;



/*====================================================================================================
Q146. BUSINESS QUESTION:
Find customers whose average order value exceeds the overall average order value.
====================================================================================================*/

WITH customer_aov AS
(
    SELECT
        customer_name,
        SUM(sales) / COUNT(DISTINCT order_id) AS average_order_value
    FROM retail_sales
    GROUP BY customer_name
)

SELECT *
FROM customer_aov
WHERE average_order_value >
(
    SELECT AVG(average_order_value)
    FROM customer_aov
);



/*====================================================================================================
Q147. BUSINESS QUESTION:
Rank regions by profit margin.
====================================================================================================*/

SELECT
    region,
    ROUND(
        (SUM(profit) * 100.0) /
        NULLIF(SUM(sales),0),
        2
    ) AS profit_margin_percentage,
    DENSE_RANK() OVER(
        ORDER BY
        (SUM(profit) * 100.0) /
        NULLIF(SUM(sales),0) DESC
    ) AS profit_margin_rank
FROM retail_sales
GROUP BY region;



/*====================================================================================================
Q148. BUSINESS QUESTION:
Identify the month with the highest sales growth.
====================================================================================================*/

WITH monthly_sales AS
(
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS total_sales
    FROM retail_sales
    GROUP BY month
),
growth AS
(
    SELECT
        month,
        total_sales,
        total_sales -
        LAG(total_sales) OVER(ORDER BY month) AS growth
    FROM monthly_sales
)

SELECT *
FROM growth
ORDER BY growth DESC
LIMIT 1;



/*====================================================================================================
Q149. BUSINESS QUESTION:
Find customers who purchased products from more than three categories.
====================================================================================================*/

SELECT
    customer_name,
    COUNT(DISTINCT category) AS categories_purchased
FROM retail_sales
GROUP BY customer_name
HAVING COUNT(DISTINCT category) > 3
ORDER BY categories_purchased DESC;



/*====================================================================================================
Q150. BUSINESS QUESTION:
Create a customer performance summary with sales, profit, orders,
profit margin, and sales rank.
====================================================================================================*/

SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        (SUM(profit) * 100.0) /
        NULLIF(SUM(sales),0),
        2
    ) AS profit_margin_percentage,
    DENSE_RANK() OVER(
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM retail_sales
GROUP BY customer_name
ORDER BY sales_rank;


/*====================================================================================================================


RetailChainIQ – Master SQL Script

Table of Contents

Part 1 : Data Validation & Business KPIs
Part 2 : Sales Analysis
Part 3 : Customer Analysis
Part 4 : Product Analysis
Part 5 : Regional & Market Analysis
Part 6 : Time Series Analysis
Part 7 : Profit, Discount & Shipping Analysis
Part 8 : Advanced PostgreSQL
Part 9 : Dashboard SQL
Part 10 : Interview SQL

========================================================*/
