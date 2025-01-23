from airflow.decorators import dag
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

@dag(
    start_date=days_ago(1),
    schedule='@daily',
    catchup=False,
    tags=['dbt','load_northwind_data'],
)

def dbt_mart_test_example():

    dbt_run_warehouse = BashOperator(
        task_id = 'dbt_run_mart',
        bash_command = 'cd /opt/airflow/include/dbt/northwind/ && dbt run --select mart'
    )

    dbt_run_test = BashOperator(
        task_id = 'dbt_test',
        bash_command = 'cd /opt/airflow/include/dbt/northwind/ && dbt test'
    )

    dbt_run_warehouse >> dbt_run_test

dbt_mart_test_example()