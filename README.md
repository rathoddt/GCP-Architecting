# GCP-Architecting


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