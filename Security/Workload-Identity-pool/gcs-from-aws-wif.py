
import google.auth
import os
#from google.cloud import storage
from google.cloud import storage
#os.environ['GOOGLE_APPLICATION_CREDENTIALS']='config.json'
os.environ['GOOGLE_APPLICATION_CREDENTIALS']='sts-creds.json'
os.environ['GOOGLE_CLOUD_PROJECT']="my-poc-dilip"
client = storage.Client()
buckets = client.list_buckets()
for bucket in buckets:
    print(bucket.name)