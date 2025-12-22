-- This code is insert customer_info data in the silver layer of the etl pipeline--


insert into silver.crm_customer_info 
(cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
)

select 
	cst_id,
    cst_key,
    trim(cst_firstname) AS cst_first_name,
    trim(cst_lastname) AS cst_lastname,
      CASE WHEN upper(trim(cst_marital_status)) = 'S' then 'Single' 
		WHEN upper(trim(cst_marital_status)) = 'M' then 'Married'
         ELSE 'N/A' 
         END cst_marital_status,
     CASE WHEN upper(trim(cst_gndr)) = 'F' then 'Female' 
		 WHEN upper(trim(cst_gndr)) = 'M' then 'Male'
         ELSE 'N/A' 
         END cst_gndr,
    cst_create_date 
from 
(select *, 
row_number() over (partition by cst_id order by cst_create_date desc) as rn_cust_info
from bronze.crm_customer_info
)t 
where rn_cust_info = 1;

