# GCP Networking

### Creating auto mode VPC using gcloud
```
gcloud compute networks create my-auto-network --project=my-poc-dilip --subnet-mode=auto --mtu=1460 --bgp-routing-mode=regional 

gcloud compute firewall-rules create my-auto-network-allow-custom --project=my-poc-dilip --network=projects/my-poc-dilip/global/networks/my-auto-network --description=Allows\ connection\ from\ any\ source\ to\ any\ instance\ on\ the\ network\ using\ custom\ protocols. --direction=INGRESS --priority=65534 --source-ranges=10.128.0.0/9 --action=ALLOW --rules=all && 

gcloud compute firewall-rules create my-auto-network-allow-icmp --project=my-poc-dilip --network=projects/my-poc-dilip/global/networks/my-auto-network --description=Allows\ ICMP\ connections\ from\ any\ source\ to\ any\ instance\ on\ the\ network. --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=icmp 

gcloud compute firewall-rules create my-auto-network-allow-rdp --project=my-poc-dilip --network=projects/my-poc-dilip/global/networks/my-auto-network --description=Allows\ RDP\ connections\ from\ any\ source\ to\ any\ instance\ on\ the\ network\ using\ port\ 3389. --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:3389 

gcloud compute firewall-rules create my-auto-network-allow-ssh --project=my-poc-dilip --network=projects/my-poc-dilip/global/networks/my-auto-network --description=Allows\ TCP\ connections\ from\ any\ source\ to\ any\ instance\ on\ the\ network\ using\ port\ 22. --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:22
```

### Creating custom VPC using gcloud

```
gcloud compute networks create my-custom-vpc --project=my-poc-dilip --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create subnet-a --project=my-poc-dilip --range=10.0.0.0/16 --stack-type=IPV4_ONLY --network=my-custom-vpc --region=asia-south1
```