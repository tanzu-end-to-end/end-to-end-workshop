#!/bin/bash
set -e

BUNDLE_VERSION=1.0.0-preview-20210322

echo -n Enter your credentials for registry.pivotal.io
echo -n Username:
read username
echo -n Password: 
read -s password

echo $password | docker login registry.pivotal.io -u $username --password-stdin

imgpkg pull -b registry.pivotal.io/app-accelerator/acc-install-bundle:$BUNDLE_VERSION -o /tmp/acc-bundle

kubectl create namespace app-accelerator

kubectl create secret \
  docker-registry acc-image-regcred -n app-accelerator \
  --docker-server=registry.pivotal.io \
  --docker-username=${username} \
  --docker-password=${password}

export acc_service_type=LoadBalancer

ytt -f /tmp/acc-bundle/config -f /tmp/acc-bundle/values.yaml --data-values-env acc  \
| kbld -f /tmp/acc-bundle/.imgpkg/images.yml -f- \
| kapp deploy -y -n app-accelerator -a accelerator -f-