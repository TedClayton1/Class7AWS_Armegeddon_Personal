This architecture was designed to align with Japan’s APPI privacy expectations for medical data. 
Patient medical data (PHI) is intended to be stored in the Tokyo AWS region (ap-northeast-1) using Amazon RDS, while the São Paulo region (sa-east-1) hosts application compute resources only. 
Cross-region connectivity is provided through AWS Transit Gateway, forming a controlled network corridor between compute and data regions. 
Global user access is provided through Amazon CloudFront, which serves as the edge entry point and integrates with AWS WAF to protect the application from malicious requests. 
CloudTrail logging provides an immutable record of infrastructure changes for audit and accountability. 
Current evidence confirms active RDS instances in Tokyo and no RDS presence in São Paulo. 
The Terraform-managed environment also contains an RDS instance in us-east-1 which is outside the intended Tokyo-only PHI residency design and would need to be removed or formally scoped as non-PHI before claiming strict APPI-style residency compliance. 
Overall, the architecture demonstrates controlled data residency, secured global access, and auditable infrastructure operations.
