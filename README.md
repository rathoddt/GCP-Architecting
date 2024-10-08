# GCP-Architecting

Cloud Architect Role:  
- translating the business and technical requirements into a real-world implementation, often based on an existing environment.
- The architect creates the blueprint that allows an organization to leverage the power of Google Cloud.


### GCP Global Infrastructure
38
REGIONS

115
ZONES

187
NETWORK EDGE LOCATIONS
AVAILABLE IN

200+
COUNTRIES AND TERRITORIES



SLAs for different service
https://cloud.google.com/terms/sla

https://github.com/GoogleCloudPlatform/professional-services.git
https://github.com/GoogleCloudPlatform/professional-services


`Role` is what can I do

## Setting project
```
export PROJECT_ID=`gcloud config get-value core/project`
echo $PROJECT_ID
export PROJECT_NUMBER=`gcloud projects describe $PROJECT_ID --format='value(projectNumber)'`
echo $PROJECT_NUMBER
```
## Best Practices
Commonly adopted categories of tags/labels include 
	- technical tags (e.g., Environment, Workload, InstanceRole, and Name),
	- tags for automation (e.g., Patch Group, and SSMManaged), 
	- business tags (e.g., Owner), and 
	- Security tags (e.g., Confidentiality).




### Gcloud basic commands
```
gcloud compute instances list
gcloud compute zones list
gcloud compute regions list
gcloud compute machine-types list
gcloud compute machine-types list --filter="zone:us-central1-b"
gcloud compute machine-types list --filter="zone:( us-central1-b europe-west1-d )"
```



Setting GCP project to work with
```
gcloud config set project VALUE
# enabling APIs
gcloud services enable run.googleapis.com  cloudbuild.googleapis.com secretmanager.googleapis.com

# Cloning sample repo
git clone https://github.com/ACloudGuru-Resources/content-google-cloud-run-deep-dive/
```




## Creating GKE cluster
```
gcloud container clusters create acg --zone us-east1-b
```

Using `kubectl`, confirm the cluster was created successfully:
kubectl get nodes
Using git, clone the repository with the lab files:
```
git clone https://github.com/ACloudGuru-Resources/content-gcpro-operations.git
```


<b> Cloud Run </b>  
Cloudrun - Google cloud's serverless container-based compute engine

### Important gcloud commands
```
#### Create shell variables for Project ID and Project Number
export PROJECT_ID=$(gcloud config list --format 'value(core.project)')

export PROJECT_NUMBER=$(gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)")
```

```
ssh diliprathod_fullstack_developer@34.125.114.227
```

```
 gcloud auth activate-service-account generic-sa@my-poc-dilip.iam.gserviceaccount.com --key-file=c:\creds\key.json --project=my-poc-dilip
```

# References and resources
```
https://github.com/ACloudGuru-Resources
https://github.com/orgs/ACloudGuru-Resources/repositories
```