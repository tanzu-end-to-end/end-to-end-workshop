#!/bin/bash
kubectl create ns artifactory-oss
helm repo add jfrog https://charts.jfrog.io
helm repo update
kubectl -n artifactory-oss apply -f bootstrap-config.yaml
helm upgrade --install artifactory-oss --namespace artifactory-oss jfrog/artifactory -f values.yaml
