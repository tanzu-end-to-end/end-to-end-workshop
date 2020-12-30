#!/bin/bash
set -x

CONCOURSE_USER=$(kubectl get secret --namespace concourse-team-controller controller-secrets -o jsonpath="{.data.concourse_username}" | base64 --decode)
CONCOURSE_PASS=$(kubectl get secret --namespace concourse-team-controller controller-secrets -o jsonpath="{.data.concourse_password}" | base64 --decode)

fly -t concourse login -c "https://concourse.${INGRESS_DOMAIN}" -u "$CONCOURSE_USER" -p "$CONCOURSE_PASS" -n=${SESSION_NAMESPACE}
fly -t concourse set-pipeline -c pipeline/spring-petclinic.yaml -p spring-petclinic -n
