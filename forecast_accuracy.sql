CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
	-- Input parameter: fiscal year for which accuracy is calculated
	in_fiscal_year int )
BEGIN
	 -- CTE (Common Table Expression) to calculate forecast error metrics
	with cte1 as(
select f.customer_code, c.market, c.customer,
	sum(forecast_quantity - sold_quantity) as net_error,
    sum(forecast_quantity - sold_quantity)*100/sum(forecast_quantity) as net_error_pct,
	sum(abs(forecast_quantity - sold_quantity)) as abs_net_error,
    sum(abs(forecast_quantity - sold_quantity))*100/sum(forecast_quantity) as abs_net_error_pct
from gdb0041.fact_actual_et f
join dim_customer c
on f.customer_code=c.customer_code
where f.fiscal_year=in_fiscal_year
group by customer_code
)
 -- Final query to calculate forecast accuracy
select *,
	if(abs_net_error_pct>100,0, 100-abs_net_error_pct) as forecast_accuracy from cte1
    order by forecast_accuracy;

END