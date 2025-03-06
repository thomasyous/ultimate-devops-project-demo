# OpenTelemetry Demo - DevOps Implementation

## 📌 Project Overview
This project is a microservices-based eCommerce application. The goal is to apply full **DevOps practices** to containerize, orchestrate, and automate the deployment of this system.

## 🏗️ Project Architecture
The OpenTelemetry demo consists of multiple microservices like checkout, payment, recommendation, and cart service. 

### **Tech Stack**
- **Frontend:** React, Envoy Proxy
- **Backend:** Python, Go, Java, Node.js
- **Database:** PostgreSQL, Redis, Kafka
- **Containerization:** Docker
- **Orchestration:** Kubernetes (GKE)
- **Infrastructure:** Terraform (GCP)
- **Monitoring & Logging:** Prometheus, Grafana
- **CI/CD:** GitHub Actions

## ⚙️ Infrastructure Setup
1. **Provision GCP Infrastructure** using Terraform:
   - Create **VPC, Subnets, and GKE Cluster**.
2. **Deploy Kubernetes Manifests**:
   - Define **Deployments, Services, and Ingress**.
3. **Automate CI/CD Pipeline**:
   - Set up **GitHub Actions** for continuous deployment.

## 🚀 How This Project Helps me in DevOps Learning

✅ **Hands-on Microservices Deployment**
✅ **Practical Implementation of DevOps Tools & Concepts**
✅ **Infrastructure Automation**
✅ **Understanding of Kubernetes & Cloud Operations**
✅ **CI/CD Workflow**

## 📜 Documentation
- **Project Overview & Architecture**

<p align="center">
  <img src="DevOps/Images/System_Architect.drawio.svg" alt="Project Architecture" width="600"/>
</p>

## Project Structure 

```bash
OpenTelemetry-Ecommerce-Demo
├── .github                          # GitHub Actions for CICD 
      ├── workflows
├── Config
├── DevOps                          
│   ├── Images
│   ├── project-structure.txt
│   └── README.MD
├── Docker-compose.yml               # Docker compose file 
├── Docs
├── Infra                            # Infrastructure for GCP using Terraform
│   └── GKE-Terraform
├── Internal
│   └── tools
├── kubernetes                       # K8s Manifests files for all microservices 
├── Makefile
├── pb
├── README.md
├── Scripts
├── src                              # Microservices 
│   ├── accounting
│   ├── ad
│   ├── cart
│   ├── checkout
│   ├── currency
│   ├── email
│   ├── flagd
│   ├── flagd-ui
│   ├── fraud-detection
│   ├── frontend
│   ├── frontend-proxy
│   ├── grafana
│   ├── image-provider
│   ├── kafka
│   ├── load-generator
│   ├── otel-collector
│   ├── payment
│   ├── product-catalog
│   ├── prometheus
│   ├── quote
│   ├── react-native-app
│   ├── recommendation
│   └── shipping
└── test
    ├── README.md
    └── tracetesting
```
<p align="center">
  <img src="DevOps/Images/Structure.png" alt="Architecture" width="600"/>
</p>

<p align="center">
  <img src="DevOps/Images/Lang.png" alt="" width="600"/>
</p>

- **Terraform & Kubernetes Setup**

Using terraform we create GCP resources GKE (Google Kubernetes Engine) and config GKE via kubectl.

- **CI/CD Pipeline Explanation**
<p align="center">
  <img src="DevOps/Images/CI-CD Flow.drawio.svg" alt="CICD Workflow" width="600"/>
</p>
---
✍  [Bharat Suthar](https://github.com/bharatsutharx)

🔗 **GitHub Repo:** _[To be added after pushing]_


## 🛡️ License
This project follows the OpenTelemetry licensing terms. See LICENSE for details.

## 🤝 Contribution
  
If you have any suggestions, improvements, or find any issues, feel free to open an issue or create a pull request. Your feedback is appreciated!  
 
