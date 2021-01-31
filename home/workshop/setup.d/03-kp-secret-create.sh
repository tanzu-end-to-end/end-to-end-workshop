#!/bin/bash
set -x

REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create harbor-creds --registry harbor.$INGRESS_DOMAIN --registry-user admin
