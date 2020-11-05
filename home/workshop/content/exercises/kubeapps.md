Applications rarely exist on their own.  Many applications make use of off-the-shelf components like databases or messaging servers along with custom application code.  Dockerhub and Helm provide a ton of images for various services, but the quality and security posture of those publicly available resources can vary widely.  Plus, using one of these publicly available images or helm charts can slow down the delivery process for your applications since your security teams may need to perform additional scanning or validation on the iamges themselves, or how the chart you happen to be using happens to deploy that service.

One common thing that most organizations develop as they mature in their use of Kubernetes is a set of images and helm charts that deploy services in a way that already bakes in the best practices that your organization has identified for these services.  Kubeapps in conjuntion with Tanzu Application Catalog gives your organization a way to leverage the best practices for running popular services like MySQL, RabbitMQ, and others that VMware has collected in working with our customers.  We'll examine Tanzu Application catalog a little later on, so, for now, your platform team has already built a catalog for you to use, so let's explore that.

Go to the "Kubeapps" tab.

Normally, Kubeapps would be integrated with your cluster's OIDC provider, and you would typically use your credentials to sign in with that provider to access your cluster, and Kubeapps.  In this workshop, we'll need to paste your Kubernetes token into the Kubeapps interface to login.

```copy
{{kubernetes_token}}
```

Next, click on the "Current Context" dropdown on the top right of the Kubeapps UI.  Select the {{session_namespace}} namespace.  This will set the context for subsequent operations to your workshop namespace.

Next, click on the "Catalog" tab in the top left of the Kubeapps UI.  You will now see a list of services that have been curated by your platform team.  Spring Pet Clinic needs a database, so let's deploy a MySQL database for it to use.  Click on the "search charts" text just under the tabs on the top left of the UI.  Type "mysql" to show the curated mysql service tile.  Click on the mysql tile to explore it further.

The resulting screen shows you information about the latest published version of this service.  Explore the page to view information about the various parameters for the chart and installation instructions.

Kubeapps gives you the ability to deploy this mysql service with customized parameters right from the UI.  If you scroll to the top or bottom of the page, you'll see a button in the upper left or lower right corner that says "Deploy".  Click the "Deploy" button.

The next screen will give you the ability to name your deployment, and set parameters for it.  If you are familiar with the Helm deployment tool, you will notice that the YAML cooresponds with a Helm values file that will be used with the deployment.  By default, the file contains the chart defaults for this deployment.  Edit the "Name" of the deployment to be "petclinic-db".  Then clear out the existing YAML for the service deployment, and copy and paste the text below into the YAML text box.

```copy
db:
  name: petclinic
  password: petclinic
  user: petclinic
replication:
  enabled: false
root:
  password: petclinic
```

Wait for the application to show 1 pod ready before moving on.