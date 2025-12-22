-- This code is to load product details by customers in the silver layer of the pipeeline--

CREATE TABLE IF NOT EXISTS silver.crm_product_info1 (
    prd_id INT,
    cat_id VARCHAR(50),
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cos INT,
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
) ENGINE = InnoDB;

INSERT INTO silver.crm_product_info1(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cos,
prd_line,
prd_start_dt,
prd_end_dt
)

SELECT 
prd_id,
replace(substring(prd_key,1,5),'-','_') AS cat_id,
substring(prd_key,7,length(prd_key)) AS prd_key,
upper(trim(prd_nm)) as prd_nm,
coalesce(prd_cos,0) as prd_cos, 
 CASE WHEN upper(trim(prd_line)) = 'M' then 'Mountain' 
		WHEN upper(trim(prd_line)) = 'R' then 'Road'
       WHEN upper(trim(prd_line)) = 'S' then 'Other Sales' 
		WHEN upper(trim(prd_line)) = 'T' then 'Touring' 
         ELSE 'N/A' 
         END prd_line,
CAST(prd_start_dt AS date) prd_start_dt,
CAST(
        DATE_SUB(
            LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt),
            INTERVAL 1 DAY
        )
    AS DATE) AS prd_end_dt
from bronze.crm_product_info;
