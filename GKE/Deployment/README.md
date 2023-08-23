# Deployment

```
docker image prune
docker images
docker build -t myapp .
docker tag myapp gcr.io/playground-s-11-4cf30012/myapp:blue 
docker images


docker build -t myapp .
docker tag myapp gcr.io/playground-s-11-4cf30012/myapp:green

docker build -t myapp .
docker tag myapp gcr.io/playground-s-11-4cf30012/myapp:red

docker images
docker push gcr.io/playground-s-11-4cf30012/myapp:green
docker push gcr.io/playground-s-11-4cf30012/myapp:blue
docker push gcr.io/playground-s-11-4cf30012/myapp:red



kubectl apply -f myapp-deployment.yaml 

k get all
k apply -f myapp-service.yaml 
k get all
k get pods -o wide

k taint nodes  gke-deployment-demo-default-pool-2762ef3f-lwtq  key=value:NoSchedule

k delete pod myapp-deployment-596f5d56bf-ck7bx

k get all

k get pods -o wide

k get pods -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name

k taint nodes  gke-deployment-demo-default-pool-2762ef3f-lwtq  key=value:NoSchedule-
k apply -f myapp-deployment.yaml --record

k get all


kubectl rollout status deployment.apps/myapp-deployment 

kubectl rollout history deployment.apps/myapp-deployment 

k rollout undo

k rollout undo deployment.apps/myapp-deployment
```