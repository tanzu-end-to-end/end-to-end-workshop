set -x

helm repo add harbor https://helm.goharbor.io
helm repo update

ytt -f harbor-helm-values.yaml -f $1 | helm template harbor/harbor --name-template harbor -f- > chart.yaml

ytt -f harbor-dependencies.yaml -f $1 -f chart.yaml -f integrate-contour-overlay.yaml --file-mark 'chart.yaml:type=yaml-plain' | kapp deploy -a harbor -n harbor -f- --diff-changes --yes