Welcome to the Tanzu End to End demo!  In this session, we'll be exploring some of the various capabilitites of Tanzu.

First, we need to clone Spring Pet Clinic.
```dashboard:open-url
url: https://github.com/cdelashmutt-pivotal/spring-petclinic
```

Next, you have a Concourse team created for you.  Let's login with the `fly` command in the terminal.
```terminal:execute
command: fly -t concourse login -c https://concourse.{{ ingress_domain }} -u test -p test -n={{ session_namespace }}
session: 1
```
Now, set your pipeline.
```terminal:execute
command: fly -t concourse set-pipeline -c pipeline/spring-petclinic.yaml -p spring-petclinic
session: 1
```

Next, login to harbor with the user "admin" and password "Harbor12345", and navigate to your project called {{ session_namespace }}
```dashboard:open-url
url: https://harbor.{{ ingress_domain }}
```

We'll be logging into KubeApps next.  To do that, we'll need to grab our user token to use to login.  Note, we'll explore changing this to OIDC based logins in the future.
```terminal:execute
command: yq r ~/.kube/config 'users(name==eduk8s).user.token'
session: 1
```

Copy the resulting token into your clipboard, then open the following link in a new tab.
```dashboard:open-url
url: https://kubeapps.{{ ingress_domain }}/#/c/default/ns/{{ session_namespace }}/apps
```

Now, paste the token you copied above into the box and click "Login".