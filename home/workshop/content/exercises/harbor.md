Now, let's have a look at the images that have been published to Harbor.

Click on the "Harbor" tab to bring up the Harbor UI.  Login with your username as admin and password as Harbor12345.

In the list of projects, you'll see a project called petclinic-{{session_namespace}}.  Click on that project, and you should get a list of two repositories back for your project.

The `spring-petclinic-source` is the repository for the temporary image used to transfer the application JAR to the build service.

The `spring-petclinic` repository is the repository used for the built application images.  Click on the repository name to drill into the repository to see the published images.  You should see at least 3 images in the repository.  The oldest image cooresponds to the image built when we first set up the pipeline, and were using the old stack that had some extra vulnerabilities in it.  Note the number of vulnerabilities for that image.

The next oldest image should be the image that was created when we pointed the application build definition to the version of the builder that had resolutions for some CVEs.  Notice the number of vulnerabilities in the "Vulnerability" column should be lower than the oldest image.  If you hover over the number of vulnerabilities for the image, you should see a breakdown of the severity level of the vulnerabilities detected for that image.  Let's get a deeper look at the specific vulnerabilties.  Click on the link text for that image in the "Artifacts" column of the list.

In the resulting page, you can see some more details about the image.  Scroll down to the bottom section of the page under the "Additions" title and you should see a list of the specific CVEs that apply to the this image.  You can open up each CVE line by clicking on the "greater-than" symbol at the left of the row to get a brief description of the vulnerability.  If you click on the "I" icon next to the CVE name, you will get any links to view the full report for that CVE.

Next, let's navigate back to the top level of the project by scrolling up to the top of the page, and then clicking the "petclinic-{{session_namespace}}" link in the breadcrumb trail just below the search box at the top of the Harbor UI.  Now, click on the "Configuration" tab in the page in the tab bar underneath the project title at the top of the UI.  Explore this page to see how you can use Harbor to automatically scan your images, prevent images with certain CVE levels from being pulled and used to run, how you can specifically allow certain CVEs for your project temporarily while waiting for fixes to be rolled out.