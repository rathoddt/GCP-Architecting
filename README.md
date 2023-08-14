# GCP-Architecting

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