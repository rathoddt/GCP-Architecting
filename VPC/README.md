# VPC
VPC in GCP provides global network connectivity (inclusing regions). <i>Firewalls </i> on the other hand provides security to this network (VPC) and managed by network admin role

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
