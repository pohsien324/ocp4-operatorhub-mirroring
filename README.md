# ocp4-operatorhub-mirroring
These scripts simplify the process of OperatorHub Image mirroring for OpenShif 4.X environment.

For OpenShift 4.X, If you want to use OperatorHub in the restricted network environment. You must download the Operator images and bring them to your OpenShift environment, then push them to your private registry. These scripts will simplify the steps of this mirroring process.


## How to Use
1. Make sure you already dump the OperatorHub catalog manifest (called `mapping.txt`). Filter the list to remain the Images you want to mirror.
```bash
$ cat mapping.txt | egrep '(logging|elastic|proxy|...)' >> origin.txt
```

2.  Edit the `convert.sh` script. Modify the Private Registry URL.
```bash
$ vim convert.sh
```
```bash
#!/bin/bash
PRIVATE_REGISTRY="private-registry.example.com"
#------------------------
...
```

3. Execute `convert.sh`. It will create two files:
* `auto_redhat_to_file.txt`: The mapping file for mirror image from external registry to local.
* `auto_file_to_private.txt`: The mapping for mirror image from local to private registry.

```bash
$ bash convert.sh
```
4. Optional: If your private registry will not create the project automatically. You need to create them before mirroring them.

Modify `get-project-name.sh`.
```bash
$ vim get-project-name.sh
```
```bash
PRIVATE_REGISTRY="private-registry.example.com"
```
Get the project list of Image.
```bash
$ bash get-project-name.sh
```

5. Mirror the Image.

From external registry to local:
```bash
$ oc image mirror -a ${REG_CREDS} -f auto_redhat_to_file.txt --filter-by-os=".*"
```
From local to private registry:
```bash
$ oc image mirror -a ${REG_CREDS} -f auto_file_to_private.txt --filter-by-os=".*"
```

## Reference
* [Using Operator Lifecycle Manager on restricted networks](https://docs.openshift.com/container-platform/4.6/operators/admin/olm-restricted-networks.html#olm-creating-catalog-from-index_olm-restricted-networks)




