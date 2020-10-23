# End to End Workshop

This is a workshop for delivering an end to end experience of [VMware Tanzu](https://tanzu.vmware.com) solutions.

For more detailed information on how to create and deploy workshops, consult
the documentation for eduk8s at:

* https://docs.eduk8s.io

If you already have the eduk8s operator installed and configured, to deploy
and view this workshop, run:

```
kubectl apply -f https://raw.githubusercontent.com/tanzu-end-to-end/end-to-end-workshop/main/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/tanzu-end-to-end/end-to-end-workshop/main/resources/training-portal.yaml
```

This will deploy a training portal hosting just this workshop. To get the
URL for accessing the training portal run:

```
kubectl get trainingportal/end-to-end-workshop
```

The training portal is configured to allow anonymous access. For your own
workshop content you should consider removing anonymous access.
