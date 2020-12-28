# Configuring the Environment Values File

Make a copy of the [values-example.yaml](../../values-example.yaml) file, and customize it for the cluster you will be installing the e2e workshop into. You will use this values file as an input to all subsequent install processes.

**concourse.username**<br>
**concourse.password**<br>
Set these values to the login credentials for your Concourse server. This user will be a member of the main team.

**harbor.username**<br>
**harbor.password**<br>
Set these values to the login credentials for your Harbor environment. This will be the admin user.<br>
**harbor.diskSize**<br>
Set to the size of the PersistentVolumeClaim for the volume that will store your Harbor images.

**psp.cluster_role**<br>
Edukates must run on a cluster where the PodSecurityPolicy admission controller is enabled. If your cluster is already configured so that authenticated users will be able to deploy software into new namespaces, you can leave this blank. Otherwise, set the value to the ClusterRole should be assigned to installers when deploying new software. As you run each installer, all authenticated users in the new namespace will be bound to the ClusterRole, and get the permissions it needs to do things like run pods.

**git.account**<br>
**git.branch**<br>
If you are installing the latest release of the E2E workshop, you can leave this blank. If you want to run a different release (for example, you have forked the workshop to create a customized version), update these values to point to the Git repo for the release you are running.