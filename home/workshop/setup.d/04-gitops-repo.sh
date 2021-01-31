#!/bin/bash
set -x

if [ $WORKSHOP_FILE == "workshop-tbs-gitops.yaml" ]
then
  cd spring-webdb-config
  git init
  git checkout -b main
  git config user.name gitea_admin
  git config user.email "gitea_admin@example.com"
  git add .
  git commit -a -m "Initial Commit"

  export REPO_NAME=$SESSION_NAMESPACE-$RANDOM
  git remote add origin https://gitea_admin:$GITEA_PASSWORD@gitea.contour.e2e.corby.cc/gitea_admin/$REPO_NAME.git
  git push -u origin main

  argocd login argocd-cli.${INGRESS_DOMAIN} --username admin --password $ARGOCD_PASSWORD
  argocd app create dev-${SESSION_NAMESPACE} --repo https://gitea.contour.e2e.corby.cc/gitea_admin/$REPO_NAME --dest-namespace ${SESSION_NAMESPACE} --dest-server https://kubernetes.default.svc --path dev --project ${SESSION_NAMESPACE}
fi