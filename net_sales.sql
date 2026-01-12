CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `gdb0041`.`net_saless` AS
    SELECT 
        `gdb0041`.`sales_postinv_discounts`.`date` AS `date`,
        `gdb0041`.`sales_postinv_discounts`.`fiscal_year` AS `fiscal_year`,
        `gdb0041`.`sales_postinv_discounts`.`customer_code` AS `customer_code`,
        `gdb0041`.`sales_postinv_discounts`.`market` AS `market`,
        `gdb0041`.`sales_postinv_discounts`.`product_code` AS `product_code`,
        `gdb0041`.`sales_postinv_discounts`.`product` AS `product`,
        `gdb0041`.`sales_postinv_discounts`.`variant` AS `variant`,
        `gdb0041`.`sales_postinv_discounts`.`sold_quantity` AS `sold_quantity`,
        `gdb0041`.`sales_postinv_discounts`.`gross_price_total` AS `gross_price_total`,
        `gdb0041`.`sales_postinv_discounts`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        `gdb0041`.`sales_postinv_discounts`.`net_invoice_sales` AS `net_invoice_sales`,
        `gdb0041`.`sales_postinv_discounts`.`post_invoice_discount_pct` AS `post_invoice_discount_pct`,
        (`gdb0041`.`sales_postinv_discounts`.`net_invoice_sales` * (1 - `gdb0041`.`sales_postinv_discounts`.`post_invoice_discount_pct`)) AS `net_sales`
    FROM
        `gdb0041`.`sales_postinv_discounts`