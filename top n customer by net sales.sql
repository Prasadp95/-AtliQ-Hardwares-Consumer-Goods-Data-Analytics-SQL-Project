-- Returns top N customers by net sales for a given market and fiscal year

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_customer_by_net_sales`(
    in_market VARCHAR(45),     -- Market filter
    in_fiscal_year INT,        -- Fiscal year filter
    in_top_n INT               -- Number of top customers to return
)
BEGIN
    SELECT 
        customer,
        ROUND(SUM(net_sales) / 1000000, 2) AS net_sales_mln
    FROM net_saless ns
    JOIN dim_customer c
        ON ns.customer_code = c.customer_code
    WHERE fiscal_year = in_fiscal_year
      AND ns.market = in_market
    GROUP BY customer
    ORDER BY net_sales_mln DESC
    LIMIT in_top_n;
END;
