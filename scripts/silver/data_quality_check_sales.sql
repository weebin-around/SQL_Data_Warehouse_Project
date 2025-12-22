select 
sls_sales,
sls_quantity,
sls_price,
case when sls_sales is null or sls_sales <=0 or sls_sales <> sls_quantity*abs(sls_price)
	then sls_sales = sls_quantity* abs(sls_price)
    else sls_sales 
end as sls_sales,
case when sls_price <=0 or sls_price is null 
	then sls_price = sls_sales/ nullif(sls_quantity,0)
	else sls_price
end as sls_price
from bronze.crm_sales_details
