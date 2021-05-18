Welcome to the Tanzu End to End demo!  In this session, we'll be exploring some of the various capabilitites of Tanzu.

We're going to be using Tanzu to deploy an application, deploy dependent services for that application, observe the metrics for that application and supporting infrastructure, and manage the cluster hosting that application.

# Fork Spring Pet Clinic
To get started, you need to clone Spring Pet Clinic to you can make some changes to it as part of the demo process.  Click the icon in the upper right of the box below to open a new browser tab so that you can fork the Spring Pet Clinic repo into your Github account.
```dashboard:open-url
url: https://github.com/tanzu-end-to-end/spring-petclinic/fork
```
After forking, navigate to the `/src/main/resources/messages/messages.properties` file in your forked repo.  We want to pre-stage this tab so that you are ready to make an edit to this file to trigger a build later on.

# Access KubeApps
We'll be logging into KubeApps next.  To do that, we'll need to grab our user token to use to login.  Copy your user token below to use to login to kubeapps in the next step.
```workshop:copy
text: {{ user_token }}
```

Now, click the following link to open a new tab to Kubeapps pointing to a DB deployment that was created for you when you launched this environment. In the login screen, paste your token into the text field, and click "Login".  
```dashboard:open-url
url: https://kubeapps.{{ ingress_domain }}/#/c/default/ns/{{ session_namespace }}/apps
```
You should see a MySQL Deployment called `petclinic-db`.  It may still be starting when you first examine it, but it should go to 1 pod active fairly quickly.  Leave this view on the "Apps" tab so it is staged properly.

# Concourse
When your session was created, we logged into Concourse and added your pipeline.  Since you need to point to your fork of Spring Pet Clinic, we need to create some secrets for your Concourse pipeline.  You will need to paste the url for your PetClinic fork into the terminal prompt after clicking the box below.
```terminal:execute
command: |-
  read -p "Enter the Git URL of your fork of Pet Clinic: " PETCLINIC_GIT_URL; \
  ytt -f pipeline/secrets.yaml -f pipeline/values.yaml \
  --data-value commonSecrets.harborDomain=harbor.{{ ingress_domain }} \
  --data-value commonSecrets.kubeconfigBuildServer=$(yq d ~/.kube/config 'clusters[0].cluster.certificate-authority' | yq w - 'clusters[0].cluster.certificate-authority-data' "$(cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w 0)" | yq r - -j) \
  --data-value commonSecrets.kubeconfigAppServer=$(yq d ~/.kube/config 'clusters[0].cluster.certificate-authority' | yq w - 'clusters[0].cluster.certificate-authority-data' "$(cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w 0)" | yq r - -j) \
  --data-value commonSecrets.concourseHelperImage=harbor.{{ ingress_domain }}/concourse/concourse-helper \
  --data-value petclinic.wavefront.deployEventName=petclinic-deploy \
  --data-value petclinic.configRepo=https://github.com/tanzu-end-to-end/spring-petclinic-config \
  --data-value petclinic.host=petclinic-{{ session_namespace }}.{{ ingress_domain }} \
  --data-value petclinic.image=harbor.{{ ingress_domain }}/{{ session_namespace }}/spring-petclinic \
  --data-value petclinic.tbs.namespace={{ session_namespace }} \
  --data-value petclinic.wavefront.applicationName=petclinic-{{ session_namespace }} \
  --data-value "petclinic.codeRepo=${PETCLINIC_GIT_URL}" \
   | kubectl apply -f- -n concourse-{{ session_namespace }}
session: 1
```
The pipeline starts off paused, so let's unpause it now that we've created secrets for it.
```terminal:execute
command: fly -t concourse unpause-pipeline -p spring-petclinic
session: 1
```

Now, let's open a browser window to your pipeline.  Login with user "{{ ENV_CONCOURSE_USERNAME }}" and password "{{ ENV_CONCOURSE_PASSWORD }}"
```dashboard:open-url
url: https://concourse.{{ ingress_domain }}/teams/{{ session_namespace }}/pipelines/spring-petclinic
```
Validate that it is picking up your code and doing the first build.  It is important to let this process complete so that it can pre-cache all your dependencies and allow your builds to execute much faster.  This will take a while the first time.

# Harbor
Next, click the link below and login to Harbor with the user "admin" and password "{{ ENV_HARBOR_PASSWORD }}".  If you login and aren't redirected to your project, then simply close the Harbor tab that was opened, and reopen it with the link below.
```dashboard:open-url
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

# Spring Pet Clinic App
Open a tab to your deployed Pet Clinic instance
```dashboard:open-url
url: https://petclinic-{{ session_namespace }}.{{ ingress_domain }}
```
If you don't see the Pet Clinic interface at first, go back to your Concourse tab and ensure that the `continuous-delivery` job completed successfully.  The first build can take a few minutes to complete and deploy.

# SaaS Services
**Important**: For the next sections, it is vital that you  make sure to sign-in to cloud.vmware.com with your **@vmware.com** email address and select the **"Tanzu End to End"** organization.  Please be careful not to alter the services or configurations of the clusters in these environments as they are shared for the entire End to End Demo Environment.

Click below to sign in.  If you can't see this organization, you can self-enroll into the organization at https://via.vmware.com/tanzu-e2e-demo
```dashboard:open-url
url: https://console.cloud.vmware.com
```

## Tanzu Observability
Open a tab to Tanzu Observability for your Pet Clinic Dashboard.  First, you will need to sign in to the following Wavefront instance.
```dashboard:open-url
url: https://vmware.wavefront.com/u/GVQsHYwxZC?t=vmware
```
If you are having trouble accessing this instance, make sure you have the Wavefront-sandbox app added to your Workspace One account.  You can access that app at https://myvmware.workspaceair.com/catalog-portal/ui#/apps/details/WORKSPACE-d689139a-9b94-4b6f-aa23-915763e9b149-Web-Saml20, and then try to click the link above.

Now, copy your app name below, click on the Application dropdown and select Service Dashboard, and on the new page click on the Application dropdown and paste the app name you copied previously into the application dropdown and select the application. It may take a minute for metrics to flow in where you can actually select that application name, so if you can't see your app in the list try to refresh the page the page after a minute or two.
```workshop:copy
text: petclinic-{{ session_namespace }}
```

## Tanzu Mission Control
Open a tab for Tanzu Mission Control
```dashboard:open-url
url: https://tanzuendtoend.tmc.cloud.vmware.com/clusterGroups/end-to-end-emea
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
