set -x

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

ytt -f kubeapps-helm-values.yaml -f $1 | helm template bitnami/kubeapps --global.imageRegistry=harbor-repo.vmware.com/dockerhub-proxy-cachharbor-repo.vmware.com/dockerhub-proxy-cache  --version 4.0.4 --namespace kubeapps --name-template kubeapps -f- > chart.yaml

ytt -f kubeapps-dependencies.yaml -f integrate-contour-overlay.yaml -f chart.yaml -f $1 --file-mark 'chart.yaml:type=yaml-plain' | kapp deploy -a kubeapps -n kubeapps -f- --diff-changes --yes
