set -x

if [[ "$(helm repo list)" == *"harbor"* ]]; then
  echo "Skipping repo add and update"
else
  helm repo add harbor https://helm.goharbor.io
  helm repo update
fi

ytt -f harbor-helm-values.yaml -f $1 \
  | helm template harbor/harbor --name-template harbor --version 1.5.3 -f- \
  | ytt -f- -f harbor-dependencies.yaml -f $1 -f integrate-contour-overlay.yaml --ignore-unknown-comments \
  | kapp deploy -a harbor -n harbor -f- --diff-changes --yes
