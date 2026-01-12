-- Procedure to assign market badge (Gold/Silver) based on total sales quantity

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
    IN in_market VARCHAR(45),        -- Market name (default: India)
    IN in_fiscal_year YEAR,           -- Fiscal year for evaluation
    OUT out_badge VARCHAR(45)         -- Output badge result
)
BEGIN
    DECLARE qty INT DEFAULT 0;        -- Total sold quantity for the market

    -- Set default market if input is empty
    IF in_market = '' THEN
        SET in_market = 'India';
    END IF;

    -- Calculate total sold quantity for the given market and fiscal year
    SELECT 
        SUM(s.sold_quantity)
    INTO qty
    FROM fact_sales_monthly s
    JOIN dim_customer c
        ON c.customer_code = s.customer_code
    WHERE get_fiscal_year(s.date) = in_fiscal_year
      AND c.market = in_market
    GROUP BY c.market;

    -- Assign badge based on sales threshold
    IF qty > 5000000 THEN
        SET out_badge = 'gold';
    ELSE 
        SET out_badge = 'silver';
    END IF;

END;
