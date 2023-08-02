# Billing
Find all charges that were more than 3 dollars:
```
SELECT product, resource_type, start_time, end_time,  
cost, project_id, project_name, project_labels_key, currency, currency_conversion_rate,
usage_amount, usage_unit
FROM `cloud-training-prod-bucket.arch_infra.billing_data`
WHERE (cost > 3)
```

Find which product had the highest total number of records:
```
SELECT product, COUNT(*)
FROM `cloud-training-prod-bucket.arch_infra.billing_data`
GROUP BY product
LIMIT 200
```

Which product most frequently cost more than a dollar:
```
SELECT product, cost, COUNT(*)
FROM `cloud-training-prod-bucket.arch_infra.billing_data`
WHERE (cost > 1)
GROUP BY cost, product
LIMIT 200
```