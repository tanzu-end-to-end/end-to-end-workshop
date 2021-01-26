Your developers are now using the best frameworks and practices in developing their application code, but now they need to package that code up for delivery so that it can be run.  

Increasingly, the most popular way to do that is via containers.  But your developers don't want to build an entire container from scratch, so they search around the internet for the best option.  At last count, there were almost **25,000** container images on Docker Hub that mention the word "Java" in them.  So which one is the right on for your developers to use?  And who is responsible for keeping that image updated with the latest security patches?

Tanzu makes this process much simpler for developers and operators by providing services that standardize the container creation process using best practices customized for the type of application technologies your developers are using.  This capability is built on top of the Cloud Native Buildpacks project from the Cloud Native Computing Foundation.  Vmware provides support for the base images for your developers, and provides patches and updates for bugs and CVEs associated with those images.

And when a patch comes out for a critical issue (Heartbleed, Ghost, Shellshock, etc.), your operators can easily rebase all your images in minutes and then roll out those updates to your clusters.

Let's look at how this works with Tanzu!

```terminal:execute
kp image create spring-webdb-{{ session_namespace }} --tag harbor.{{ ingress_domain }}/{{ session_namespace }}/spring-webdb --git https://github.com/cpage-pivotal/spring-webdb
session: 1
```

```terminal:execute
kp build logs spring-webdb-{{ session_namespace }} -b 1
session: 2
```
