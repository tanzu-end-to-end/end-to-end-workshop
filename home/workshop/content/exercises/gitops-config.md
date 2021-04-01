We now have a process for safely iterating on our application. When our developer commits changes to the Git repo, Tanzu Build Service will create an up-to-date image with its secure code-to-container pipeline.

But what if we want to change the configuration of our Kubernetes deployment? That will be managed by the application operator. Here is the structure of the GitOps repo they manage:

```terminal:execute
command: tree ~/spring-webdb-config
session: 1
```

Let's make a change to the ConfigMap in the dev deployment, which will produce a visible change in the application. Try updating the **web.bannerText** message, and change the **web.bannerTextColor** from DarkCyan to an HTML color you find pleasing. Like Salmon!

```terminal:execute
command: nano ~/spring-webdb-config/dev/configmap.yaml
session: 1
```

When you have made the change, press Control-X to save and exit. Commit your change, and push it to your GitOps repo:

```terminal:execute
command: git -C ~/spring-webdb-config commit -a -m "Application Configuration Change"
session: 1
```

```terminal:execute
command: git -C ~/spring-webdb-config push -u origin main
session: 1
```

Now, go back to the ArgoCD console and sync again. Your changes will be deployed, and the pod will restart with the new configuration. 

A GitOps approach makes it easy to review, audit, and control access to your deployment configuration. And it allows developers to focus on their source code, without needing to master the details of Kubernetes.

The new app should deploy in about a minute. Once the new **webdb** pod shows **1/1 containers** ready, we can access the application here:

```dashboard:open-url
name: Application
url: https://webdb-{{ session_namespace }}.{{ ingress_domain }}
```
