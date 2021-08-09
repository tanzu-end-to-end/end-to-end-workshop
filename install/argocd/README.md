# Installing ArgoCD

Ensure that you have prepared a values.yaml file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
kubectl create namespace argocd
./install-argocd.sh /path/to/my/values.yaml
```

The web interface for ArgoCD will be reachable at https://argocd.(your-domain), but the interface for the CLI endpoint lives at argocd-cli.(your domain). So the CLI command for accessing your server is

```
argocd login argocd-cli.(your-domain)
```

Follow the instructions here for intializing the admin password after install: https://argoproj.github.io/argo-cd/getting_started/#4-login-using-the-cli