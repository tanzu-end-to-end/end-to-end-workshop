# Installing Concourse

Ensure that you have prepared a values.yaml file, by customizing the values-example.yaml file in the root of this repo.

### (Optional) Define dedicated nodes for Concourse workers
If you wish to designated dedicated worker nodes for your Concourse workers, follow these instructions. Otherwise, skip to the next section, entitled **Run the Installer**.

Add the following entry to your values.yaml file:
concourse:
  requiredNodeType: concourse

Taint and label **two** dedicated nodes for the Concourse workers:
```
kubectl taint node <dedicated-node-name> type=concourse:PreferNoSchedule
kubectl label node <dedicated-node-name> type=concourse
```

### Run the Installer

From this directory in the repo, execute:

```
kubectl create namespace concourse
./install-concourse.sh /path/to/my/values.yaml
```

After the installation, create a project named "concourse" in the Harbor registry and follow the instructions [here](https://github.com/doddatpivotal/concourse-helper) to build and push the concourse-helper container image with a tag harbor.<your-ingress-domain>/concourse/concourse-helper. As an alternative you can pull the image via `docker pull harbor-repo.vmware.com/tsl-end2end/concourse/concourse-helper`.
