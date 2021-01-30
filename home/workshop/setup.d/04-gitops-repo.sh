#!/bin/bash
set -x

pwd

if [ $WORKSHOP_FILE == "workshop-tbs-gitops.yaml" ]
then
  argocd login argocd-cli.${INGRESS_DOMAIN} --username admin --password $ARGOCD_PASSWORD
  argocd app create dev-${SESSION_NAMESPACE} --repo https://github.com/cpage-pivotal/spring-webdb-config --dest-namespace ${SESSION_NAMESPACE} --dest-server https://kubernetes.default.svc --path dev
fi