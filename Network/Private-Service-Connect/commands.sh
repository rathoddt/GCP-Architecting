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

dilip_rathod@cloudshell:~   $ gcloud compute networks subnets create vpc-demo-us-west2 --project=$prodproject --range=10.0.2.0/24 --network=vpc-demo-producer --region=us-west2
ERROR: (gcloud.compute.networks.subnets.create) Could not fetch resource:
 - Location REGION:us-west2 violates constraint constraints/gcp.resourceLocations on the resource projects/lookermspochsbc/regions/us-west2/subnetworks/vpc-demo-us-west2.

dilip_rathod@cloudshell:~   $ gcloud compute networks subnets create vpc-demo-us-west2 --project=$prodproject --range=10.0.2.0/24 --network=vpc-demo-producer --region=us-west2
ERROR: (gcloud.compute.networks.subnets.create) Could not fetch resource:
 - Location REGION:us-west2 violates constraint constraints/gcp.resourceLocations on the resource projects/lookermspochsbc/regions/us-west2/subnetworks/vpc-demo-us-west2.

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