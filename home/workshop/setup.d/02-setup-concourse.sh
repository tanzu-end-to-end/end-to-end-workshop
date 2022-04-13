#!/bin/bash
set -x

if [ $WORKSHOP_FILE == "workshop-concourse.yaml" ]
then
  fly -t concourse login -c "https://concourse.${TAP_INGRESS_DOMAIN}" -u "$CONCOURSE_USERNAME" -p "$CONCOURSE_PASSWORD" -n=${SESSION_NAMESPACE}
  fly -t concourse set-pipeline -c pipeline/spring-petclinic.yaml -p spring-petclinic -n
fi