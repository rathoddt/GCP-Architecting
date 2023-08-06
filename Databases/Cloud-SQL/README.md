# Cloud SQL
Steps for cloud SQL demo
1) Create Cloud SQL db and note the password
2) Create Client VM
3) Create Service Account with `Cloud SQL Client ` role
4) Create Key for SA
5) Upload MySQl dump file and SA key to Client VM
6) Install `mysql-client ` and downlaod `cloud-sql-proxy` to Client Vm
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