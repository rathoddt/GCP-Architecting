# SER Logging & Monitoring
Operations -Monitor, troubleshoot, improve application performance in cloud environment

Google four Golden signal 
 - latency
 - Errors
 - traffic
 - saturation


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


### Creating custom dashboard
```
 wget https://raw.githubusercontent.com/GoogleCloudPlatform/monitoring-dashboard-samples/master/dashboards/google-compute-engine/gce-vm-instance-monitoring.json

 gcloud monitoring dashboards create --config-from-file=gce-vm-instance-monitoring.json
```


### Resources 
https://acloudguru-content-attachment-production.s3-accelerate.amazonaws.com/1600872385381-website-instance-create-with-agent.txt

https://github.com/GoogleCloudPlatform/monitoring-dashboard-samples