#---------------------------------------------------------------------------
#Workload Identity Federation
#---------------------------------------------------------------------------
#Part A Gcloud Commands
#=======================
gcloud config set project my-poc-dilip
export PROJECT_ID=`gcloud config get-value core/project`
export PROJECT_NUMBER=`gcloud projects describe $PROJECT_ID --format='value(projectNumber)'`
echo $PROJECT_NUMBER
gcloud iam service-accounts create aws-federated
gcloud iam service-accounts list

gsutil mb gs://$PROJECT_ID-mybucket
echo fooooo > foo.txt
gsutil cp foo.txt gs://$PROJECT_ID-mybucket
gsutil iam ch serviceAccount:aws-federated@$PROJECT_ID.iam.gserviceaccount.com:objectViewer gs://$PROJECT_ID-mybucket
gcloud config set project my-poc-dilip

#Manual
#------------------------
gcloud iam workload-identity-pools create aws-pool-1 --location="global" --description="AWS manual way" --display-name="AWS Pool - manual"
gcloud iam workload-identity-pools providers create-aws aws-provider-1 --workload-identity-pool="aws-pool-1"     --account-id="740429994000"   --location="global"
# Subject-user
gcloud iam service-accounts add-iam-policy-binding aws-federated@$PROJECT_ID.iam.gserviceaccount.com       --role roles/iam.workloadIdentityUser --member "principal://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/aws-pool-1/subject/arn:aws:iam::740429994000:user/svcacct1"

# Session
gcloud iam service-accounts add-iam-policy-binding aws-federated@$PROJECT_ID.iam.gserviceaccount.com       --role roles/iam.workloadIdentityUser --member "principal://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/aws-pool-1/subject/arn:aws:sts::740429994000:assumed-role/gcpsts/mysession"

# Automatic - using client library
gcloud iam workload-identity-pools create aws-pool-2     --location="global"     --description="AWS "     --display-name="AWS Pool 2"

gcloud iam workload-identity-pools providers create-aws aws-provider-2     --workload-identity-pool="aws-pool-2"     --account-id="740429994000"      --location="global" 

gcloud iam service-accounts add-iam-policy-binding aws-federated@$PROJECT_ID.iam.gserviceaccount.com       --role roles/iam.workloadIdentityUser     --member "principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/aws-pool-2/attribute.aws_role/arn:aws:sts::740429994000:assumed-role/gcpsts" 

gcloud iam service-accounts add-iam-policy-binding aws-federated@$PROJECT_ID.iam.gserviceaccount.com       --role roles/iam.workloadIdentityUser     --member "principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/aws-pool-2/attribute.aws_role/arn:aws:sts::740429994000:assumed-role/ec2role" 

gcloud beta iam workload-identity-pools create-cred-config     projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/aws-pool-2/providers/aws-provider-2     --service-account=aws-federated@$PROJECT_ID.iam.gserviceaccount.com     --output-file=sts-creds.json     --aws