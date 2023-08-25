# Cloud SQL

### Operations
- Cloning
- Configuring private and public IP connectivity
- Configuring SSL(keys and certitficates) and database flags
- Connecting from cloud instance (using private/public IP)
- Enabling/disabling high avaliability by creating multi-zone - at time of creation/existing DB 
	- Promoting standby instance
- Create read replica (standby and read replica can be created on same instance)
- Import export
- Managing users





Backups allow you to restore instances to recover lost data or undo errors.

To help you save money, backups work incrementally. Each backup stores only the changes to your data since the previous backup.




Steps for cloud SQL demo
1) Create Cloud SQL db and note the password
2) Create Client VM
3) Create Service Account with `Cloud SQL Client ` role
4) Create Key for SA
5) Upload MySQl dump file and SA key to Client VM
6) Install `mysql-client ` and downlaod `cloud-sql-proxy` to Client Vm


### Connection from cloud shell
```
gcloud sql connect mysql-inst-01 --user=root --quiet
```


```
sudo apt update
sudo apt install mysql-client
curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.6.0/cloud-sql-proxy.linux.amd64
ls
chmod +x cloud-sql-proxy 
```
7) Enable `Cloud SQL Admin API `
7) Get connection name from newly created database ans issue following command in Client VM
```
 
 ./cloud-sql-proxy \
--credentials-file PATH_TO_KEY_FILE INSTANCE_CONNECTION_NAME &

./cloud-sql-proxy \
--credentials-file fourm-sa.json serverless-gcp-391314:us-central1:forumdb &

mysql -u root -p --host 127.0.0.1
CREATE DATABASE forum;
#exit after creating database

#Now import database
mysql -u root -p --host 127.0.0.1 forum < forumdb.sql 

# Login back
mysql -u root -p --host 127.0.0.1
use forum;
show tables;

#You should see data imported
select count(*) from authors;
```


### SSL Connection

```
mysql -uroot -p -h 34.72.29.236 --ssl-ca=server-ca.pem --ssl-cert=client-cert.pem --ssl-key=client-key.pem
```


### Connecting from VM 
Private IP  
-----------
cloud-sql-ip-range (10.91.110.0/24, new) 

Public IP  
-----------

Add network and enter Vm instance Public IP

```
sudo apt update
sudo apt install mysql-client

sudo apt install mariadb-client


mysql -h 35.202.106.206 -u root -p

//Using private IP
mysql -h 10.91.110.3 -u root -p
```

# Import

https://cloud.google.com/sql/docs/mysql/import-export/import-export-sql#gcloud

Describe the instance you are importing to:
```
gcloud sql instances describe INSTANCE_NAME
```
Copy the `serviceAccountEmailAddress` field.
Use gsutil iam to grant the storage.objectAdmin IAM role to the service account for the bucket.
```
gsutil iam ch serviceAccount:SERVICE-ACCOUNT:objectAdmin \
gs://BUCKET_NAME
```
For help with setting IAM permissions, see Using IAM permissions.
Import the database:
```
gcloud sql import sql INSTANCE_NAME gs://BUCKET_NAME/IMPORT_FILE_NAME \
--database=DATABASE_NAME
```

```

gsutil iam ch serviceAccount:client-py-apis@serverless-gcp-391314.iam.gserviceaccount.com:objectAdmin gs://terraform-bkt-backend-03/forumdb.sql

gcloud sql import sql ha-instance gs://terraform-bkt-backend-03/forumdb.sql --database=nike


//Describe the instance you are importing to:

gcloud sql instances describe INSTANCE_NAME

gcloud sql instances describe ha-instance 

gsutil iam ch serviceAccount:p232560180807-kwaes6@gcp-sa-cloud-sql.iam.gserviceaccount.com:objectAdmin  gs://terraform-bkt-backend-02/


gcloud sql import sql ha-instance gs://terraform-bkt-backend-02/authors.sql --database=test
```