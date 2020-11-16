#!/bin/bash
kapp deploy -a telegraf -n tanzu-kapp --into-ns telegraf -f <(ytt -f telegraf --data-value "vcenter.host=$(lpass show --field=Hostname PEZ-E2E)" \
  --data-value "vcenter.username=$(lpass show --username PEZ-E2E)" \
  --data-value "vcenter.password=$(lpass show --password PEZ-E2E)")