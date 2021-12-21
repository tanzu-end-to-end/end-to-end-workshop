set -x

#helm repo add concourse https://concourse-charts.storage.googleapis.com/
#helm repo update

ytt -f concourse-helm-values.yaml -f $1 | helm template concourse/concourse --name-template concourse --version 16.0.0 -f- > chart.yaml

ytt --ignore-unknown-comments -f chart.yaml -f concourse-dependencies.yaml -f $1 | kapp deploy -a concourse -n concourse -f- --diff-changes --yes
