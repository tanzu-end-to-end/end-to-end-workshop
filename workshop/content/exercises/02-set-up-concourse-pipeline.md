Let's set up a Concourse pipeline to execute our CI and CD phases of delivery.  Concourse is not a requirement for Tanzu, and you could just as easily perform equivalent steps in your favorite CI and CD tools.

First, let's login to Concourse.

```execute
fly -t concourse login \
  -c https://concourse.workshop.foo.bar \
  -n {{ session_namespace }} \
  -u admin-{{ session_namespace }} \
  -p admin
```

Next, let's setup some secrets for our pipeline to pull from.  

```execute
ytt -f concourse/pipeline/secrets.yaml -f values.yaml --ignore-unknown-comments | kapp deploy -n concourse-{{ session_namespace }} -a concourse-main-secrets -y -f -
```

Concourse can read Kubernetes secrets for your pipelines from a namespace configured for your team.  To read more about how Concourse manages secrets in Kubernetes, you can go to https://concourse-ci.org/kubernetes-credential-manager.html.

Next, we want to apply the pipeline definition to Concourse.

```execute
fly -t concourse set-pipeline -p petclinic -c concourse/pipeline/spring-petclinic.yaml -n
```

Let's make sure the pipeline was set in Concourse, open the following link and login with your username as `admin-{{ session_namespace }}` and password as `admin`

```dashboard:create-dashboard
https://concourse.workshop.foo.bar
```

Now, let's unpause the pipeline to let it start building.

```execute
fly -t concourse unpause-pipeline -p petclinic
```

If you watch the Concourse web dashboard for a minute, you'll notice that the continuous-integration job is automatically triggered, and starts the process to build your application.  This process also engages the Tanzu Build Service to create a secure container for your application, with all the dependencies necessary to run a Java application.

Wait for the build process to complete, and then go to Harbor to validate that the image was created.
```dashboard:create-dashboard
https://harbor.workshop.foo.bar
```

Next, the CD part of the pipeline should get triggered to deploy your application.  Go back to the Concourse Web UI to validate that the task runs and completes successfully.

Finally, access the Spring Pet Clinic App and try out a few functions to make sure it is working properly
```dashboard:create-dashboard
https://petclinic-{{ session_namespace }}.workshop.foo.bar
```