#!/bin/bash
set -x

fly -t concourse login -c "https://concourse.${INGRESS_DOMAIN}" -u "$CONCOURSE_USERNAME" -p "$CONCOURSE_PASSWORD" -n=${SESSION_NAMESPACE}
fly -t concourse set-pipeline -c pipeline/spring-petclinic.yaml -p spring-petclinic -n
