CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `gdb0041`.`gross_sales` AS
    SELECT 
        `s`.`date` AS `date`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `c`.`market` AS `market`,
        `s`.`customer_code` AS `customer_code`,
        `p`.`product_code` AS `product_code`,
        `p`.`product` AS `product`,
        `p`.`variant` AS `variant`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `g`.`gross_price` AS `gross_price`,
        (`s`.`sold_quantity` * `g`.`gross_price`) AS `gross_sales`
    FROM
        (((`gdb0041`.`fact_sales_monthly` `s`
        JOIN `gdb0041`.`dim_product` `p` ON ((`s`.`product_code` = `p`.`product_code`)))
        JOIN `gdb0041`.`dim_customer` `c` ON ((`s`.`customer_code` = `c`.`customer_code`)))
        JOIN `gdb0041`.`fact_gross_price` `g` ON (((`s`.`product_code` = `g`.`product_code`)
            AND (`s`.`fiscal_year` = `g`.`fiscal_year`))))