In our CI (Continuous Integration) process, we used Tanzu Build Service to synchronize our Git source repos to the container images that will run out applications.

Similarly, for our CD (Continuous Delivery) process, we want to use GitOps tooling to synchronize Git deployment repos to the running state of our cluster. Tanzu Advanced Edition works well with any GitOps tooling. For this workshop, we have decided to use ArgoCD. Let's examine the ArgoCD app that will manage deployment of our web application and database.

```dashboard:open-url
url: https://argocd.{{ ingress_domain }}/applications/{{ session_namespace }}
```

Press Sync on the ArgoCD console to begin deployment of the application. It will take about a minute for the application and database components to deploy the first time. Once the components are deployed, we can access the application here:

```dashboard:open-url
name: Application
url: https://webdb-{{ session_namespace }}.{{ ingress_domain }}
```

Make a configuration change to the ConfigMap associated with your deployment, and save it:

```editor:open-file
file: ~/spring-webdb-config/dev/configmap.yaml
```

Commit your change, and push it to your GitOps repo:

```terminal:execute
command: git commit -a -m "Application Configuration Change"
session: 1
```

```terminal:execute
command: git push -u origin main
session: 1
```

Now, go back to the ArgoCD console and sync again. Your changes will be deployed, and when your application is available, you can refresh the application Web UI to view your changes.