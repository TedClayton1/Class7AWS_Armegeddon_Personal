Armageddon AWS Project (Portfolio Implementation)

## 🏗️ Architecture Diagram
![Architecture](screen-captures/lab1a-diagram.png)


##📌 Project Overview
This project demonstrates the design and implementation of a production-style AWS cloud architecture built using Infrastructure as Code (Terraform).

The system evolves across three phases, progressing from a basic deployment to a secure, scalable, and globally distributed architecture with performance optimizations using CDN caching.

🧱 Architecture Evolution
##🏗️ Phase 1 — Baseline Infrastructure
Built core AWS environment using Terraform
Deployed:
VPC with public/private subnets
EC2 instances
RDS (MySQL)
IAM roles
Established initial application connectivity and monitoring

👉 Outcome: Functional cloud environment with basic networking and compute

##🔒 Phase 2 — Secure Private Architecture
Moved compute resources into private subnets
Implemented:
NAT Gateway for outbound traffic
VPC Interface Endpoints (PrivateLink)
Secrets Manager for credential management
Least-privilege IAM policies

👉 Outcome: Production-style security posture with reduced attack surface

##🌎 Phase 3 — Global & Scalable Architecture
Extended infrastructure across regions
Implemented:
Transit Gateway for inter-region communication
Regional isolation and segmentation
Compliance-focused design patterns

👉 Outcome: Highly available, globally distributed architecture

⚡ Performance Optimization (My Contribution)
##🌐 CloudFront Integration
Implemented Amazon CloudFront as a CDN layer
Configured caching behavior to reduce latency
Improved response times for end users
Reduced load on backend infrastructure

👉 Outcome:

Faster content delivery
Improved scalability under load
Cost optimization through caching

##🔐 Security Implementation
AWS Secrets Manager for credential storage
IAM roles with least-privilege access
Private subnets for backend services
VPC endpoints to eliminate public exposure
No hardcoded credentials in production design

##⚙️ Tech Stack
Cloud: AWS (VPC, EC2, RDS, CloudFront, ALB, IAM, Secrets Manager, SNS)
IaC: Terraform
OS: Amazon Linux 2023
Scripting: Python (automation & validation)
Networking: DNS, HTTP/HTTPS, TLS

##📊 What This Project Demonstrates
Infrastructure as Code (Terraform)
Secure cloud architecture design
Multi-tier networking (public/private)
Secrets management & IAM best practices
CDN integration and performance optimization
Multi-region architecture design

##🧪 How to Deploy
terraform init
terraform plan
terraform apply

## ⚠️ Operational Notes

- This project was developed for educational and portfolio purposes.
- Sensitive data is managed using variables and AWS Secrets Manager; no credentials are hardcoded.
- To avoid unnecessary AWS costs, all resources should be destroyed after testing using `terraform destroy`.