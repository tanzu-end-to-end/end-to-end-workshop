# Installing Kubeapps

Ensure that you have prepared a values.yaml file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
kubectl create namespace kubeapps
./install-kubeapps.sh /path/to/my/values.yaml
```

Once Kubeapps is installed, you can get the login token by executing the following command within the `kubeapps` namespace:

```
kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo
```