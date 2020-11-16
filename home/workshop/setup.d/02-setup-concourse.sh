#!/bin/bash

fly -t concourse login -c "https://concourse.${INGRESS_DOMAIN}" -u test -p test -n=${SESSION_NAMESPACE}
fly -t concourse set-pipeline -c pipeline/spring-petclinic.yaml -p spring-petclinic -n