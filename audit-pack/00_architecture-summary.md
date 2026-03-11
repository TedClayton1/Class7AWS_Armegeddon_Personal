Architecture Summary

Global traffic enters through Amazon CloudFront.
AWS WAF protects the edge layer from malicious requests.
Application compute runs in São Paulo (sa-east-1).
Patient medical data is stored in Tokyo (ap-northeast-1) using Amazon RDS.
Transit Gateway connects the two regions through a controlled network corridor.
This architecture ensures Japanese medical data never leaves Tokyo while still allowing global access through the application layer.

## Environment Note

The lab handout lists the following locked assumptions:

- S3 Bucket: Class_Lab3
- CloudFront Logs Prefix: Chwebacca-logs/
- AWS Account ID: 200819971986

In the deployed environment used for this submission, the active AWS account was 737679990112, the bucket Class_Lab3 was not present, and CloudFront standard logging was disabled on distribution EWRZSYST7FTDH. Therefore, CloudFront edge proof was collected using live HTTP header evidence rather than S3 log-file analysis.
