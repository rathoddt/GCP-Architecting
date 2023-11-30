# PostgreSQL

Start the Cloud SQL Auth Proxy
```
.\cloud-sql-proxy.x64.exe my-poc-dilip:us-west1:myinstance --port 5432 --private-ip 10.123.208.3

./cloud-sql-proxy my-poc-dilip:us-west1:myinstance --port 5432 --private-ip 10.123.208.5

psql "host=10.123.208.5 port=5432 sslmode=disable dbname=postgres user=postgres"


./cloud-sql-proxy my-poc-dilip:us-central1:mnqs --port 5432 --private-ip 10.123.208.3
psql "host=10.123.208.3 port=5432 sslmode=disable dbname=postgres user=postgres"
```


## Basic Postgress commands

List all databases - `\l`

List database tables - `\dt`

Connect db `\c postgres`

List all schemas - `\dn`

List users and their roles - `\du`


## Creating Sample Web application to Postgres
Setup DB and create VM

https://cloud.google.com/sql/docs/postgres/connect-instance-compute-engine#python

```
gcloud sql databases create quickstart_db --instance=mnqs
gcloud sql connect mnqs --user=postgres --quiet
gcloud sql users create quickstart-user --instance=mnqs --password=test

gcloud iam service-accounts create quickstart-service-account --description="SA" --display-name="quickstart-service-account"
gcloud projects add-iam-policy-binding my-poc-dilip --member="serviceAccount:quickstart-service-account@my-poc-dilip.iam.gserviceaccount.com" --role="roles/cloudsql.client" --role="roles/storage.objectViewer"

gcloud compute instances create quickstart-vm-instance1 --provisioning-model=SPOT --instance-termination-action=STOP --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/centos-cloud/global/images/centos-7-v20231115,mode=rw,size=20,type=projects/my-poc-dilip/zones/us-central1-a/diskTypes/pd-balanced  --machine-type=e2-medium --service-account=quickstart-service-account@my-poc-dilip.iam.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server --zone=us-central1-a

 


gcloud compute instances create instance-1 --project=my-poc-dilip \
--zone=us-central1-a \
--machine-type=e2-medium \
--network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
--no-restart-on-failure \
--maintenance-policy=TERMINATE \
--provisioning-model=SPOT \
--instance-termination-action=STOP \
--service-account=490239511999-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/centos-cloud/global/images/centos-7-v20231115,mode=rw,size=20,type=projects/my-poc-dilip/zones/us-central1-a/diskTypes/pd-balanced \
--no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

```

```
gcloud compute ssh --project=my-poc-dilip --zone=us-central1-a quickstart-vm-instance

//Setup VM or python 
//https://cloud.google.com/python/docs/setup#linux

sudo apt update
sudo apt install wget build-essential libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

sudo apt install software-properties-common
sudo apt update
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.11

sudo find / -name "python3.11" 
sudo apt install python3.11
sudo apt install python3 python3-dev python3-venv
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

pip3 --version
sudo apt-get install git

git clone https://github.com/GoogleCloudPlatform/python-docs-samples
cd python-docs-samples/cloud-sql/postgres/sqlalchemy
export INSTANCE_CONNECTION_NAME='my-poc-dilip:us-central1:mnqs'

export DB_PORT='5432'
export DB_NAME='quickstart_db'
export DB_USER='quickstart-user'
export DB_PASS='test'
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt

pip install flask

pip install sqlalchemy

python3 -m pip install cloud-sql-python-connector
pip install cloud-sql-python-connector
sudo pip install cloud-sql-python-connector
python app.py
python3 -m pip freeze | grep cloud
python3 -m pip install cloud-sql-python-connector==0.34.0
sudo  pip install cloud-sql-python-connector==0.34.0
pip install "cloud-sql-python-connector[pg8000]"
python app.py

```


Installing postgres SQL Client
```
sudo apt-get update
sudo apt-get install postgresql-client
curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.7.2/cloud-sql-proxy.linux.amd64

chmod +x cloud-sql-proxy
./cloud-sql-proxy my-poc-dilip:us-central1:mnqs
./cloud-sql-proxy my-poc-dilip:us-central1:mnqs --port 5432 --private-ip 10.123.208.3
psql "host=10.123.208.3 port=5432 sslmode=disable dbname=postgres user=postgres"
./cloud-sql-proxy my-poc-dilip:us-central1:mnqs --port 5432 --private-ip 10.123.208.3
psql "host=10.123.208.3 port=5432 sslmode=disable dbname=postgres user=postgres"

```