CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `gdb0041`.`sales_pre_invoice_discounts` AS
    SELECT 
        `s`.`date` AS `date`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `s`.`customer_code` AS `customer_code`,
        `c`.`market` AS `market`,
        `s`.`product_code` AS `product_code`,
        `p`.`product` AS `product`,
        `p`.`variant` AS `variant`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `g`.`gross_price` AS `gross_price_per_item`,
        ROUND((`s`.`sold_quantity` * `g`.`gross_price`),
                2) AS `gross_price_total`,
        `pre`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`
    FROM
        ((((`gdb0041`.`fact_sales_monthly` `s`
        JOIN `gdb0041`.`dim_customer` `c` ON ((`s`.`customer_code` = `c`.`customer_code`)))
        JOIN `gdb0041`.`dim_product` `p` ON ((`s`.`product_code` = `p`.`product_code`)))
        JOIN `gdb0041`.`fact_gross_price` `g` ON (((`g`.`fiscal_year` = `s`.`fiscal_year`)
            AND (`g`.`product_code` = `s`.`product_code`))))
        JOIN `gdb0041`.`fact_pre_invoice_deductions` `pre` ON (((`pre`.`customer_code` = `s`.`customer_code`)
            AND (`pre`.`fiscal_year` = `s`.`fiscal_year`))))