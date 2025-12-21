--To check for data quality issues in the table --

/* Query: Aggregating byy primary key and counting the number of rows. Each primary key should
one count(*) per group */

select cst_id, 
count(*) from bronze.crm_customer_info
group by cst_id 
having count(*) > 1 or csd_id is null;

/* Query : Columns having low cardinality values are better normalized and standardized*/

select distinct cst_marital_status 
from  bronze.crm_customer_info;

/* Query : To identify the trailing and leading whitespaces in varchar datatypes*/

select cst_firstname from bronze.crm_customer_info 
where cst_firstname <> trim(cst_firstname);

/* Query : to identify date quality issues, logic - start day < end date)*/

select * from bronze.product_info 
where prd_end_dt < prd_start_dt;
