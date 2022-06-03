#!/bin/bash
set -x

if [ $WORKSHOP_FILE == "workshop-concourse.yaml" ]
then
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  cat petclinic-db-values.yaml | envsubst | helm upgrade -i petclinic-db bitnami/mysql --version 9.1 -f-
fi
