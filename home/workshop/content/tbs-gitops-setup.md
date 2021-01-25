Welcome to the Tanzu End to End demo!  In this session, we'll be exploring the capabilitites of Tanzu Advanced Edition, and see how they would be used in an actual software lifecycle scenario.

We're going to be using Tanzu to deploy an application, deploy dependent services for that application, observe the metrics for that application and supporting infrastructure, and manage the cluster hosting that application.

# Fork the Application Configuration Repo
To get started, you need to clone the GitOps configuration repo, so you can make some changes to it as part of the demo process.  Click the icon in the upper right of the box below to open a new browser tab so that you can fork the Spring Pet Clinic repo into your Github account.
```dashboard:open-url
url: https://github.com/cpage-pivotal/spring-webdb-config/fork
```
After forking, navigate to the `/dev/configmap.yaml` file in your forked repo.  We want to pre-stage this tab so that you are ready to make an edit to this file to stage a deployment change.

# Access KubeApps
We'll be logging into KubeApps next.  To do that, we'll need to grab our user token to use to login.  Copy your user token below to use to login to kubeapps in the next step.
```workshop:copy
text: {{ user_token }}
```

Now click on the KubeApps tab on the right side of this screen. In the login screen, paste your token into the text field, and click "Login". 
You should see a MySQL Deployment called `petclinic-db`.  It may still be starting when you first examine it, but it should go to 1 pod active fairly quickly.  Leave this view on the "Apps" tab so it is staged properly.

# Harbor
Next, click on the Harbor tab on the right side of this screen. Login to Harbor with the user "admin" and password "{{ ENV_HARBOR_PASSWORD }}". 

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

# Spring and/or Steeltoe Starters
Click the links below to open up to the project generators for Spring and Steeltoe for .NET
```dashboard:open-url
url: https://start.spring.io
```

```dashboard:open-url
url: https://start.steeltoe.io
```


# Tab Staging
Reorder your tabs in this way so that your demo flow goes left to right:
* start.spring.io and/or start.steeltoe.io
* Pet Clinic
* GitHub
* Concourse
  * Make sure to go back to the pipeline overview to be staged on your "continuous-integration" and "continuous-delivery" jobs.
* Harbor
  * Make sure to refresh the list of repositories after your app is deployed so that you are staged showing the "spring-petclinic" and "spring-petclinic-source" repositories.
* Kubeapps
* TAC
* This workshop tab on the "Console" section
* TMC
* TO
* TSM