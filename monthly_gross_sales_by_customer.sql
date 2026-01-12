-- Returns monthly gross sales for given customer codes

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_by_customer`(
    c_code TEXT   -- Comma-separated customer codes
)
BEGIN
    SELECT 
        s.date,
        SUM(g.gross_price * s.sold_quantity) AS total_gross_sales
    FROM fact_sales_monthly s
    JOIN fact_gross_price g
        ON g.product_code = s.product_code
       AND g.fiscal_year = get_fiscal_year(s.date)
    WHERE FIND_IN_SET(s.customer_code, c_code) > 0
    GROUP BY s.date;
END;
