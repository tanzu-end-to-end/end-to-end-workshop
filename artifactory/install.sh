#!/bin/bash
helm repo add center https://repo.chartcenter.io
helm repo update
helm upgrade --install artifactory-oss --namespace artifactory-oss center/jfrog/artifactory-oss -f values.yaml