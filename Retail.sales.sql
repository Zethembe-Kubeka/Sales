-- Databricks notebook source
SELECT *
FROM retail.sales.dateset;

SELECT `Transaction ID`,
        `Date`,
        `Customer ID`
FROM retail.sales.dateset;

SELECT distinct `Product Category`
FROM retail.sales.dateset;

SELECT `Customer ID`,
        `Gender`,
        `Total Amount`,
        `Product Category`
FROM retail.sales.dateset
ORDER BY `Total Amount` DESC;

SELECT `Transaction ID`,
        `Customer ID`,
        `Age`,
        `Product Category`
FROM retail.sales.dateset
WHERE `Product Category` IN ('Beauty', 'Clothing') AND `Age` BETWEEN 20 AND 35;

SELECT `Product Category`,
        COUNT(`Quantity`) AS Quantity_count
FROM retail.sales.dateset
GROUP BY `Product Category`
HAVING `Quantity_Count` > 320;

SELECT DISTINCT `Product Category`,`Price per Unit`,
        COUNT(`Total Amount`) AS Tot_Amount
FROM retail.sales.dateset
GROUP BY `Product Category`, `Price per Unit`
HAVING `Tot_Amount` > 50;

SELECT `Age`,
        COUNT(CASE WHEN `Gender` = 'Male' THEN 1 END) AS total_male,
        COUNT(CASE WHEN `Gender` = 'Female' THEN 1 END) AS total_female
FROM retail.sales.dateset
GROUP BY `Age`;

SELECT `Customer ID`,
        `Gender`,
        `Age`,
        `Product Category`,
        `Total Amount`
FROM retail.sales.dateset
WHERE `Total Amount` BETWEEN 500 AND 1500
AND `Product Category` <> 'Çlothing';

SELECT `Gender`,
        `Age`,
        `Product Category`,
        `Quantity`,
        `Total Amount`
FROM retail.sales.dateset
WHERE `Quantity` BETWEEN 3 AND 5
AND `Gender` = 'Female';

SELECT `Customer ID`,
        `Gender`,
        `Product Category`,
        `Price per Unit`
FROM retail.sales.dateset
WHERE `Price per Unit` BETWEEN 25 AND 50;

---CASE STATEMENTS--
SELECT `Customer ID`,
        `Age`,
        CASE
        WHEN `Age` BETWEEN 0 AND 20 THEN 'Young'
        WHEN `Age` BETWEEN 21 AND 35 THEN 'Youth'
        WHEN `Age` BETWEEN 36 AND 49 THEN 'Young Adult'
        ELSE 'Senior'
        END AS Age_group
FROM retail.sales.dateset;

SELECT `Customer ID`,
        `Total Amount`,
        CASE
        WHEN `Total Amount` BETWEEN 1000 AND 2000 THEN 'Expensive'
        WHEN `Total Amount` BETWEEN 500 AND 900 THEN 'Affordable'
        WHEN `Total Amount` BETWEEN 100 AND 800 THEN 'Cheap'
        ELSE 'Extremely cheap'
        END AS Affordability_group
FROM retail.sales.dateset;

--UNION VS UNION ALL--
SELECT `Customer ID`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` BETWEEN 20 AND 35
UNION ALL
SELECT `Customer ID`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` BETWEEN 36 AND 65;

SELECT `Customer ID`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` BETWEEN 20 AND 35
UNION
SELECT `Customer ID`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` BETWEEN 20 AND 65;

SELECT `Customer ID`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` BETWEEN 20 AND 35
UNION ALL
SELECT `Customer ID`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` BETWEEN 20 AND 65;

SELECT `Gender`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` >= 25
UNION
SELECT `Gender`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` >= 25;

SELECT `Gender`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` >= 25
UNION
SELECT `Gender`,
        `Age`
FROM retail.sales.dateset
WHERE `Age` >= 25;


--Exercises\Challenges --

SELECT `Transaction ID`,
        `Customer ID`,
        `Age`,
        `Product Category`,
        `Total Amount`
FROM retail.sales.dateset
WHERE `Product Category` IN ('Electronics', 'Beauty') AND `Age` BETWEEN 25 AND 40
ORDER BY `Age` ASC;

SELECT `Product Category`,
        SUM(`Total Amount`) AS `Total Revenue`,
        AVG(`Quantity`) AS `Avg Quantity`,
        COUNT(`Transaction ID`) AS `Transaction Count`
FROM retail.sales.dateset
GROUP BY `Product Category`
HAVING SUM(`Total Amount`) > 20000
ORDER BY `Total Revenue` DESC;

SELECT `Age`,
        CASE
        WHEN `Age` BETWEEN 0 AND 24 THEN 'Youth'
        WHEN `Age` BETWEEN 25 AND 40 THEN 'Adult'
        ELSE 'Senior'
        END AS Age_group,
        `Gender`,
        COUNT(`Transaction ID`) AS `Transaction Count`
FROM retail.sales.dateset
GROUP BY `Age`, `Gender`;

SELECT `Product Category`,
        AVG(`Total Amount`) AS `Avg Total Amount`,
        COUNT(`Transaction ID`) AS `Transaction Count`
FROM retail.sales.dateset
GROUP BY `Product Category`
HAVING `Transaction Count`  > 50;




--DATE FUNCTIONS ---

SELECT `Transaction ID`,
        `Date`,
        YEAR(`Date`) AS Year,
        MONTH(`Date`) AS Month,
        DAYOFWEEK(`Date`)
FROM retail.sales.dateset
LIMIT 15;

SELECT YEAR(`Date`) AS Year,
        MONTH(`Date`) AS Month,
        SUM(`Total Amount`) AS Total_Revenue,
        COUNT(`Transaction ID`) AS Total_Count
FROM retail.sales.dateset
GROUP BY ALL
ORDER BY `Total_Count` ASC;

SELECT 
        CASE 
        WHEN DAYOFWEEK(`Date`) = 1 THEN 'Weekend'
        WHEN DAYOFWEEK(`Date`) = 7 THEN 'Weekend'
        ELSE 'Weekday'
        END AS Day_Type,
        AVG(`Total Amount`) AS Avg_Total_Amount,
        COUNT(`Transaction ID`) AS Total_Count
FROM retail.sales.dateset
GROUP BY ALL;

--------SUBQUERY--------
SELECT MAX(`Date`)
FROM retail.sales.dateset;
----------------------

SELECT `Transaction ID`,
        `Customer ID`,
        `Date`,
        DAYNAME(`Date`) AS day_name
FROM retail.sales.dateset;

SELECT `Transaction ID`,
        `Customer ID`,
        `Date`,
        MONTHNAME(`Date`) AS month_date
FROM retail.sales.dateset;

SELECT `Transaction ID`,
        `Customer ID`,
        `Date`,
        YEAR(`Date`) AS transaction_year
FROM retail.sales.dateset;

SELECT `Transaction ID`,
        `Customer ID`,
        `Date`,
        DATEADD(`Date`,7) AS expected_delivery_date
FROM retail.sales.dateset;

SELECT `Transaction ID`,
        `Customer ID`,
        `Date`,
        TO_CHAR(`Date`, 'yyyy-MM-dd') AS formatted_payment_date
FROM retail.sales.dateset;

--Duplicates--
SELECT `Customer ID`, 
        `Date`, 
COUNT(*) AS occurrences
FROM retail.sales.dateset
GROUP BY `Customer ID`, `Date`
HAVING COUNT(*) > 1;

SELECT `Transaction ID`,
       `Customer ID`,
       `Price per Unit`,
        `Quantity`,
      `Price per Unit` * `Quantity` AS total_amount
FROM retail.sales.dateset;

SELECT `Date`,
       SUM(`Quantity`) AS total_units_sold,
       SUM(`Price per Unit` * `Quantity`) AS total_revenue
FROM retail.sales.dateset
GROUP BY `Date`
ORDER BY `Date`;

SELECT `Product Category`,
       SUM(`Quantity`) AS total_units_sold
FROM retail.sales.dateset
GROUP BY `Product Category`
ORDER BY total_units_sold DESC;

SELECT *
FROM retail.sales.dateset
LIMIT 10;
