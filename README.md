# Hands On dbt, Snowflake and Apache Airflow

This repository for online course Modern Data Warehouse in Snowflake. 
In this course use tech stack : 
- Data Transformation : dbt
- Workflow Orchestions : Apache Airflow
- Data Platform : OLAP(Snowflake)

## Prerequisite
1) Already installed docker and docker compose
2) Already have snowflake account with ACCOUNTADMIN for participate this hands on(register free 1 month free trial snowflake without credit card)
3) Already installed vscode or other IDE

## Table of Content
1) Setup dbt with snowflake as data platform
2) ELT Data Architecture & Data Modelling
3) Create dbt model
4) Create airflow dags for run dbt seed & model

### Setup dbt with snowflake as data platform
- Go to snowflake query editor and run all query bellow in worksheet or you can copy paste setup_snowflake_dbt.sql
```
-------------------------------------------
-- dbt credentials
-------------------------------------------
USE ROLE securityadmin;
-- dbt roles
CREATE OR REPLACE ROLE dbt_dev_role;
------------------------------------------- Please replace with your dbt user password
CREATE OR REPLACE USER dbt_user PASSWORD = "<your_secret_password>";

GRANT ROLE dbt_dev_role TO USER dbt_user;
GRANT ROLE dbt_dev_role TO ROLE sysadmin;

-------------------------------------------
-- dbt objects
-------------------------------------------
USE ROLE sysadmin;

CREATE OR REPLACE WAREHOUSE dbt_dev_wh  WITH WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 INITIALLY_SUSPENDED = TRUE;

GRANT ALL ON WAREHOUSE dbt_dev_wh TO ROLE dbt_dev_role;

CREATE OR REPLACE DATABASE dbt_dev; 
GRANT ALL ON DATABASE dbt_dev  TO ROLE dbt_dev_role;
GRANT ALL ON ALL SCHEMAS IN DATABASE dbt_dev TO ROLE dbt_dev_role;
```

### ELT Data Architecture & Data Modelling
#### ELT Data Architecture
![data_architecture](https://github.com/saipulrx/airflow_dbt_snowflake/blob/main/assets/elt_data_architecture_snowflake.jpg)

#### Data Modelling
In this course, for Data Modelling use Kimbal's Method - Star Schema

<b>ERD Conceptual</b>
![erd conceptual](https://github.com/saipulrx/airflow_dbt_snowflake/blob/main/assets/erd-conceptual.drawio.png)

<b>ERD Logical</b>
![erd logical](https://github.com/saipulrx/airflow_dbt_snowflake/blob/main/assets/erd-logical.drawio.png)

<b>ERD Physical</b>
<br />
![erd physical](https://github.com/saipulrx/airflow_dbt_snowflake/blob/main/assets/erd-physical.drawio.png)

#### Create dbt model
Copy paste all folder warehouse & mart to your local

#### Create airflow dags for run dbt seed & model
- Copy paste all dags code in folder dags to your local folder
- Enable airflow dag then check data in snowflake 
