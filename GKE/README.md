# GKE
```
gcloud container clusters create acg --zone us-east1-b
kubectl get nodes
git clone https://github.com/ACloudGuru-Resources/content-gcpro-operations.git
cd content-gcpro-operations/trace/app/
ls
docker build -t acg-image .
docker images
docker tage acg-image gcr.io/discovering--219-2e56148a/acg-image 
docker tag acg-image gcr.io/discovering--219-2e56148a/acg-image 
docker images
docker push
docker push gcr.io/discovering--219-2e56148a/acg-image
cd ..
ls
bash setup.sh 
curl $(kubectl get svc cloud-trace-acg-c -ojsonpath='{.status.loadBalancer.ingress[0].ip}')
```