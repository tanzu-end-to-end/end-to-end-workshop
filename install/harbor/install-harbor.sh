set -x

if [[ "$(helm repo list)" == *"harbor"* ]]; then
  echo "Skipping repo add and update"
else
  helm repo add harbor https://helm.goharbor.io
  helm repo update
fi

ytt -f harbor-helm-values.yaml -f ../../values/values.yaml \
  | helm template harbor/harbor --name-template harbor -f- \
  | ytt -f- -f harbor-dependencies.yaml -f ../../values/values.yaml --ignore-unknown-comments \
  | kapp deploy -a harbor -n harbor -f- --diff-changes --yes
