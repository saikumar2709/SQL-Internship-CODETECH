-- Create Sales Table
CREATE TABLE Sales (
    SaleID INT,
    SalesPerson VARCHAR(50),
    Region VARCHAR(50),
    SaleAmount INT,
    SaleDate DATE
);

-- Insert Sample Data
INSERT INTO Sales VALUES
(1, 'Alice', 'North', 1200, '2024-01-15'),
(2, 'Bob', 'South', 800, '2024-01-16'),
(3, 'Alice', 'North', 1300, '2024-02-12'),
(4, 'David', 'East', 1500, '2024-03-05'),
(5, 'Alice', 'North', 900, '2024-03-10'),
(6, 'Bob', 'South', 950, '2024-03-12'),
(7, 'Charlie', 'West', 1100, '2024-03-15'),
(8, 'David', 'East', 1700, '2024-03-20');

-- 1. Rank Sales in Each Region
SELECT 
    SalesPerson,
    Region,
    SaleAmount,
    RANK() OVER (PARTITION BY Region ORDER BY SaleAmount DESC) AS RegionRank
FROM Sales;

-- 2. Running Total for Each SalesPerson
SELECT 
    SalesPerson,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (PARTITION BY SalesPerson ORDER BY SaleDate) AS RunningTotal
FROM Sales;

-- 3. Subquery: Sales Greater Than Average
SELECT *
FROM Sales
WHERE SaleAmount > (
    SELECT AVG(SaleAmount) FROM Sales
);

-- 4. Monthly Sales Summary using CTE
WITH MonthlySales AS (
    SELECT 
        STRFTIME('%Y-%m', SaleDate) AS Month,
        SalesPerson,
        SUM(SaleAmount) AS TotalSales
    FROM Sales
    GROUP BY Month, SalesPerson
)
SELECT * FROM MonthlySales;
