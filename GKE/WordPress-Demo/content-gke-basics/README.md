
## WordPress demo
Deploying WordPress and MySQL to GKE
Introduction

In this lab, we will create a reasonably complex application stack on Google Kubernetes Engine, creating deployments for WordPress and MySQL, utilizing persistent disks. To complete this lab, you should have some basic experience and familiarity with Google Cloud Platform and Google Kubernetes Engine.
Solution

Log in to the GCP Console using the credentials provided for the lab.

On the Welcome to your new account screen, review the text and click Accept. In the Welcome Cloud Student pop-up, check to agree to the terms of service, choose your country of residence, and click AGREE AND CONTINUE.
Create the GKE Cluster and Storage Class

    From the sidebar menu, select Kubernetes Engine.

    Click ENABLE.

    In the Kubernetes clusters window, click CREATE.

    In the upper right-hand corner, click on SWITCH TO STANDARD CLUSTER.

    In the sidebar menu, select the default-pool node pool.

    Verify the Number of nodes is set to 3, then click CREATE.

        Note: This process can take a few minutes to complete.

    While the cluster is being created, select the Activate Cloud Shell icon (>_) to the right of the top menu bar.

    When prompted, click CONTINUE.

    In the Cloud Shell terminal, clone the Git repo provided for the lab:
    ```
    git clone https://github.com/linuxacademy/content-gke-basics
    ```

    After the cluster is created, use the three-dot menu to the right of the cluster details to select Connect.

    Below Command-line access in the pop-up, click RUN IN CLOUD SHELL.

    After the command populates in the Cloud Shell terminal, run it.

        Note: If prompted, click AUTHORIZE to authorize API calls.

    Change to the content-gke-basics directory:
    ```
    cd content-gke-basics/
    ```

    Use the ssd-storageclass.yaml file to create a new storage class object that utilizes SSD persistent disks:
    ```
    kubectl apply -f ssd-storageclass.yaml
    ```

Create Persistent Volumes

    Use the mysql-pvc.yaml file to create the persistent volume claim for MySQL:
    ```
    kubectl apply -f mysql-pvc.yaml
    ```
    Use the wordpress-pvc.yaml file to create the persistent volume claim for WordPress:
    ```
    kubectl apply -f wordpress-pvc.yaml
    ```
    In the sidebar menu, select Storage to verify the persistent volume claims were created.

Deploy MySQL

    In the Cloud Shell terminal, create a new base64 encoded password:
    ```
    echo -n mypassword | base64 -w 0
    ```

    Copy everything in the output up until cloud_user.

    Above the terminal, click Open Editor.

        Note: You may need to enable third-party cookies to open the editor. Follow the on-screen instructions to do this. Afterwards, you may need to reopen the Cloud Shell terminal and the editor.

    In the sidebar menu, expand the content-gke-basics folder.

    Select `mysql-secret.yaml`.

    Replace the current value for password with the value you copied.

    In the editor's top menu bar, select File > Save.

    On the right, click Open Terminal.

    Back in the terminal, create the secret using the mysql-secret.yaml file:
    ```
    kubectl apply -f mysql-secret.yaml
    ```

    Use the mysql-deployment.yaml file to create the MySQL deployment:
    ```
    kubectl apply -f mysql-deployment.yaml
    ```

    Use the mysql-service.yaml file to create the MySQL service:
    ```
    kubectl apply -f mysql-service.yaml
    ```

    Verify that MySQL is running and ready:
    ```
    kubectl get pods
    ```

    View the ClusterIP service for MySQL:
    ```
    kubectl get services
    ```

Deploy WordPress

    Use the wordpress-deployment.yaml file to create the WordPress deployment:
    ```
    kubectl apply -f wordpress-deployment.yaml
    ```

    Use the wordpress-service.yaml file to create the WordPress service:
    ```
    kubectl apply -f wordpress-service.yaml
    ```

    Select the hamburger menu icon in the top left corner, then navigate to Kubernetes Engine > Workloads to verify the WordPress deployment was successful.

    From the Kubernetes Engine sidebar menu, select Services & Ingress.

    It will take a few minutes for the load balancer to assign an external IP address.

    After the external IP link appears in the Endpoints column, click it and then click the IP link again on the redirect page to view the deployed app.

```
git clone https://github.com/linuxacademy/content-gke-basics
ls 
cd content-gke-basics/
gcloud container clusters get-credentials cluster-1 --zone us-east1-b --project deploying-wo-201-fe12573f
alias k=kubectl
PS1=$
k apply -f ssd-storageclass.yaml 
k get sc
k apply -f mysql-pvc.yaml 
k apply -f wordpress-pvc.yaml 
k get pvc
echo -n mypassword | base64 -w 0

bXlwYXNzd29yZA==

k apply -f mysql-secret.yaml 
k apply -f mysql-deployment.yaml 
k apply -f mysql-service.yaml 
k get pods
k get svc
k apply -f wordpress-deployment.yaml 
k apply -f wordpress-service.yaml 
k get pods
k get svc
k get pods
```
