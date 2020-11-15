#!/bin/bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade -i petclinic-db bitnami/mysql -f <(cat petclinic-db-values.yaml | envsubst)