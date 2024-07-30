# VPC
VPC in GCP provides global network connectivity (inclusing regions). <i>Firewalls </i> on the other hand provides security to this network (VPC) and managed by network admin role


VPC can be share across projects


Primary IPs are used by VM
Secondary IPs are available for containers, docker, etc.

## Firewalls

```
gcloud compute --project=playground-s-11-ce98d3f4 firewall-rules create allow-ssh --direction=INGRESS --priority=1000 --network=acg-vpc-demo-01 --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0

gcloud compute --project=playground-s-11-ce98d3f4 firewall-rules create allow-icmp --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=icmp --target-tags=allow-icmp
```
## VPC Peering
SaaS - VPC peering  
IAM roles required to establish : Project Owner, Project Editor, and Network Admin

## Shared VPC

A Shared VPC network is a VPC network defined in a host project
and made available as a centrally shared network.
When a host project is enabled,
all of its existing VPC networks become Shared VPC network
and any new network created will also become a Shared VPC network.
A host project can have more than one Shared VPC network.

Once the host project has been enabled,
the Shared VPC Admin can attach one or more service projects
to the host project. Hosts and service projects
are connected by attachments at the project level.

Compute and GKE instances from any service projects
obtain their IP address information from the Shared VPC network
or VPC in the host project.

As we have centralized our network,
and so therefore, we would wanna connect
any type of external connection
to our centralized VPC network.
The same goes for VPC peering, VPNs,
those types of services should be created
in our host project,
and then shared with our service project.
Load balancing is the exception.
With load balancing, external IPs
belong to the service project
and are created in the service project
even if the internal IP comes from the Shared VPC.
Load balancing's the same way,
as it uses external IPs exposed to the public
to provide connectivity for our backend resources.
What about using GKE with our Shared VPC network?
Absolutely possible.
In the Shared VPC, alias IP addresses must be pre-created
before the service project request the GKE cluster.


Host project  
Service project

IAM role -Shared VPC Admin

https://cloud.google.com/vpc/docs/shared-vpc  
https://cloud.google.com/vpc/docs/provisioning-shared-vpc

## Cloud NAT
 Cloud NAT lets your VM instances and container pods communicate with the internet using a shared, public IP address.

Cloud NAT uses Cloud NAT gateway to manage those connections. Cloud NAT gateway is region and VPC network specific.


### VPC Service Controls
VPC Service Controls is security perimeter around Google cloud Services



https://github.com/leg100/gcp-hardening-guide


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


