# PostgreSQL

Start the Cloud SQL Auth Proxy
```
.\cloud-sql-proxy.x64.exe my-poc-dilip:us-west1:myinstance --port 5432 --private-ip 10.123.208.3

./cloud-sql-proxy my-poc-dilip:us-west1:myinstance --port 5432 --private-ip 10.123.208.5


psql "host=10.123.208.5 port=5432 sslmode=disable dbname=postgres user=postgres"
```




