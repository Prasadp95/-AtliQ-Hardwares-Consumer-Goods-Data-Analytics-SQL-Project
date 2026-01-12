-- Returns top N products per division by quantity sold for a given fiscal year

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_per_division_by_qty_sold`(
    in_fiscal_year INT,   -- Fiscal year filter
    in_top_n INT          -- Number of top products per division to return
)
BEGIN
    -- Calculate total quantity sold per product per division
    WITH cte1 AS (
        SELECT 
            p.division,
            p.product,
            SUM(ns.sold_quantity) AS total_qty
        FROM gdb0041.net_saless ns
        JOIN dim_product p
            ON ns.product_code = p.product_code
        WHERE fiscal_year = in_fiscal_year
        GROUP BY p.division, p.product
    ),
    -- Rank products within each division by total quantity sold
    cte2 AS (
        SELECT *,
               DENSE_RANK() OVER (PARTITION BY division ORDER BY total_qty DESC) AS drnk
        FROM cte1
    )
    -- Select top N products per division
    SELECT *
    FROM cte2
    WHERE drnk <= in_top_n;
END;
