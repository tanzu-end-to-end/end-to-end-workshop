Welcome to the Tanzu End to End demo!  In this session, we'll be exploring some of the various capabilitites of Tanzu.

We're going to be using Tanzu to deploy an application, deploy dependent services for that application, observe the metrics for that application and supporting infrastructure, and manage the cluster hosting that application.

To get started, you need to clone Spring Pet Clinic to you can make some changes to it as part of the demo process.  Click the icon in the upper right of the box below to open a new browser tab so that you can fork the Spring Pet Clinic repo into your Github account.
```dashboard:open-url
url: https://github.com/tanzu-end-to-end/spring-petclinic/fork
```
After forking, navigate to the `/src/main/resources/messages/messages.properties` file in your forked repo.  We want to pre-stage this tab so that you are ready to make an edit to this file to trigger a build later on.

We'll be logging into KubeApps next.  To do that, we'll need to grab our user token to use to login.  Copy your user token below to use to login to kubeapps in the next step.
```workshop:copy
text: {{ user_token }}
```

Now, click the following link to open a new tab to Kubeapps pointing to your a DB deployment that was created for you when you launched this environment. In the login screen, paste your token into the text field, and click "Login".  
```dashboard:open-url
url: https://kubeapps.{{ ingress_domain }}/#/c/default/ns/{{ session_namespace }}/apps
```
You should see a MySQL Deployment called `petclinic-db`.  It may still be started when you look at it, but it should go to 1 pod active fairly quickly.

Now you need to create a secret for Build Service to be able to push images to harbor.
```terminal:execute
command: |-
  kp secret create harbor-creds \
    --registry harbor.{{ ingress_domain }} \
    --registry-user admin \
    --namespace {{ session_namespace }}
```

Now in the resulting prompt, enter the password of `Harbor12345` or click below.
```terminal:input
text: Harbor12345
session: 1
```

Next, you have a Concourse team already created for you.  Let's login with the `fly` command in the terminal.
```terminal:execute
command: fly -t concourse login -c https://concourse.{{ ingress_domain }} -u test -p test -n={{ session_namespace }}
session: 1
```

Now we need to create some secrets for your Concourse pipeline.  You will need to paste the url for your PetClinic fork into the terminal after clicking the box below.
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

Now, set your pipeline.
```terminal:execute
command: fly -t concourse set-pipeline -c pipeline/spring-petclinic.yaml -p spring-petclinic -n
session: 1
```

The pipeline starts off paused, so let's unpause it!
```terminal:execute
command: fly -t concourse unpause-pipeline -p spring-petclinic
session: 1
```

Now, let's open a browser window to your pipeline.  Login with user "test" and password "test"
```dashboard:open-url
url: https://concourse.{{ ingress_domain }}/teams/{{ session_namespace }}/pipelines/spring-petclinic
```
Validate that it is picking up your code and doing the first build.  It is important to let this process complete so that it can pre-cache all your dependencies and allow your builds to execute much faster.  This will take a while the first time.

Next, login to harbor with the user "admin" and password "Harbor12345", and navigate to your project called **{{ session_namespace }}**
```dashboard:open-url
url: https://harbor.{{ ingress_domain }}
```

Open a tab to your deployed Pet Clinic instance
```dashboard:open-url
url: https://petclinic-{{ session_namespace }}.{{ ingress_domain }}
```
If you don't see the Pet Clinic interface, go back to your Concourse tab and ensure that the `continuous-delivery` job completed successfully.

Open a tab to Tanzu Observability for your Pet Clinic Dashboard.  First, you will need to sign in to the following Wavefront instance.
```dashboard:open-url
url: https://vmware.wavefront.com/u/n1XssyygW7?t=vmware
```
Now, copy your app name below, and paste into the application dropdown on the TO browser tab.
```workshop:copy
text: petclinic-{{ session_namespace }}
```

Open a tab for Tanzu Mission Control
```dashboard:open-url
url: https://tanzupaorg.tmc.cloud.vmware.com/clusterGroups/pez-e2e
```

Open a tab to Tanzu Application Catalog
```dashboard:open-url
url: https://tac.bitnami.com/apps
```

Finally, reorder your tabs this way:
start.spring.io, Pet Clinic, GitHub, Concourse, Harbor, Kubeapps, TAC, Workshop tab on the "Console" section, TMC, TO, TSM