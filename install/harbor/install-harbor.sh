set -x

ytt -f harbor-helm-values.yaml -f $1 | helm template harbor/harbor --name-template harbor -f- > chart.yaml

ytt -f harbor-dependencies.yaml -f $1 -f chart.yaml --file-mark 'chart.yaml:type=yaml-plain' | kapp deploy -a harbor -n harbor -f- --diff-changes --yes