If you have developed an application from the ground up to be cloud native and easily portable across clouds, you often have a lot of flexibility when it comes to where you deploy.  But from what we've seen, that isn't most applications.  You have issues of data gravity that keep certain services more tied to a specific deployment location.

You also want to be able to leverage the best of breed services that every cloud has to offer no matter which cloud it is on.

But getting the services on one cloud to work with services deployed on a different cloud can be challenging.  Every cloud has its own methods of configuring networking and the complexity can be daunting.  It can be difficult manage the protection of your data in flight all the way from the source application to the destination and back.  And you don't have time to go back and redesign your applications to do all this.

Tanzu makes the process of connecting applications running across clouds simple for operations and applications teams by grouping all those services into a global namespace that spans multiple clusters.  By leveraging open source projects like Istio, Tanzu enables applications to discover remote services through DNS.  It routes network traffic to remote clusters, and manages mTLS encrypted links between clouds that ensure your data is always protected.

* Click on the tab for Tanzu Service Mesh
* Show the Global Namespace called `e2e-demo`.  Point out this application is running on one cluster running TKG in AWS (e2e-tsm1) and one cluster that is running on EKS (e2e-eks).  Show that we have an ingress gateway that is the main ingress for the application (istio-ingressgateway).  Highlight that the catalog service is running in the e2e-eks cluster, and that we can see an mTLS protected, cross-cluster link between the shopping service and the catalog service.  No special rules had to be created to enable this, and this link is being completely managed by TSM.
* Hover over the catalog service name in the graph and show the performance stats.  The value of exposing these KPIs right in the Service Mesh interface is to speed troubleshooting.
* Next, let's look at how global namespaces are set up.  Click on the "Edit" button for the `e2e-demo` global namespace.  On the first page of the dialog, highlight that the "Domain" field is an arbitrary domain that you will use to refer to all the services in that namespace.  It doesn't need to be a registered domain, as this name is only used by services in the namespace to reach each other.  That domain is simply a signal to the mesh that it needs to look in the global namespace to resolve that domain name.  Click "Next" to go to the "Service Mapping" dialog.
* In the "Service Mapping" dialog, highlight the mapping rules that onboard services into the new global namespace.  Point out we've selected a cluster and namespace combination for both clusters.  Open up the "Service Preview" section on each mapping rule to show the services that are mapped in.  Click next to skip to the "Security" section to highlight we're enforcing 'mTLS' encryption between services and block non-encrypted traffic.  Highlight that policy is managed by the mesh itself, and the applications don't have to make any changes to enable that functionality.
* Click on the "Cancel" button to exit the dialog.

And there you have it!  Tanzu helps you address all those challenges we discussed in the beginning around developing, delivering and operating resilient applications that meet the strictest security standards and follow best practices for cloud native applications.

* Refresh the Pet Clinic app.

Thanks for watching!