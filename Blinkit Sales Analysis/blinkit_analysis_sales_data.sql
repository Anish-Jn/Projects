SELECT * FROM sales_data;

-- Sum of total sales in millions
SELECT CAST(SUM(`Total Sales`)/1000000 AS DECIMAL(10,2)) AS Total_sales_millions FROM sales_data;


-- Sum of total sales in millions for low fat
SELECT CAST(SUM(`Total Sales`)/1000000 AS DECIMAL(10,2)) AS Total_sales_millions FROM sales_data
WHERE `Item Fat Content` = 'Low Fat';


-- Sum of total sales in millions for a paarticular establishment year
SELECT CAST(SUM(`Total Sales`)/1000000 AS DECIMAL(10,2)) AS Total_sales_millions FROM sales_data
WHERE `Outlet Establishment Year` = 2012;


-- Avg number of total sales
SELECT CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS avg_sales FROM sales_data;


-- Total number of items
SELECT COUNT(*) AS no_of_items FROM sales_data;


-- Avg rating
SELECT CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS avg_rating from sales_data;


-- Total sales per fat category
SELECT `Item Fat Content`, 
		CONCAT(CAST(SUM(`Total Sales`)/1000 AS DECIMAL(10,2)),'K') AS Total_sales_thousands,
        CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS avg_sales ,
        COUNT(*) AS no_of_items,
        CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS avg_rating
FROM sales_data
GROUP BY `Item Fat Content`
ORDER BY Total_sales_thousands DESC;


-- Total sales by item type
SELECT `Item Type`, 
		CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS total_sales,
        CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS avg_sales ,
        COUNT(*) AS no_of_items,
        CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS avg_rating
FROM sales_data
GROUP BY `Item Type`
ORDER BY `total_sales`
LIMIT 5;


-- Sales by outlet
SELECT 
	`Outlet Location Type`,
    SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN `Total Sales` ELSE 0 END) AS Low_Fat,
    SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN `Total Sales` ELSE 0 END) AS Regular
FROM
    sales_data 
GROUP BY
    `Outlet Location Type`
ORDER BY
    `Outlet Location Type`;
    
    
-- Sales by outlet establishment
Select `Outlet Establishment Year`,
		CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS total_sales,
        CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS avg_sales ,
        COUNT(*) AS no_of_items,
        CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS avg_rating
FROM sales_data
GROUP BY `Outlet Establishment Year`
ORDER BY `Outlet Establishment Year`;


-- Percentage of sales by outlet size
SELECT `Outlet Size`,
		CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS total_sales,
        CAST((SUM(`Total Sales`) * 100.0/ SUM(SUM(`Total Sales`)) OVER())AS DECIMAL(10,2)) AS sales_percentage
FROM sales_data
GROUP BY `Outlet Size`
ORDER BY total_sales DESC;


-- Sales by outlet location
Select `Outlet Location Type`,
		CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS total_sales,
        CAST((SUM(`Total Sales`) * 100.0/ SUM(SUM(`Total Sales`)) OVER())AS DECIMAL(10,2)) AS sales_percentage,
        CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS avg_sales ,
        COUNT(*) AS no_of_items,
        CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS avg_rating
FROM sales_data
GROUP BY `Outlet Location Type`
ORDER BY total_sales DESC;

-- Sales by outlet type
Select `Outlet Type`,
		CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS total_sales,
        CAST((SUM(`Total Sales`) * 100.0/ SUM(SUM(`Total Sales`)) OVER())AS DECIMAL(10,2)) AS sales_percentage,
        CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS avg_sales ,
        COUNT(*) AS no_of_items,
        CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS avg_rating
FROM sales_data
GROUP BY `Outlet Type`
ORDER BY total_sales DESC;

DESCRIBE sales_data;

ALTER TABLE sales_data RENAME COLUMN `ï»¿Item Fat Content` TO `Item Fat Content`;

