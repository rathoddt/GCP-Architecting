Deploying GKE Rolling Updates
Introduction

In this we deploy a containerized web app for Helloly, a brand new internet start-up that specialises in saying "Hello world!" as a service. To keep investors happy, you will quickly deploy version 1.0 of the app, using GKE best practices.


Create the GKE Cluster

    Using the main navigation, under COMPUTE, select Kubernetes Engine.
    If needed, click ENABLE.
    In the Kubernetes clusters* box, click CREATE.
    Under Cluster set-up guides on the right, click My first cluster.
    Click CREATE NOW.

        Note: This process can take a few minutes to complete.

Deploy the Hello World Application

    Click Connect on the newly created cluster.

    Under Command-line access, click Run in Cloud Shell.

    When prompted, click Continue.

    When the Cloud Shell has opened, hit Return to run the command.

    When prompted, click Authorize.

    Clone the kubernetes-engine-samples repo from GitHub:
    git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples

    Change to the /hello-app/manifests/ directory:
    cd kubernetes-engine-samples/hello-app/manifests

    Create the initial deployment using the helloweb-deployment.yaml file:
    kubectl apply -f helloweb-deployment.yaml

    Replace the placeholder text from the service YAML with helloweb-service-static-ip.yaml:
    sed -i '/YOUR.IP.ADDRESS.HERE/d' ./helloweb-service-static-ip.yaml

    Using kubectl apply, create the service:
    kubectl apply -f helloweb-service-static-ip.yaml

    After a few minutes, an external IP should be provisioned for your load balancer. Using kubectl get services, view the service and external IP:
    kubectl get services

    Copy the EXTERNAL-IP and paste it in a new browser tab to confirm the deployment is working.

Perform a Rolling Update and a Rollback

    Using kubectl set image, update the application to version 2.0 and make a record of the change:
    kubectl set image deployment/helloweb hello-app=gcr.io/google-samples/hello-app:2.0 --record

    Reload the browser tab with the deployment and confirm it has been updated to version 2.0.

    Confirm the rollout and view its status:
    kubectl rollout status deployment/helloweb

    Roll back to the previous version of the app:
    kubectl rollout undo deployment/helloweb

    Reload the browser tab with the deployment and confirm it has been reverted to version 1.0.

    View the history of all revisions for this deployment:
    kubectl rollout history deployment/helloweb

    Using the revision history, roll back to the updated deployment:
    kubectl rollout undo deployment/helloweb --to-revision=2

    Reload the browser tab with the deployment and confirm it has been updated to version 2.0.
