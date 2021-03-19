# Installing Gitea

Ensure that you have prepared a values.yaml file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
kubectl create namespace gitea
./install-gitea.sh /path/to/my/values.yaml
```