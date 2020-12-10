# End to End Workshop

This is a workshop for delivering an end to end experience of [VMware Tanzu](https://tanzu.vmware.com) solutions.

You can currently access a hosted version of the E2E workshop here: https://via.vmware.com/tanzu-e2e-demo

## Prerequisites

To install the E2E workshop in your own environment, the following prereqs must be in place in your Kubernetes cluster:

**Educates**

Install the educates operator, per these instructions: https://docs.edukates.io/en/latest/getting-started/installing-operator.html

**Ingress**

Set up ingress, with a wildcard DNS domain, that terminates with a signed cert. Contour and LetsEncrypt are great tools for this.

**Harbor**

Install Harbor into your cluster with Helm. 

```
helm repo add harbor https://helm.goharbor.io
helm repo update
kubectl create namespace harbor

[Create a PVC called harbor-registry-pvc for storing your images.
Create a secret called ingress-tls that contains your signed wildcard domain certificate]

helm install harbor harbor/harbor -n harbor \
  --set expose.tls.certSource=secret \
  --set expose.tls.secret.secretName=ingress-tls \
  --set expose.ingress.hosts.core=<your ingress domain> \
  --set persistence.persistentVolumeClaim.registry.existingClaim=harbor-registry-pvc \
  --set notary.enabled=false --set externalURL="https://harbor.<your ingress domain>"
```

**Concourse**

Install Concourse into your cluster with Helm. Customize the [values.yaml](https://raw.githubusercontent.com/concourse/concourse-chart/master/values.yaml) file so that your ingress route is **concourse.(your-ingress-domain)**, and set the user/password for your main team.

```
helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm repo update
kubectl create namespace concourse

helm install concourse -f concourse-values.yaml concourse/concourse -n concourse
```

**Kubeapps**

Install Kubeapps into your cluster with Helm.

```
helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace kubeapps

helm install kubeapps --namespace kubeapps bitnami/kubeapps
```

Create an Ingress or HttpProxy with the DNS name **kubeapps.(your ingress domain) that resolves the **kubeapps** service in the kubeapps namespace. Follow the [instructions](https://github.com/kubeapps/kubeapps/blob/master/docs/user/getting-started.md#step-2-create-a-demo-credential-with-which-to-access-kubeapps-and-kubernetes) for creating a KubeApps access token.

## Install Workshop

Check out the workshop repo (or your fork locally). Create a public project called **tanzu-e2e** in your Harbor instance. Using the Dockerfile in the root of this repo, build a Docker image with the tag **harbor.(your ingress domain)/tanzu-e2e/eduk8s-e2e-workshop**. Push it to your Harbor repo.

Make a copy of **values-example.yaml** and call it values.yaml. Customize this file with the appropriate values for your install of ingress, concourse, and harbor. Make sure you have *ytt* and *kapp* installed on your lcoal machine.

From the root directory of this repo, install the Metacontrollers:
```
ytt template -f metacontroller -f values.yaml | kapp deploy -a metacontroller -f- --diff-changes --yes
```

Then, install the workshop itself:
```
ytt template -f base -f ~/values.yaml | kapp deploy -a workshop -f- --diff-changes --yes
```

The workshop will take a couple of minutes to start. Run:
```
kubectl get eduk8s-training
```
to get the TrainingPortal URL that will be used to access the workshop. The training portal is configured to allow anonymous access. For your own
workshop content you should consider removing anonymous access.

