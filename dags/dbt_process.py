from airflow.decorators import dag
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

@dag(
    start_date=days_ago(1),
    schedule='@daily',
    catchup=False,
    tags=['dbt','load_northwind_data'],
)

def elt_dbt():

    dbt_seed = BashOperator(
        task_id = 'dbt_seed',
        bash_command = 'cd /opt/airflow/include/dbt/northwind/ && dbt seed'
    )

    dbt_run_warehouse = BashOperator(
        task_id = 'dbt_run',
        bash_command = 'cd /opt/airflow/include/dbt/northwind/ && dbt run --select warehouse'
    )

    dbt_seed >> dbt_run_warehouse

elt_dbt()