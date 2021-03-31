No matter how your developers are packaging up their application as a container, they need a place to store that container image so that it can be used by others.  But what if this image wasn't built by the build services we discussed before?  What if that image is a third-party component or service that your developers need to use along with their application?  Your developers want to use the latest and greatest technologies, but the people operating those applications are on the hook to make sure they don't contain critical CVEs that could compromise your applications and data.  You also want to be sure that the contents of those images haven't been altered in some way before they land on your clusters.

Tanzu provides capabilities for hosting those container images that go far beyond a simple "file server."  Tanzu's image registry acts as another control point in your infrastructure that prevents images that don't meet your security standards from ever reaching your application clusters.  It shifts security concerns to a much earlier phase in the application lifecycle so that developers aren't surprised by a security scan right at the end of a development cycle that causes them a lot of redesign and rework.

Let's look at Tanzu's image registry to see how this works. Click the link below to navigate to your project page in Harbor.

```dashboard:reload-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

We can see that Tanzu Build Service has created a new container image called spring-webdb, ready to deploy! Click on the image name.

Hover over the "X Total" count in the Vulnerabilities column to see an overview of the security scan results. Explain how using Tanzu Build Service means developers are not responsible for keeping the software in their container image patched and secured. Buildpacks are consistently updated to ensure your application containers are protected from vulenrabilities.

Click on the `sha256:....` link, and scroll down to show the CVE list for that image.  Open up a CVE and highlight the description.  Then click on the "I" icon to show the links to the relevant CVE reports.

Now, scroll back up to the top of the page, click on the project name (e2e-workshop-...) and go to the "configuration" tab in the top-level menu.  Call out the "Automatically scan images on push" checkbox and how that works with the "Prevent vulnerable images from running" function.  This feature allows blocking images from being pulled that have a certain level of severity of CVE.

Call out the "Enable Content Trust" setting that requires images to be signed to ensure they haven't been modified before they can be pulled.

Highlight the "Helm Charts" top-level to mention that Harbor also hosts Helm charts, which is important for the TAC discussion.