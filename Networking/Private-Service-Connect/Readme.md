# Private Service Connect
Steps for creating Private Service Connect
https://codelabs.developers.google.com/cloudnet-psc-ilb#8
```
dilip_rathod@cloudshell:~   $ gcloud compute networks create vpc-demo-producer --project=$prodproject --subnet-mode=custom
Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/global/networks/vpc-demo-producer].
NAME: vpc-demo-producer
SUBNET_MODE: CUSTOM
BGP_ROUTING_MODE: REGIONAL
IPV4_RANGE: 
GATEWAY_IPV4: 

Instances on this network will not be reachable until firewall rules
are created. As an example, you can allow all internal traffic between
instances as well as SSH, RDP, and ICMP by running:

$ gcloud compute firewall-rules create <FIREWALL_NAME> --network vpc-demo-producer --allow tcp,udp,icmp --source-ranges <IP_RANGE>
$ gcloud compute firewall-rules create <FIREWALL_NAME> --network vpc-demo-producer --allow tcp:22,tcp:3389,icmp

dilip_rathod@cloudshell:~   $ gcloud compute networks subnets create vpc-demo-europe-west2 --project=$prodproject --range=10.0.2.0/24 --network=vpc-demo-producer --region=europe-west2
Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/regions/europe-west2/subnetworks/vpc-demo-europe-west2].
NAME: vpc-demo-europe-west2
REGION: europe-west2
NETWORK: vpc-demo-producer
RANGE: 10.0.2.0/24
STACK_TYPE: IPV4_ONLY
IPV6_ACCESS_TYPE: 
INTERNAL_IPV6_PREFIX: 
EXTERNAL_IPV6_PREFIX: 
dilip_rathod@cloudshell:~   $ gcloud compute routers create crnatprod --network vpc-demo-producer --region europe-west2
Creating router [crnatprod]...done.                                                                                                                                           
NAME: crnatprod
REGION: europe-west2
NETWORK: vpc-demo-producer
dilip_rathod@cloudshell:~   $ gcloud compute routers nats create cloudnatprod --router=crnatprod --auto-allocate-nat-external-ips --nat-all-subnet-ip-ranges --enable-logging --region europe-west2
Creating NAT [cloudnatprod] in router [crnatprod]...done.      


gcloud compute instances create www-01     --zone=europe-west2-a     --image=https://www.googleapis.com/compute/v1/projects/debian
-cloud/global/images/family/debian-11    --subnet=vpc-demo-europe-west2 --no-address     --metadata=startup-script='#! /bin/bash
apt-get update
apt-get install tcpdump -y
apt-get install apache2 -y
a2ensite default-ssl
apt-get install iperf3 -y
a2enmod ssl
vm_hostname="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/name)"
filter="{print \$NF}"
vm_zone="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/zone \
| awk -F/ "${filter}")"
echo "Page on $vm_hostname in $vm_zone" | \
tee /var/www/html/index.html
systemctl restart apache2
iperf3 -s -p 5050'
Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/zones/europe-west2-a/instances/www-01].
NAME: www-01
ZONE: europe-west2-a
MACHINE_TYPE: n1-standard-1
PREEMPTIBLE: 
INTERNAL_IP: 10.0.2.2
EXTERNAL_IP: 
STATUS: RUNNING


gcloud compute instances create www-02     --zone=europe-west2-a     --image=https://www.googleapis.com/compute/v1/projects/debian
-cloud/global/images/family/debian-11     --subnet=vpc-demo-europe-west2 --no-address     --metadata=startup-script='#! /bin/bash
apt-get update
apt-get install tcpdump -y
apt-get install apache2 -y
a2ensite default-ssl
apt-get install iperf3 -y
a2enmod ssl
vm_hostname="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/name)"
filter="{print \$NF}"
vm_zone="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/zone \
| awk -F/ "${filter}")"
echo "Page on $vm_hostname in $vm_zone" | \
tee /var/www/html/index.html
systemctl restart apache2
iperf3 -s -p 5050'
Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/zones/europe-west2-a/instances/www-02].
NAME: www-02
ZONE: europe-west2-a
MACHINE_TYPE: n1-standard-1
PREEMPTIBLE: 
INTERNAL_IP: 10.0.2.3
EXTERNAL_IP: 
STATUS: RUNNING



## 9. Create unmanaged instance group
Create a unmanaged instance group consisting of www-01 & www-02

From Cloud Shell


gcloud compute instance-groups unmanaged create vpc-demo-ig-www --zone=europe-west2-a
Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/zones/europe-west2-a/instanceGroups/vpc-demo-ig-www].
NAME: vpc-demo-ig-www
LOCATION: europe-west2-a
SCOPE: zone
NETWORK: 
MANAGED: 
INSTANCES: 0


gcloud compute instance-groups unmanaged add-instances vpc-demo-ig-www --zone=europe-west2-a --instances=www-01,www-02

Updated [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/zones/europe-west2-a/instanceGroups/vpc-demo-ig-www].


gcloud compute health-checks create http hc-http-80 --port=80
Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/global/healthChecks/hc-http-80].
NAME: hc-http-80
PROTOCOL: HTTP


## 10. Create TCP backend services, forwarding rule & firewall
From Cloud Shell create the backend service

```
gcloud compute backend-services create vpc-demo-www-be-tcp --load-balancing-scheme=internal --protocol=tcp --region=europe-west2 --health-checks=hc-http-80

Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/regions/europe-west2/backendServices/vpc-demo-www-be-tcp].
NAME: vpc-demo-www-be-tcp
BACKENDS: 
PROTOCOL: TCP

gcloud compute backend-services add-backend vpc-demo-www-be-tcp --region=europe-west2 --instance-group=vpc-demo-ig-www --instance-group-zone=europe-west2-a

gcloud compute backend-services add-backend vpc-demo-www-be-tcp --region=europe-west2 --instance-group=vpc-demo-ig-www --instance-group-zone=europe-west2-a
Updated [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/regions/europe-west2/backendServices/vpc-demo-www-be-tcp].


From Cloud Shell create the forwarding rule

gcloud compute forwarding-rules create vpc-demo-www-ilb-tcp --region=europe-west2 --load-balancing-scheme=internal --network=vpc-demo-producer --subnet=vpc-demo-europe-west2 --address=10.0.2.10 --ip-protocol=TCP --ports=all --backend-service=vpc-demo-www-be-tcp --backend-service-region=europe-west2

Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/regions/europe-west2/forwardingRules/vpc-demo-www-ilb-tcp].

From Cloud Shell create a firewall rule to enable backend health checks

gcloud compute firewall-rules create vpc-demo-health-checks --allow tcp:80,tcp:443 --network vpc-demo-producer --source-ranges 130.211.0.0/22,35.191.0.0/16 --enable-logging

Creating firewall...working..Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/global/firewalls/vpc-demo-health-checks].                                
Creating firewall...done.                                                                                                                                                     
NAME: vpc-demo-health-checks
NETWORK: vpc-demo-producer
DIRECTION: INGRESS
PRIORITY: 1000
ALLOW: tcp:80,tcp:443
DENY: 
DISABLED: False


To allow IAP to connect to your VM instances, create a firewall rule that:

Applies to all VM instances that you want to be accessible by using IAP.
Allows ingress traffic from the IP range 35.235.240.0/20. This range contains all IP addresses that IAP uses for TCP forwarding.
From Cloud Shell


gcloud compute firewall-rules create psclab-iap-prod --network vpc-demo-producer --allow tcp:22 --source-ranges=35.235.240.0/20 --enable-logging

NAME: psclab-iap-prod
NETWORK: vpc-demo-producer
DIRECTION: INGRESS
PRIORITY: 1000
ALLOW: tcp:22
DENY: 
DISABLED: False
```

# 11. Create TCP NAT subnet
From Cloud Shell

```
gcloud compute networks subnets create vpc-demo-europe-west2-psc-tcp --network=vpc-demo-producer --region=europe-west2 --range=192.168.0.0/24 --purpose=private-service-connect

Created [https://www.googleapis.com/compute/v1/projects/lookermspochsbc/regions/europe-west2/subnetworks/vpc-demo-europe-west2-psc-tcp].
NAME: vpc-demo-europe-west2-psc-tcp
REGION: europe-west2
NETWORK: vpc-demo-producer
RANGE: 192.168.0.0/24
STACK_TYPE: 
IPV6_ACCESS_TYPE: 
INTERNAL_IPV6_PREFIX: 
EXTERNAL_IPV6_PREFIX: 
```

# 12. Create TCP service attachment and firewall rules
From Cloud Shell create the TCP service attachment


gcloud compute service-attachments create vpc-demo-psc-west2-tcp --region=us-west2 --producer-forwarding-rule=vpc-demo-www-ilb-tcp --connection-preference=ACCEPT_AUTOMATIC --nat-subnets=vpc-demo-us-west2-psc-tcp
Validate the TCP service attachment


gcloud compute service-attachments describe vpc-demo-psc-west2-tcp --region us-west2
From Cloud Shell create the firewall rule allowing TCP NAT subnet access to the ILB backend


gcloud compute --project=$prodproject firewall-rules create vpc-demo-allowpsc-tcp --direction=INGRESS --priority=1000 --network=vpc-demo-producer --action=ALLOW --rules=all --source-ranges=192.168.0.0/24 --enable-logging
Back