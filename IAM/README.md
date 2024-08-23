# Cloud Identity and Access Managemnt
While seraching in `Roles` use property `Used in`

## Role add/remove using gcloud cmmand
```
cloud projects add-iam-policy-binding terraform-poc-01 --member "user:rathod.dt@gmail.com" --role "roles
/compute.networkAdmin"

gcloud projects remove-iam-policy-binding terraform-poc-01 --member "user:rathod.dt@gmail.com" --role "roles/compute.networkAdmin"

gcloud projects remove-iam-policy-binding terraform-poc-01 --member "user:rathod.dt@gmail.com" --role "roles/compute.instanceAdmin.v1"
```

Id for custom roles
```
projects/terraform-poc-01/roles/CustomRole
projects/[project-id]/roles/CustomRole
```

Getting polcy documet in JSOn format
```
gcloud projects get-iam-policy terraform-poc-01 --format json > policy.json
```

Adding/setting roles via policy documet
```
gcloud projects set-iam-policy terraform-poc-01 policy.json
```

### ssh into Linux VMs
per instance; inside metadat add  
```
enable-oslogin: true
```

