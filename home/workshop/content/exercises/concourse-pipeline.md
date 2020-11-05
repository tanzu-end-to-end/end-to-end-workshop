Now, go to the Concourse tab and view the status of the pipeline to make sure it is picking up the change we made.

You should see that the `continuous-integration` job is running because it has radiating borders around it.  Click on the `continous-integration` job to view the status of the build.

Inside of the `continuous-integration` job, you should see the steps for grabbing the source code update, running the compile and test build script tasks, and then the task to kick off the build service to update the image for our application.  Click on the `compile-and-test` task to view the log output for that task.  You will see the Gradle build script progressing, running tests, and eventually packaging up the JAR file for the application.  Watch for the line saying `BUILD SUCCESS` before moving on.

Now, once the `update-build-service-image` task starts executing, click on the bar for `update-build-service-image`.  You should start to see logs streaming in as the task spins up.  You can watch the process of the `kp` CLI uploading the new JAR file we built to a temporary image for the build service to use to create a new image for the app.  Notice the "PREPARE" phase where the build service pulls in the "spring-petclinic-source" temporary image to retrive the JAR file into the build environment.

Next, you should the "DETECT" phase start which allows all the buildpacks defined in the ClusterBuilder that the Pet Clinic app is using to evaluate whether or not they should participate in the build.  The buildpacks that will participate are listed in the log output.

Next, in the "ANALYZE" phase, you will see the build service looking to see if there are previous layers for the application that can be reused, or if an new set of layers must be generated.

If you then look for the "BUILD" phase, you will start to see the output of all the buildpacks participating in the image creation process.  You should see builpacks pulling in a JRE to run the app with, scripts getting generated to launch the app with appropriate JVM sizing based on pod memory allocations, a JVM agent to capture debugging information if the application crashes unexpectedly, and configuration helpers that support injecting configuration for the Spring Boot and Spring Cloud frameworks from Kubernetes.

Finally, in the "EXPORT" phase, you will see any layers that were created/updated as part of the build will then be uploaded to the Harbor registry.

Once the output shows `Build successful` the build process is complete.