# End to End Workshop

This is a workshop for delivering an end to end experience of [VMware Tanzu](https://tanzu.vmware.com) solutions.

You can currently access a hosted version of the E2E workshop here: https://via.vmware.com/tanzu-e2e-demo

## Prerequisites

To install the E2E workshop in your own environment, the following prereqs must be in place in your Kubernetes cluster:

**Environment Values File**

Follow the docs for [Customizing the Environment Values File](install/values/README.md). Ensure that you have the carvel tools **ytt** and **kapp** installed on your local machine.

**Contour**

Set up Contour, with a wildcard DNS domain, that terminates with a signed cert. LetsEncrypt is a great tool for generating the cert. Follow the docs for [Configuring TLS Certificate Delegation](install/certificate/README.md)

**Educates**

Install the educates operator, per these instructions: https://docs.edukates.io/en/latest/getting-started/installing-operator.html

**Harbor**

Follow the docs for [Installing Harbor](install/harbor/README.md)

**Concourse**

Follow the docs for [Installing Concourse](install/concourse/README.md)

**Tanzu Build Service**

Install Tanzu Build Service per the [Documentation](https://docs.pivotal.io/build-service/1-0/installing.html)

**Kubeapps**

Follow the docs for [Installing Kubeapps](install/kubeapps/README.md)

**ArgoCD**

Follow the docs for [Installing Argocd](install/argocd/README.md)

## Workshop

Finally, follow the docs for [Installing the Workshop](install/workshop/README.md)

The workshop will take a couple of minutes to start. Run:
```
kubectl get eduk8s-training
```
to get the TrainingPortal URL that will be used to access the workshop. The training portal is configured to allow anonymous access. For your own
workshop content you should consider removing anonymous access.
