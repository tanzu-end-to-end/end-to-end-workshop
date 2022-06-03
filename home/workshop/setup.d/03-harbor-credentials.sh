#!/bin/bash
set -x

docker login harbor.$TAP_INGRESS_DOMAIN -u admin -p $HARBOR_PASSWORD
REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create harbor-creds --registry harbor.$TAP_INGRESS_DOMAIN --registry-user admin
