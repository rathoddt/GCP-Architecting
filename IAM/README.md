# Cloud Identity and Access Managemnt
While seraching in `Roles` use property `Used in`

## Role add/remove using gcloud cmmand
```
cloud projects add-iam-policy-binding terraform-poc-01 --member "user:rathod.dt@gmail.com" --role "roles
/compute.networkAdmin"
```