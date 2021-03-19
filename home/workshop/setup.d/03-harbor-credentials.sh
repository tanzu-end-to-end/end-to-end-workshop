#!/bin/bash
set -x

docker login harbor.$INGRESS_DOMAIN -u admin -p $HARBOR_PASSWORD

REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create harbor-creds --registry harbor.$INGRESS_DOMAIN --registry-user admin
