#!/bin/bash

#helm repo add jfrog https://charts.jfrog.io
#helm repo update

ytt -f artifactory-helm-values.yaml -f $1 \
| helm template artifactory-oss jfrog/artifactory-oss --version 107.27.6 --namespace artifactory-oss -f- > chart.yaml

ytt -f chart.yaml -f $1 --file-mark 'chart.yaml:type=yaml-plain' \
| kapp deploy -a artifactory-oss -n artifactory-oss -f- --diff-changes --yes
