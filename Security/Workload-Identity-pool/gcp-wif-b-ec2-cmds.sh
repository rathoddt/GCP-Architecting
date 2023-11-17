#---------------------------------------------------------------------------
#Workload Identity Federation
#---------------------------------------------------------------------------
#Part B EC2 setup Commands
#=======================
sudo pip install google-cloud
sudo pip install google-cloud-storage
sudo pip install google-cloud-core
sudo pip install google-cloud-resumable-media
sudo pip install --upgrade google-cloud-storage

STS_TOKEN=$(curl https://sts.googleapis.com/v1/token \
    --data-urlencode "audience=//iam.googleapis.com/projects/my-poc-dilip/locations/global/workloadIdentityPools/to-aws-ec2-03/providers/aws-dilip" \   
    --data-urlencode "grant_type=urn:ietf:params:oauth:grant-type:token-exchange" \
    --data-urlencode "requested_token_type=urn:ietf:params:oauth:token-type:access_token" \
    --data-urlencode "scope=https://www.googleapis.com/auth/cloud-platform" \
    --data-urlencode "subject_token_type=$SUBJECT_TOKEN_TYPE" \
    --data-urlencode "subject_token=$SUBJECT_TOKEN" | jq -r .access_token)  

echo $STS_TOKEN
STS_TOKEN=$(curl https://sts.googleapis.com/v1/token \
--data-urlencode "audience=//iam.googleapis.com/projects/my-poc-dilip/locations/global/workloadIdentityPools/to-aws-ec2-03/providers/aws-dilip" \       
STS_TOKEN=$(curl https://sts.googleapis.com/v1/token \
--data-urlencode "audience=//iam.googleapis.com/projects/my-poc-dilip/locations/global/workloadIdentityPools/to-aws-ec2-03/providers/aws-dilip" \       
--data-urlencode "grant_type=urn:ietf:params:oauth:grant-type:token-exchange" \
 --data-urlencode "requested_token_type=urn:ietf:params:oauth:token-type:access_token" \
 --data-urlencode "scope=https://www.googleapis.com/auth/cloud-platform" \  
--data-urlencode "subject_token_type=$SUBJECT_TOKEN_TYPE" \
 --data-urlencode "subject_token=$SUBJECT_TOKEN" | jq -r .access_token)     
echo $STS_TOKEN
ACCESS_TOKEN=$(curl -0 -X POST https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/SERVICE_ACCOUNT_EMAIL:generateAccessToken \
    -H "Content-Type: text/json; charset=utf-8" \
    -H "Authorization: Bearer $STS_TOKEN" \
    -d @- <<EOF | jq -r .accessToken
    {
        "scope": [ "https://www.googleapis.com/auth/cloud-platform" ]       
    }
EOF
)

aws sts get-caller-identity
vim sts-creds.json
python to-gcp.py


pip install google-cloud-bigquery
sudo pip install google-cloud-bigquery
python bq-demo.py

aws sts assume-role --role-arn arn:aws:iam::740429994000:role/gcpsts --role-session-name mysession

aws sts get-caller-identity
export GOOGLE_APPLICATION_CREDENTIALS=`pwd`/sts-creds.json
echo $GOOGLE_APPLICATION_CREDENTIALS
cat $GOOGLE_APPLICATION_CREDENTIALS
sudo yum install golang -y
go version
vim main.go

vim go.mod
vim go.sum
go run main.go    --gcpBucket my-poc-dilip-mybucket    --gcpObjectName foo.txt    --useADC

python to-gcp.py

vim sts-creds1.json
vim to-gcp.py
python to-gcp.py
diff sts-creds.json sts-creds1.json