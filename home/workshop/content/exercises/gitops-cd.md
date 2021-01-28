blah blah blah

```terminal:execute
command: argocd login argocd-cli.{{ ingress_domain }} --username admin --password {{ ENV_ARGOCD_PASSWORD }} && argocd app create dev-{{ session_namespace }} --repo https://github.com/cpage-pivotal/spring-webdb-config --dest-namespace {{ session_namespace }} --dest-server https://kubernetes.default.svc --path dev
session: 1
```

blah blah blah

```dashboard:open-url
url: https://argocd.{{ ingress_domain }}/applications/dev-{{ session_namespace }}
```
