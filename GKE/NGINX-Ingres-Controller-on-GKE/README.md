# Configuring the NGINX Ingress Controller on GKE

Your applications team has prepared two containerized applications that you would like to run on GKE. There is a technical requirement to run both applications at different paths of the same IP address, as well as a business requirement to limit the number of Cloud load balancers deployed. For this reason, you have chosen to use the NGINX Ingress Controller to serve these applications to the Internet.

Create and Connect to a GKE Cluster

1. Using the main navigation menu, in the COMPUTE section, select Kubernetes Engine.

2. Click ENABLE.

    Once enabled, click CREATE.

    Next to GKE Standard, click CONFIGURE.

    In the menu on the left, under Node Pools, select the default-pool.

    Under Node pool details, in the Size section, change the Number of nodes to "2".

    In the menu on the left, select Nodes.

    Change the Machine type to e2-small.

    Click CREATE.

    

Once created, from the Clusters page, click the new cluster.

At the top of the page, click CONNECT.

Under Command-line access, click RUN IN CLOUD SHELL.

When prompted, click Continue.

When the Cloud Shell has spawned, hit Return to run the command.

When prompted, click Authorize.


Install the Nginx Ingress Controller

    From the Cloud Shell, using kubectl, install the NGINX Ingress Controller components by using the public provider manifest:
    ```
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/cloud/deploy.yaml
    ```
    Confirm the controller is installed and running by viewing its deployment:
    ```
    kubectl get deployments -n ingress-nginx
    ```

    Find the external IP of Nginx:
    ```
    kubectl get services -n ingress-nginx
    ```
    Navigate to the IP address using a new browser tab. If you get an NGINX 404 Not Found error, everything is working fine. Nginx is up and running, but there are no Ingress objects, so no backend is found.


### Install the Nginx Ingress Controller

From the Cloud Shell, using kubectl, install the NGINX Ingress Controller components by using the public provider manifest:
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/cloud/deploy.yaml

Confirm the controller is installed and running by viewing its deployment:
    kubectl get deployments -n ingress-nginx

Find the external IP of Nginx:
    kubectl get services -n ingress-nginx

Navigate to the IP address using a new browser tab. If you get an NGINX 404 Not Found error, everything is working fine. Nginx is up and running, but there are no Ingress objects, so no backend is found.

Deploy the First Application and Ingress

Create the hello-app deployment:
    kubectl create deployment hello-app --image=gcr.io/google-samples/hello-app:1.0

Expose the deployment:
    kubectl expose deployment hello-app --port=8080 --target-port=8080

Click Open Editor.

    When prompted, open the Editor in a new window.


When prompted, open the Editor in a new window.

Using the File menu, click New File.

Name the file "hello-ingress.yaml" and click OK.

In the new file, paste the following:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-app-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"

spec:
  rules:
   - http:
      paths:
      - path: /hello
        pathType: Prefix
        backend:
          service:
            name: hello-app
            port:
              number: 8080
```


Using the File menu, click Save.

Return to the Cloud Shell terminal tab and click Open Terminal.

Apply the manifest to the cluster to create the Ingress:
    kubectl apply -f hello-ingress.yaml

Return to the browser tab where you pasted the external IP and reload the Nginx IP address but append the url with "/hello". You should now be able to see the hello-app service.

### Deploy the Second Application and Ingress



Create the whereami deployment:
    kubectl create deployment whereami-app --image=gcr.io/google-samples/whereami:v1.1.1

Expose the deployment:
    kubectl expose deployment whereami-app --port=8080 --target-port=8080

Return to the Cloud Editor tab.

Using the File menu, click New File.

Name your new file "whereami-ingress.yaml" and click OK.
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: whereami-app-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"

spec:
  rules:
   - http:
      paths:
      - path: /whereami
        pathType: Prefix
        backend:
          service:
            name: whereami-app
            port:
              number: 8080
```



Apply the manifest to the cluster:
    kubectl apply -f whereami-ingress.yaml

Return to the browser tab where you pasted the external IP and reload the Nginx IP address but add "/whereami" to the URL. You should now be able to see the whereami app.
