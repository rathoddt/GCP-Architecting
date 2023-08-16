# Connecting to Cloud SQL with Cloud Functions 

In cloud shell
```
gcloud sql connect guru-instance --user=root --quiet

create table books (title varchar(80), author varchar(20));

insert into books values ("Cloud Function Basics", "Dilip Rathod");


```

Assign `Cloud SQL Client` role to `615101570642-compute@developer.gserviceaccount.com`. This is default `Compute Engine default service account` role cloud function uses.


https://codelabs.developers.google.com/codelabs/connecting-to-cloud-sql-with-cloud-functions#2