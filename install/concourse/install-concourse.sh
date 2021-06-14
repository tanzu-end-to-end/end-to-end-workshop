set -x

helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm repo update

ytt -f concourse-helm-values.yaml -f $1 \
  | helm template concourse/concourse --name-template concourse --version 14.5.3 -f- \
  | ytt -f- -f concourse-dependencies.yaml -f $1 --ignore-unknown-comments \
  | kapp deploy -a concourse -n concourse -f- --diff-changes --yes
