#!/bin/bash
set -x

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

ytt -f kubeapps-helm-values.yaml -f $1 \
| helm template bitnami/kubeapps --version 7.3.2 --namespace kubeapps --name-template kubeapps -f- > chart.yaml

ytt -f chart.yaml -f kubeapps-dependencies.yaml -f $1 --file-mark 'chart.yaml:type=yaml-plain' \
| kapp deploy -a kubeapps -n kubeapps -f- --diff-changes --yes
