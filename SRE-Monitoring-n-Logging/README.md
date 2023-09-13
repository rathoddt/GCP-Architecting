# SER Logging & Monitoring
Operations -Monitor, troubleshoot, improve application performance in cloud environment

Google four Golden signal 
 - latency
 - Errors
 - traffic
 - saturation

https://cloud.google.com/monitoring/monitor-compute-engine-virtual-machine
https://cloud.google.com/monitoring/docs
https://cloud.google.com/monitoring/docs/monitoring-overview

Cloud Logging-agent is based on `fluentd`
Cloud monitoring-agent is based on `collectd`

```
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh

sudo bash add-google-cloud-ops-agent-repo.sh --also-install
```

To list all running services on Ubuntu, Type:
```
systemctl list-units

sudo systemctl status google-cloud-ops-agent"*"


gcloud beta compute instances create website-agent --zone=us-central1-a --machine-type=e2-micro --metadata=startup-script-url=gs://acg-gcloud-course-resources/devops-engineer/operations/webpage-config-with-agent.sh --tags=http-server --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=website-agent
```

### Ops Agent
The Ops Agent is the primary agent for collecting telemetry from your Compute Engine instances. Combining logging, metrics, and traces into a single agent, the Ops Agent uses Fluent Bit for logs, which supports high-throughput logging, and the OpenTelemetry Collector for metrics and traces.

Automating agent installation
```
gcloud beta compute instances create website-agent --zone=us-central1-a --machine-type=e2-micro --metadata=startup-script-url=gs://terraform-bkt-backend-01/webpage-config-with-agent-v1.sh --tags=http-server --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=website-agent
```

### Creating custom dashboard
```
//Method 1
 wget https://raw.githubusercontent.com/GoogleCloudPlatform/monitoring-dashboard-samples/master/dashboards/google-compute-engine/gce-vm-instance-monitoring.json

 gcloud monitoring dashboards create --config-from-file=gce-vm-instance-monitoring.json

//Method 2
    curl -X POST -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
    -H "Content-Type: application/json; charset=utf-8" \
    https://monitoring.googleapis.com/v1/projects/(YOUR-PROJECT-ID-HERE)/dashboards -d @gce-vm-instance-monitoring.json

curl -X POST -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
-H "Content-Type: application/json; charset=utf-8" \
https://monitoring.googleapis.com/v1/projects/playground-s-11-1b2cc446/dashboards -d @gce-vm-instance-monitoring.json
```


### Important gcloud commands
```
#### Create shell variables for Project ID and Project Number
export PROJECT_ID=$(gcloud config list --format 'value(core.project)')

export PROJECT_NUMBER=$(gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)")
```


#### Export dashboard using above variables. Substitute your dashboard ID and exported file name where appropriate
```
Export current dashboard by dashboard ID

gcloud monitoring dashboards describe \
projects/$PROJECT_NUMBER/dashboards/$DASH_ID --format=json > your-file.json


export DASH_ID=cdcb3cbe-8d2a-4bce-b969-649c18558eef
gcloud monitoring dashboards describe \
projects/$PROJECT_NUMBER/dashboards/$DASH_ID --format=json > your-file.json
```


## Uptime checks
A public uptime check can issue requests from multiple locations throughout the world to publicly available URLs or Google Cloud resources to see whether the resource responds.

Public uptime checks can determine the availability of the following monitored resources:
- Uptime check URL
- VM instance
- App Engine application
- Kubernetes service
- Amazon Elastic Compute Cloud (EC2) instance
- Amazon Elastic load balancer
- Cloud Run Revision

https://cloud.google.com/monitoring/uptime-checks



# Cloud logging
Set up repos

curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh
sudo apt update

Install latest version
```
sudo apt-get install google-fluentd
```
Install configuration files
```
sudo apt install -y google-fluentd-catch-all-config
```
Restart agent
```
sudo service google-fluentd start
```
Check status
```
sudo service google-fluentd status
```
### Resources 
https://acloudguru-content-attachment-production.s3-accelerate.amazonaws.com/1600872385381-website-instance-create-with-agent.txt

https://github.com/GoogleCloudPlatform/monitoring-dashboard-samples
https://github.com/GoogleCloudPlatform/monitoring-dashboard-samples.git