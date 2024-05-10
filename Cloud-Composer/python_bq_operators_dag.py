"""A liveness prober dag for monitoring composer.googleapis.com/environment/healthy."""
import os 
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators import bash
from airflow.operators.dummy import DummyOperator
from airflow.operators.python import PythonOperator
from airflow.operators.bash_operator import BashOperator
#from airflow.operators.bigquery import BigQueryGetDatasetTablesOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryGetDataOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryGetDatasetTablesOperator
#airflow.providers.google.cloud.operators.bigquery
#airflow.providers.google.cloud.operators.bigquery.BigQueryGetDatasetTablesOperator
#import airflow

yesterday = datetime.combine(datetime.today()-timedelta(1),datetime.min.time())


default_args = {
    #'start_date': airflow.utils.dates.days_ago(0),
    'start_date': yesterday,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

def print_hello():
    print('----- Hay I am Python Operator ----')

with DAG(
    dag_id='List_BigQuery_Tables',
    default_args=default_args,
    description='liveness monitoring dag',
    #schedule_interval='*/10 * * * *',
    schedule_interval=timedelta(days=1),
    max_active_runs=2,
    catchup=False,
    #dagrun_timeout=timedelta(minutes=10),
    ) as dag: 
    
    # Dummy Tasks start here
    start = DummyOperator(
        task_id = 'start',
        dag=dag
    )

    python_task = PythonOperator(
        task_id ="python_task",
        python_callable = print_hello,
        dag = dag 
    )

    # bq_task_dataset = BigQueryGetDatasetTablesOperator(
    #     task_id="task_getdataset",
    #     dataset_id="mqns_public_dataset",
    #     #sql="SELECT start_station_name FROM `lookermspochsbc.mqns_public_dataset.bike_share_trips` LIMIT 20",
    #     dag=dag
    # )

    task_querytables = BigQueryGetDataOperator(
        task_id="task_querytables",
        dataset_id="mqns_public_dataset",
        #sql="SELECT start_station_name FROM `mqns_public_dataset.bike_share_trips` LIMIT 20",
        table_id='bike_share_trips',
        max_results='20',
        selected_fields='start_station_name',
        dag=dag
    )


    # List BigQuery output dataset.
    make_bq_dataset = bash.BashOperator(
        task_id="make_bq_dataset",
        # Executing 'bq' command requires Google Cloud SDK which comes
        # preinstalled in Cloud Composer.
        bash_command=f"bq ls mqns_public_dataset",
    )

    #Dummay end task
    end = DummyOperator(
        task_id="end",
        dag = dag
    )

# Setting up task dependencies using airflow operators
start >> python_task >> make_bq_dataset >> task_querytables >> end