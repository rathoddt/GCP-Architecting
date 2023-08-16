# Cloud function

Google Cloud Functions is a serverless event-driven managed platform for building and connecting cloud services.

- Connects and extends services
- Zero server management
- Automatic scaling
- Pay only for execution time
- Open-source Function as a Service (FaaS)

### First generation Cloud Functions
Max memory 8 GB; max processing 2 vCPUs  
One request per instance  
Limited set of triggers  
- HTTP
- Cloud Storage
- Pub/Sub
- Logging
- Firestore
- Firebase (DB, Storage, Analytics, Auth)


### Second generation Cloud Functions
Based on   
- Cloudrun - Google cloud's serverless container-based compute engine
- Eventarc - GCP service for building serverless architecture

Share limits and quotas with CloudRun  

Features:  
- 16 GB RAM, 4 vCPUs
- Supports Eventarc triggers
- Up to 1 hour HTTP processing
- Up to 1,000 concurrent requests
- Native CloudEvents specification support
- Handles traffic splitting

API to be enabled
- Cloud Functions API 
- Cloud Run API 
- Cloud Build API 
- Artifact Registry API 


```
gcloud functions deploy FUNCTION_NAME \
[--gen2] \
--region=REGION \
---source=[LOCAL_PATH] [BUCKET_NAME] [REPOSITORY_URL] \
--entry-point=CODE_ENTRYPOINT \
[--trigger-http]
[--trigger-topic=PUBSUB_TOPIC]
[--trigger-bucket=BUCKET_NAME]
[--trigger-event=EVENT_TYPE]
[--trigger-resource=RESOURCE]
[--trigger-event-filters=EVENTARC_EVENT_FILTERS]
```


## Applying 1st Gen Triggers

#### HTTP Triggers  

Pass GET, POST, PUT, DELETE, or OPTIONS argument and values via query parameters to the Cloud Function-generated URL

```
// Configure HTTP-triggered Cloud Function
gcloud functions deploy YOUR_FUNCTION_NAME --trigger-http \
[--allow-unauthenticated] [--security-level=SECURITY_LEVEL] ...

// Use allow-unauthenticated flag to override default (authentication required)
// Set security-level flag to secure-optional to allow both HTTP and HTTPS
```

#### Firing a Pub/Sub Trigger
Function triggered when message published to specified topic

```
// Deploy 1st gen Cloud Pub/Sub-triggered function
gcloud functions deploy FUNCTION_NAME \
--trigger-event=providers/cloud.pubsub/eventTypes/topic.publish \
--trigger-resource=YOUR_PUBSUB_TOPIC ...
```

#### Activating a Cloud Storage Trigger
Must specify event type unless object finalized (default)

```
// Deploy 1st gen Cloud Storage-triggered function
gcloud functions deploy FUNCTION_NAME \
[--trigger-event=google.storage.object.delete] \
[--trigger-event=google.storage.object.archive] \
[--trigger-event=google.storage.object.metadataUpdate] \
--trigger-resource=YOUR_STORAGE_BUCKET...

```


#### Initiating Firestore Triggers
The following events are supported: `create, update, delete`, and `write`.  
After it’s triggered, Cloud Function receives document data object:
	- Includes before and after state for `update`and `write` events.  
Specify data to monitor via document path.  
Wildcards are supported:
	- users/{username}
	- users/{username}/addresses/{phone}

#### Working with Firebase Triggers
Google Analytics  
	- Triggers on Apple or Android conversion events, such as inapp purchase

Realtime Database  
	- Similar to Firestore with event types, data received, and path wildcards

Authentication  
	- Triggers on user creation/first-time sign-in or deletion events

Remote Config  
	- Triggers when Remote Config service updates for UI and app changes 

```
print(f"Temporary hold status: {file['temporaryHold']}.") 
```
### Resources 
git clone https://github.com/pluralsight-cloud/content-hands-on-with-google-cloud-functions


https://codelabs.developers.google.com/codelabs/connecting-to-cloud-sql-with-cloud-functions#2