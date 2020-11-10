Your develoers are now using the best frameworks and practices in developing their application code, but now they need to package that code up for delivery so that it can be run.  

Increasingly, the most popular way to do that is via containers.  But your developers don't want to build an entire container from scratch, so they search around the internet for the best option.  At last count, there were almost **25,000** container images on Docker Hub that mention the word "Java" in them.  So which one is the right on for your developers to use?  And who is responsible for keeping that image updated with the latest security patches?

Tanzu makes this process much simpler for developers and operators by providing services that standardize the container creation process using best practices customized for the type of application technologies your developers are using.  This capability is built on top of the Cloud Native Buildpacks project from the Cloud Native Computing Foundation.  Vmware provides support for the base images for your developers, and provides patches and updates for bugs and CVEs associated with those images.

And when a patch comes out for a critical issue (Heartbleed, Ghost, Shellshock, etc.), your operators can easily rebase all your images in minutes and then roll out those updates to your clusters.

Let's look at how this works with Tanzu!

* Go to the Pet Clinic tab to explain this is a sample app we want to make an update to.
* Go to the Github tab and edit the welcome message to something new, and commit it.
* Go to the Concourse tab and show the section for update-build-service-image
* Watch the build process and explain the high level process of Detect, and Build phases.
* Next, go to the continuous-deployment job, and show the application deployment occuring.
* Next, go to the Octant console in the workshop tab to show the deployment rolling out
* Finally, refresh the Petclinic window to show the change.
* Now, let's put on the hat of an operator who needs to roll out a change for a critical CVE.  
```terminal:execute
command: |-
  docker login harbor.tools.pez.aws.grogscave.net -u admin -p Harbor12345
  kp image patch spring-petclinic --cluster-builder default  
session: 1
```
* Now, let's check the build
```terminal:execute
command: |-
  kp builds list spring-petclinic
session: 1
```