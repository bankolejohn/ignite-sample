#!/bin/bash

# Define the name for your Kind cluster
CLUSTER_NAME="my-kind-cluster"

# Check if Kind is installed
if ! command -v kind &> /dev/null; then
  echo "Kind is not installed. Please install it before running this script."
  exit 1
fi

# Check if the cluster already exists
if kind get clusters | grep -q "$CLUSTER_NAME"; then
  echo "Cluster $CLUSTER_NAME already exists."
  exit 1
fi

# Create a Kind cluster
kind create cluster --name "$CLUSTER_NAME"

# Set KUBECONFIG to use the Kind cluster
export KUBECONFIG="$(kind get kubeconfig-path --name="$CLUSTER_NAME")"

# Verify the cluster is running
kubectl cluster-info

# You can now use the cluster with kubectl

# Example: Deploy a sample application
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort

echo "Kind cluster $CLUSTER_NAME is deployed and configured."
