# Google Compute Engine

Shielded VMs are virtual machines (VMs) on Google Cloud hardened by a set of security controls that help defend against rootkits and bootkits. Using Shielded VMs helps protect enterprise workloads from threats like remote attacks, privilege escalation, and malicious insiders. Shielded VMs leverage advanced platform security capabilities such as secure and measured boot, a virtual trusted platform module (vTPM), UEFI firmware, and integrity monitoring.

Shielded VM instances run firmware which is signed and verified using Google's Certificate Authority, ensuring that the instance's firmware is unmodified and establishing the root of trust for Secure Boot



```
sudo su
apt update 
apt install apache2
ls /var/www/html
echo "Hello World!"
echo "Hello World!" > /var/www/html/index.html
echo $(hostname)
echo $(hostname -i)
echo "Hello World from $(hostname)"
echo "Hello World from $(hostname) $(hostname -i)"
echo "Hello world from $(hostname) $(hostname -i)" > /var/www/html/index.html
sudo service apache2 start
```

### Startup Script
```
#!/bin/bash
apt update 
apt -y install apache2
echo "Hello world from $(hostname) $(hostname -I)" > /var/www/html/index.html

systemctl start apache2
systemctl enable apache2
```

```
#!/bin/bash
echo "Hello world from $(hostname) $(hostname -I)" > /var/www/html/index.html
service apache2 start
```
### Managed & Unmanaged Instance group

`Scale-in` : reduce no of VMs in response to decreasing load  
`Scale-out` : increase no of VMs in response to increase in load





```
gcloud config list project
gcloud config configurations list
gcloud compute instances list
gcloud compute instances create
gcloud compute instances create my-first-instance-from-gcloud
gcloud compute instances describe my-first-instance-from-gcloud
gcloud compute instances delete my-first-instance-from-gcloud
gcloud compute zones list
gcloud compute regions list
gcloud compute machine-types list

gcloud compute machine-types list --filter zone:asia-southeast2-b
gcloud compute machine-types list --filter "zone:(asia-southeast2-b asia-southeast2-c)"
gcloud compute zones list --filter=region:us-west2
gcloud compute zones list --sort-by=region
gcloud compute zones list --sort-by=~region
gcloud compute zones list --uri
gcloud compute regions describe us-west4
```

```
gcloud compute instances create instance-1 \
  --project=serverless-gcp-391314 \
  --zone=us-west4-b \
  --machine-type=e2-medium \
  --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
  --maintenance-policy=MIGRATE \
  --provisioning-model=STANDARD \ --service-account=232560180807-compute@developer.gserviceaccount.com  \ --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \ --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/debian-cloud/global/images/debian-11-bullseye-v20230809,mode=rw,size=10,type=projects/serverless-gcp-391314/zones/us-west4-b/diskTypes/pd-balanced  \ --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring  \ --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
```