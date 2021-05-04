#!/bin/bash
set -x

docker login harbor.$INGRESS_DOMAIN -u admin -p $HARBOR_PASSWORD

set +e
echo Checking for harbor-creds
if ! kubectl get secret harbor-creds ; then 
  echo No harbor-creds found, creating
  set -e
  REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create harbor-creds --registry harbor.$INGRESS_DOMAIN --registry-user admin
else
  echo Secret harbor-creds already exists, skiping creation
  set -e
fi
