#https://codelabs.developers.google.com/codelabs/connecting-to-cloud-sql-with-cloud-functions#2
# This file contains all the code used in the codelab. 
import sqlalchemy

# Depending on which database you are using, you'll set some variables differently. 
# In this code we are inserting only one field with one value. 
# Feel free to change the insert statement as needed for your own table's requirements.

# Uncomment and set the following variables depending on your specific instance and database:
connection_name = "playground-s-11-6eeea7a9:us-east1:guru-instance"
table_name = "books"
table_field = "title"
table_field_value = "Cloud Spanner database"
db_name = "library"
db_user = "root"
db_password = "root"

# If your database is MySQL, uncomment the following two lines:
driver_name = 'mysql+pymysql'
#query_string = dict({"unix_socket": "/cloudsql/{}".format(connection_name)})
query_string = "unix_socket': '/cloudsql/serverless-gcp-391314:us-east1:guru-sql-instance"
"mysql+pymysql://<USER>:<PASSWORD>@/<DATABASE_NAME>?unix_socket=/cloudsql/<PUT-SQL-INSTANCE-CONNECTION-NAME-HERE>"
"mysql+pymysql://root:root@/library?unix_socket=/cloudsql/serverless-gcp-391314:us-east1:guru-sql-instance"
# If your database is PostgreSQL, uncomment the following two lines:
#driver_name = 'postgres+pg8000'


#query_string =  dict({"unix_sock": "/cloudsql/{}/.s.PGSQL.5432".format(connection_name)})

# If the type of your table_field value is a string, surround it with double quotes.

def insert(request):
    request_json = request.get_json()
    stmt = sqlalchemy.text('insert into {} ({}) values ({})'.format(table_name, table_field, table_field_value))
    
    db = sqlalchemy.create_engine(
      sqlalchemy.engine.url.URL(
        drivername=driver_name,
        username=db_user,
        password=db_password,
        database=db_name,
        query=query_string,
      ),
      pool_size=5,
      max_overflow=2,
      pool_timeout=30,
      pool_recycle=1800
    )
    try:
        with db.connect() as conn:
            conn.execute(stmt)
    except Exception as e:
        return 'Error: {}'.format(str(e)) + ', Query string'+query_string
    return 'ok , ' + query_string