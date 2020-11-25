Remember earlier when we talked about how developers might want to pull in other containers that support their applications.  Even if those containers aren't affected by critical CVEs, they might not be configured to deployed in the most secure way possible.  Wouldn't it be great to address security concerns even earlier in the app lifecycle so that your developers are chosing services that have already been approved for use?  And wouldn't it be great to give those development teams a leg up on running those services the way you'd want them run in production?

Tanzu provides a catalog for services that you can offer to your developers so that they start off on the right foot much sooner and choose services that already meet your standards.  And VMware Tanzu also provides hardened images for those services that already capture the best practices for running those services in the most secure way.

Let's take a look at those capabilties.

* First, go to the Kubeapps tab.  Show the deployed mysql DB that you created during setup.
* Next, click on the "Catalog" tab at the top of the page to show the list of services available to deploy.  Highlight any that might be relevant for your customer.
* Type "mysql" into the search box, and click the MySQL tile that shows up, then click "Deploy".
* Scroll down a little more than 1/3rd of the way down in the YAML, and look for the "securityContext" section.  Call out the fact that some images take the easy way out and assume they can run privileged, but VMware ensures best practices like running as a non-priveleged user are the default.
* Now switch over to the TAC tab.  Click Add New applications, and show how you can create a custom catalog.  This allows platform operators to curate the list of services that a developer could choose from which helps orient them to the services you prefer them to use.