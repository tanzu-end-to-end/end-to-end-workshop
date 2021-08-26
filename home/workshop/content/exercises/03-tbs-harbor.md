We've been publishing our container images to Harbor, the open source registry that's supported as part of the Tanzu portfolio. Harbor provides capabilities for hosting container images that go far beyond a simple "file server."  Harbor acts as another control point in your infrastructure that prevents images that don't meet your security standards from ever reaching your application clusters.  It shifts security checks to an earlier phase in the application lifecycle, and enables Alana to manage a secure software supply chain.

Let's look at Harbor to see how this works. Click the link below to navigate to your project page in Harbor.

```dashboard:reload-dashboard
name: Harbor
url: https://harbor.{{ ingress_domain }}/harbor/projects/{{ harbor_project_id }}/repositories
```

We can see that Tanzu Build Service has created a new application container image, ready to deploy! Click on the image name.

On the detail view, we can see there are two tagged versions of the image, published a few minutes apart. The first image was produced using the base OS layer from a few months ago, and the second image was built using the recent patched image that Alana received from VMware.

Hover over the "X Total" count in the Vulnerabilities columns to see an overview of the security scan results. We can see how Tanzu Build Service radically improved our security posture by ensuring our image builds are current, and Harbor gives us direct visibility to verify that posture.

Click on one of the `sha256:....` links, and scroll down to show the CVE list for that image.  Open up a CVE and highlight the description.  Then click on the "I" icon to show the links to the relevant CVE reports.

Now, scroll back up to the top of the page, click on the project name (e2e-workshop-...) and go to the "configuration" tab in the top-level menu.  Call out the "Automatically scan images on push" checkbox and how that works with the "Prevent vulnerable images from running" function.  This feature allows blocking images from being pulled that have a certain level of severity of CVE.

Call out the "Enable Content Trust" setting that requires images to be signed to ensure they haven't been modified before they can be pulled.

Highlight the "Helm Charts" top-level to mention that Harbor also hosts Helm charts, which is important for the TAC discussion.