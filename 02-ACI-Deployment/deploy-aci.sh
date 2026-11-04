#!/bin/bash

# ==============================================================================
# Automated Azure Container Instance (ACI) Deployment
# This script deploys an ACI with a persistent Azure File Share attached.
# ==============================================================================

# Variables
RESOURCE_GROUP="rg-portfolio-aci"
LOCATION="northeurope"
STORAGE_ACCOUNT_NAME="stportfolioaci$RANDOM"
SHARE_NAME="acishare"
CONTAINER_GROUP_NAME="cg-portfolio-aci"
CONTAINER_NAME="nginx-container"
IMAGE="nginx"

echo "Starting deployment..."

# 1. Create Resource Group
echo "Creating Resource Group: $RESOURCE_GROUP..."
az group create --name $RESOURCE_GROUP --location $LOCATION -o none

# 2. Create Storage Account
echo "Creating Storage Account: $STORAGE_ACCOUNT_NAME..."
az storage account create \
    --resource-group $RESOURCE_GROUP \
    --name $STORAGE_ACCOUNT_NAME \
    --location $LOCATION \
    --sku Standard_LRS \
    -o none

# 3. Get Storage Account Key (dynamically retrieved, not hardcoded)
echo "Retrieving Storage Account Key..."
STORAGE_KEY=$(az storage account keys list \
    --resource-group $RESOURCE_GROUP \
    --account-name $STORAGE_ACCOUNT_NAME \
    --query "[0].value" -o tsv)

# 4. Create Azure File Share
echo "Creating Azure File Share: $SHARE_NAME..."
az storage share create \
    --name $SHARE_NAME \
    --account-name $STORAGE_ACCOUNT_NAME \
    --account-key $STORAGE_KEY \
    -o none

# 5. Deploy Container Instance
echo "Deploying Azure Container Instance..."
az container create \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_GROUP_NAME \
    --image $IMAGE \
    --os-type Linux \
    --dns-name-label "portfolio-aci-$RANDOM" \
    --ports 80 \
    --azure-file-volume-account-name $STORAGE_ACCOUNT_NAME \
    --azure-file-volume-account-key $STORAGE_KEY \
    --azure-file-volume-share-name $SHARE_NAME \
    --azure-file-volume-mount-path /mnt/acishare \
    -o json

echo "Deployment complete!"
echo "Check the Azure Portal to view your resources."
