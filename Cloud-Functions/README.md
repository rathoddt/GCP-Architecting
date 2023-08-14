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

### Resources 
git clone https://github.com/pluralsight-cloud/content-hands-on-with-google-cloud-functions
