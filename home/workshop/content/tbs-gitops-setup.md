Welcome to the Tanzu End to End demo!  In this session, we'll be exploring the capabilitites of Tanzu Advanced Edition, and see how they would be used in an actual software lifecycle scenario.

We're going to be using Tanzu to deploy an application, deploy dependent services for that application, observe the metrics for that application and supporting infrastructure, and manage the cluster hosting that application.

# Harbor

Sign into the Harbor Web UI with the username "admin" and password "{{ ENV_HARBOR_PASSWORD }}".

```dashboard:create-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/sign-in
```

Next, click the link below and login to Harbor with the user "admin" and password "{{ ENV_HARBOR_PASSWORD }}".  If you login and aren't redirected to your project, then simply close the Harbor tab that was opened, and reopen it with the link below.
```dashboard:reload-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

Try this
```dashboard:create-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

# SaaS Services
**Important**: For the next sections, it is vital that you  make sure to sign-in to cloud.vmware.com with your **@vmware.com** email address and select the **"Tanzu End to End"** organization.  Please be careful not to alter the services or configurations of the clusters in these environments as they are shared for the entire End to End Demo Environment.

Click below to sign in.  If you can't see this organization, let us know your email address in the [#tanzu-e2e-demo](https://vmware.slack.com/archives/C01AMS26GJJ) channel in Slack and we can get you added.
```dashboard:open-url
url: https://cloud.vmware.com
```

## Tanzu Observability
Open a tab to Tanzu Observability for your Pet Clinic Dashboard.  First, you will need to sign in to the following Wavefront instance.
```dashboard:open-url
url: https://vmware.wavefront.com/u/GVQsHYwxZC?t=vmware
```
If you are having trouble accessing this instance, make sure you have the Wavefront-sandbox app added to your Workspace One account.  You can access that app at https://myvmware.workspaceair.com/catalog-portal/ui#/apps/details/WORKSPACE-d689139a-9b94-4b6f-aa23-915763e9b149-Web-Saml20, and then try to click the link above.

Now, copy your app name below, and paste into the application dropdown on the TO browser tab.  It may take a minute for metrics to flow in where you can actually select that application name, so if you can't see your app in the list try to refresh the page the page after a minute or two.
```workshop:copy
text: petclinic-{{ session_namespace }}
```

## Tanzu Mission Control
Open a tab for Tanzu Mission Control
```dashboard:open-url
url: https://tanzuendtoend.tmc.cloud.vmware.com/clusterGroups/end-to-end
```

## Tanzu Application Catalog
Open a tab to Tanzu Application Catalog.  Make sure to select the "Tanzu End to End" org if you are prompted.
```dashboard:open-url
url: https://tac.bitnami.com/apps
```

## Tanzu Service Mesh
Open tab to Tanzu Service Mesh to the `e2e-demo` Global namespace by clicking the link below.  If you don't see the graph for the Global Namespace showing the `e2e-eks` and `e2e-tsm1` clusters, make sure to select the "Tanzu End to End" org, close the tab, and then reopen it again with the link below.
```dashboard:open-url
url: https://prod-2.nsxservicemesh.vmware.com/global-namespaces-detail/e2e-demo/gns-topology
```

# Tab Staging
Reorder your tabs in this way so that your demo flow goes left to right:
* GitHub
* Harbor
* Kubeapps
* TAC
* This workshop
* TMC
* TO
* TSM