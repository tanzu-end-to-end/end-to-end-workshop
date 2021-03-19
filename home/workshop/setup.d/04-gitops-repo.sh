#!/bin/bash
set -x
set +e

if [ $WORKSHOP_FILE == "workshop-tbs-gitops.yaml" ]
then
  export YTT_session=${SESSION_NAMESPACE}
  export YTT_ingress__domain=${INGRESS_DOMAIN}
  ytt -f spring-webdb-config/dev/httpproxy.yaml -f values.yaml --data-values-env YTT | tee httpproxy.yaml
  mv httpproxy.yaml spring-webdb-config/dev/httpproxy.yaml
  ytt -f spring-webdb-config/base/httpproxy.yaml -f values.yaml --data-values-env YTT | tee httpproxy.yaml
  mv httpproxy.yaml spring-webdb-config/base/httpproxy.yaml
  ytt -f spring-webdb-config/base/deployment.yaml -f values.yaml --data-values-env YTT | tee deployment.yaml
  mv deployment.yaml spring-webdb-config/base/deployment.yaml
  ytt -f spring-webdb-config/base/kustomization.yaml -f values.yaml --data-values-env YTT | tee kustomization.yaml
  mv kustomization.yaml spring-webdb-config/base/kustomization.yaml

  cd spring-webdb-config
  git init
  git checkout -b main
  git config user.name gitea_admin
  git config user.email "gitea_admin@example.com"
  git add .
  git commit -a -m "Initial Commit"

  export REPO_NAME=$SESSION_NAMESPACE-$RANDOM
  git remote add origin https://gitea_admin:$GITEA_PASSWORD@gitea.${INGRESS_DOMAIN}/gitea_admin/$REPO_NAME.git
  git push -u origin main

  argocd login argocd-cli.${INGRESS_DOMAIN} --username admin --password $ARGOCD_PASSWORD
  argocd app set ${SESSION_NAMESPACE} --repo https://gitea.${INGRESS_DOMAIN}/gitea_admin/$REPO_NAME
fi