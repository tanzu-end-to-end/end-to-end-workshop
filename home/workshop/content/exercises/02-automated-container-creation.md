Your develoers are now using the best frameworks and practices in developing their application code, but now they need to package that code up for delivery so that it can be run.  

Increasingly, the most popular way to do that is via containers.  But your developers don't want to build an entire container from scratch, so they search around the internet for the best option.  At last count, there were almost **25,000** container images on Docker Hub that mention the word "Java" in them.  So which one is the right on for your developers to use?  And who is responsible for keeping that image updated with the latest security patches?

Tanzu makes this process much simpler for developers and operators by providing services that standardize the container creation process using best practices customized for the type of application technologies your developers are using.  This capability is built on top of the Cloud Native Buildpacks project from the Cloud Native Computing Foundation.  Vmware provides support for the base images for your developers, and provides patches and updates for bugs and CVEs associated with those images.

And when a patch comes out for a critical issue (Heartbleed, Ghost, Shellshock, etc.), your operators can easily rebase all your images in minutes and then roll out those updates to your clusters.

Let's look at how this works with Tanzu!

* Go to the Pet Clinic tab to explain this is a sample app we want to make an update to.
* Go to the Github tab and edit the welcome message to something new, and commit it.  Maybe "Thanks!"
* Go to the Concourse tab and show the section for update-build-service-image
* Explain the high level process of Detect, and Build phases.  The value here is that the base image is a secure base image provided by VMware, and the images are build with a consistent, curated and tested build process that brings the best practice standards for running containerized applications.


* Now, let's put on the hat of an operator who needs to roll out a change for a critical CVE.  As a developer, you don't need to do anything to get those patches applied to your application image.  VMware delivers patches for the base image, and runtimes and operators can automatically roll those updates out.  Let's see how.  First, let's watch the builds so we can see this update run.

```terminal:execute
command: watch kp builds list spring-petclinic
session: 2
```

* Now let's apply updates

```terminal:execute
command: |-
  kp image patch spring-petclinic --cluster-builder default  
session: 1
```

* Highlight the "reason" for build.