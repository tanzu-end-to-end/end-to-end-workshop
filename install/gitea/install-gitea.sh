helm repo add gitea-charts https://dl.gitea.io/charts/
helm repo update

ytt -f gitea-helm-values.yaml -f $1 \
  | helm template gitea-charts/gitea --name-template gitea -n gitea -f- \
  | ytt -f- -f gitea-dependencies.yaml -f $1 --ignore-unknown-comments \
  | kapp deploy -a gitea -n gitea -f- --diff-changes --yes
