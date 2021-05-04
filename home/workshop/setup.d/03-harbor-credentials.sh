#!/bin/bash
set -x

docker login harbor.$INGRESS_DOMAIN -u admin -p $HARBOR_PASSWORD

set +x
echo Checking for harbor-creds
if ! k get secret harbor-creds 2> /dev/null ; then 
  echo No harbor-creds found, creating
  set -x
  REGISTRY_PASSWORD=$HARBOR_PASSWORD kp secret create harbor-creds --registry harbor.$INGRESS_DOMAIN --registry-user admin
else
  echo Secret harbor-creds already exists, skiping creation
  set -x
fi
