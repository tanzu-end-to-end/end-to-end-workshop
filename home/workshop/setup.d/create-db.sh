#!/bin/bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm update
helm upgrade -i petclinic-db bitnami/mysql -v <(cat home/workshop/setup.d/petclinic-db-values.yaml | envsubst)