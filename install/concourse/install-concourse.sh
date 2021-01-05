set -x

helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm repo update

ytt -f concourse-helm-values.yaml -f $1 | helm template concourse/concourse --name-template concourse -f- > chart.yaml

ytt -f concourse-dependencies.yaml -f chart.yaml -f $1 --file-mark 'chart.yaml:type=yaml-plain' | kapp deploy -a concourse -n concourse -f- --diff-changes --yes
