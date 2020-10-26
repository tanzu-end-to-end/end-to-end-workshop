The image we first built for Spring Petclinic was purposefully using an older stack so that we could explore what happens when we need to remediate CVEs.  Let's fix some of those critical vulnerabilities by upgrading our app to use a later version of the stack.

First, trigger a new build of the app by updating the Stack associated with the Builder we defined for Spring Pet Clinic.

```execute
kp clusterstack update demo-stack \
  --build-image harbor.workshop.foo.bar/tbs/build@sha256:ee37e655a4f39e2e6ffa123306db0221386032d3e6e51aac809823125b0a400e \
  --run-image harbor.workshop.foo.bar/tbs/run@sha256:51cebe0dd77a1b09934c4ce407fb07e3fc6f863da99cdd227123d7bfc7411efa
```

Now, you can watch the build status to see Tanzu Build Service create the new image for the app with the updated dependencies that reduce the number of vulnerabilities.

```execute
kp build list spring-petclinic -n {{ session_namespace }}
```

Once you see a status of `SUCCESS`, then you can go to your Harbor project and refresh the list to see your new image with fewer dependencies.