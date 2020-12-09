#!/bin/bash

HARBOR_USER=$(kubectl get secret --namespace harbor-project-controller controller-secrets -o jsonpath="{.data.harbor_username}" | base64 --decode)
HARBOR_PASS=$(kubectl get secret --namespace harbor-project-controller controller-secrets -o jsonpath="{.data.harbor_password}" | base64 --decode)

REGISTRY_PASSWORD=$HARBOR_PASS kp secret create harbor-creds --registry harbor.$INGRESS_DOMAIN --registry-user "$HARBOR_USER"
