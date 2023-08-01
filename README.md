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
