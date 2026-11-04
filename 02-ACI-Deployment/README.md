# Automated Azure Container Instance Deployment 🚀

## Overview
This project demonstrates an automated Infrastructure as Code (IaC) approach to deploying an Azure Container Instance (ACI) with a persistent Azure File Share attached. The deployment is fully scripted using Azure CLI (Bash), showcasing cloud automation, PaaS configuration, and secure credential handling.

## Key Features
* **Infrastructure as Code (IaC):** 100% automated deployment using a single Bash script.
* **Persistent Storage:** Configures an Azure Storage Account and File Share, mounting it as a volume (`/mnt/acishare`) inside the container to ensure data persists across reboots.
* **Security Best Practices:** Retrieves storage account access keys dynamically during runtime. **Zero hardcoded secrets or passwords** are stored in the repository.
* **Resource Management:** Explicitly defines CPU and Memory allocations to optimize cost and performance.

## Technologies Used
* **Cloud Provider:** Microsoft Azure
* **Services:** Azure Container Instances (ACI), Azure Storage (Files)
* **Scripting:** Bash, Azure CLI

## Prerequisites
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and configured locally or via Azure Cloud Shell.
* An active Azure subscription.

## How to Run
1. Clone this repository to your local machine or Azure Cloud Shell.
2. Log in to your Azure account:
```bash
az login
```
3. Make the script executable:
```bash
chmod +x deploy-aci.sh
```
4. Run the deployment script:
```bash
./deploy-aci.sh
```
5. Once completed, the script will output the Fully Qualified Domain Name (FQDN) where your container is accessible.
