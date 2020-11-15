#!/bin/bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade -i petclinic-db bitnami/mysql -f <(cat home/workshop/setup.d/petclinic-db-values.yaml | envsubst)