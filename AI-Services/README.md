# GCP AI Services

https://cloud.google.com/natural-language
https://cloud.google.com/vision
https://cloud.google.com/document-ai



### Vertex AI Demo
```
BUCKET_NAME=$GOOGLE_CLOUD_PROJECT-bkt
echo $BUCKET_NAM
echo $BUCKET_NAME
gsutil mb -l us-east1 $BUCKET_NAME
gsutil mb -l us-east1 gs://$BUCKET_NAME
gcloud projects describe $GOOGLE_CLOUD_PROJECT 
ls
gcloud projects describe $GOOGLE_CLOUD_PROJECT > project-info.txt
cat project-info.txt 
PROJECT_NUM=$(cat project-info.txt | sed -nre 's:.*projectNumber\: (.*):\1:p')
echo $PROJECT_NUM
PROJECT_NAME=$(cat project-info.txt | sed -nre 's:.*projectId:\: (.*):\1:p')
SVC_ACCOUNT="${PROJECT_NUM//\'/}-compute@developer.gserviceaccount.com"
ECHO $SVC_ACCOUNT
echo $SVC_ACCOUNT
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:$SVC_ACCOUNT --role roles/storage.objectAdmin
gcloud config list --format 'value(core.project)
'
gcloud config list
gcloud config list --format 'value(core.project)' 2>/dev/null
gcloud config list --format 'value(core.project)' 1>/dev/null
```
