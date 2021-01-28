#!/bin/bash
set -x

echo "Checking Workshop File"
echo $WORKSHOP_FILE

if [ $WORKSHOP_FILE == "workshop-concourse.yaml" ]
then
  fly -t concourse login -c "https://concourse.${INGRESS_DOMAIN}" -u "$CONCOURSE_USERNAME" -p "$CONCOURSE_PASSWORD" -n=${SESSION_NAMESPACE}
  fly -t concourse set-pipeline -c pipeline/spring-petclinic.yaml -p spring-petclinic -n
fi