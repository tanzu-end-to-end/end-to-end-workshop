# Installing Harbor

Ensure that you have prepared a **values.yaml** file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
kubectl create namespace harbor
./install-harbor.sh /path/to/my/values.yaml
```

After the installation you have to create a Harbor project with the name "dockerhub" as a DockerHub proxy cache. See documentation [here](https://goharbor.io/docs/2.2.0/administration/configure-proxy-cache/)
