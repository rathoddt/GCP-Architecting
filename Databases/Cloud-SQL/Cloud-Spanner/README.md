# Cloud Spanner

Samples
```
git clone https://github.com/googleapis/python-spanner/tree/main/samples/samples
```

# Demo: Working with Cloud Spanner
# https://learn.acloud.guru/course/gcp-certified-professional-data-engineer/learn/b404afd2-7ff2-5d28-27e0-e9e04743d738/2d213650-8165-8805-d71d-0fe271afcef8/watch

1. Using the GCP console, go to the Spanner page
2. Click "CREATE A PROVISIONED INSTANCE"
3. Type "spannerlab" as instance name and instance ID
4. Select "Regional" and choose "us-east1 (South Carolina)"
5. Click "CREATE"
6. Click "CREATE DATABASE"
7. Use "demodb" as your database name
8. Copy and paste the following code under "DDL TEMPLATES":

CREATE TABLE Singers (
    SingerId INT64 NOT NULL,
    FirstName STRING(1024),
    LastName STRING(1024),
    SingerInfo BYTES(MAX),
) PRIMARY KEY (SingerId);
CREATE TABLE Albums (
    SingerId INT64 NOT NULL,
    AlbumId INT64 NOT NULL,
    AlbumTitle STRING(MAX)
) PRIMARY KEY (SingerId, AlbumId),
INTERLEAVE IN PARENT Singers ON DELETE CASCADE;

9. Click "CREATE"
10. Click "Activate Cloud Shell"
11. Type the following commands on your Cloud Shell:
12. git clone https://github.com/googleapis/python-spanner.git
13. cd python-spanner/samples/samples/
14. virtualenv env
15. source env/bin/activate
16. pip install -r requirements.txt
17. python snippets.py spannerlab --database-id demodb insert_with_dml
18. On the GCP console, click "Query"
19. Copy and paste the following query:

SELECT SingerId, AlbumId, AlbumTitle FROM Albums;

20. Click "RUN"
21. Type the following commands on your Cloud Shell:
22. python snippets.py spannerlab --database-id demodb insert_data
23. python snippets.py spannerlab --database-id demodb add_column