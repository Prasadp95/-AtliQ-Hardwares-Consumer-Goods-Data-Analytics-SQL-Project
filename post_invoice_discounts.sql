CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `gdb0041`.`sales_postinv_discounts` AS
    SELECT 
        `gdb0041`.`s`.`date` AS `date`,
        `gdb0041`.`s`.`fiscal_year` AS `fiscal_year`,
        `gdb0041`.`s`.`customer_code` AS `customer_code`,
        `gdb0041`.`s`.`market` AS `market`,
        `gdb0041`.`s`.`product_code` AS `product_code`,
        `gdb0041`.`s`.`product` AS `product`,
        `gdb0041`.`s`.`variant` AS `variant`,
        `gdb0041`.`s`.`sold_quantity` AS `sold_quantity`,
        `gdb0041`.`s`.`gross_price_total` AS `gross_price_total`,
        `gdb0041`.`s`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        (`gdb0041`.`s`.`gross_price_total` - (`gdb0041`.`s`.`pre_invoice_discount_pct` * `gdb0041`.`s`.`gross_price_total`)) AS `net_invoice_sales`,
        (`po`.`discounts_pct` + `po`.`other_deductions_pct`) AS `post_invoice_discount_pct`
    FROM
        (`gdb0041`.`sales_pre_invoice_discounts` `s`
        JOIN `gdb0041`.`fact_post_invoice_deductions` `po` ON (((`po`.`customer_code` = `gdb0041`.`s`.`customer_code`)
            AND (`po`.`product_code` = `gdb0041`.`s`.`product_code`)
            AND (`po`.`date` = `gdb0041`.`s`.`date`))))