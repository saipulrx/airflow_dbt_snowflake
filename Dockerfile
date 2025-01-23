FROM apache/airflow:2.10.4
RUN pip install --no-cache-dir astronomer-cosmos[dbt-snowflake]==1.3.2
ENV PIP_USER=false
RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-snowflake==1.7.2 && deactivate
ENV PIP_USER=true
