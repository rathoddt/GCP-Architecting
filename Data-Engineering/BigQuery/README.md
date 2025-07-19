# BigQuery

BigQuery Sandbox  
https://cloud.google.com/bigquery/docs/sandbox

### References
Google Trends dataset  
https://support.google.com/trends/answer/12764470?hl=en#:~:text=The%20BigQuery%20dataset%20from%20Google,month%20in%20storage%20without%20charge.

```
bq mk taxirides

//This command creates a new table (taxirides.realtime) in BigQuery with the given schema and applies time-based partitioning on the timestamp field.

bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime
<!-- This section creates the 'taxirides' dataset in BigQuery -->
#Deploy the Dataflow Template:
gcloud dataflow jobs run iotflow \
    --gcs-location gs://dataflow-templates-us-east1/latest/PubSub_to_BigQuery \
    --region us-east1 \
    --worker-machine-type e2-medium \
    --staging-location gs://qwiklabs-gcp-03-b44ec061b738/temp \
    --parameters inputTopic=projects/pubsub-public-data/topics/taxirides-realtime,outputTableSpec=qwiklabs-gcp-03-b44ec061b738:taxirides.realtime
```



