-- Returns top N products by net sales for a given fiscal year

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_products_by_net_sales`(
    in_fiscal_year INT,   -- Fiscal year filter
    in_top_n INT          -- Number of top products to return
)
BEGIN
    SELECT 
        product,
        ROUND(SUM(net_sales) / 1000000, 2) AS net_sales_mln
    FROM gdb0041.net_saless
    WHERE fiscal_year = in_fiscal_year
    GROUP BY product
    ORDER BY net_sales_mln DESC
    LIMIT in_top_n;
END;
