from airflow.decorators import dag
#from astronomer.providers.dbt.task_group import DbtTaskGroup
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

@dag(
    start_date=days_ago(1),
    schedule='@daily',
    catchup=False,
    tags=['dbt','load_northwind_data'],
)

def dbt_process():

    dbt_seed = BashOperator(
        task_id = 'dbt_seed',
        bash_command = 'cd /opt/airflow/include/dbt/northwind/ && dbt seed'
    )

    dbt_run = BashOperator(
        task_id = 'dbt_run',
        bash_command = 'cd /opt/airflow/include/dbt/northwind/ && dbt run'
    )

    dbt_seed >> dbt_run

dbt_process()