# GCP Networking

GCP network is global in scope, and the default mode of operations.
- All traffic between regions (and within POP network) is on Google?s private network
- i.e., a global privat e net work (never touches the public Internet).
- Result: better security, routing, and performance.
- GCP networking resources privately communicate all over the world by default.

### Regions
- Independent geographic areas that host GCP data centers.
- At the moment, 20 regions are available worldwide, and growing.
- Typically consists of 3 or m ore zones.
- Examples: us-central1, europe-west4, asia-east2


Projects separate users, whereas VPCs separate systems

### IP Addrersses
Static reserved IP addressess are not charged they are attached to VM