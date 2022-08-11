# Ampernetacle

This is a Terraform configuration setup for deploying machines
[Oracle Cloud Infrastructure][oci]. It can create one or a few virtual machines.

Inside the `variables.tf` file you can decide how many machines you want, and what the shape of each one is.
NOTE: You have 4 OCPUs and 24 GB of RAM to spread across your Oracle Cloud machines.

**It is not meant to run production workloads,**
But it's great if you want to learn a little more about Terraform and how to create machines in OCI and all its dependencies.
Remembering that we are only on the free level!

## Getting started

1. Create an Oracle Cloud Infrastructure account (just follow [this link][createaccount]).
2. Have installed or [install kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl).
3. Have installed or [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/oci-get-started).
4. Have installed or [install OCI CLI ](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm).
5. Configure [OCI credentials](https://learn.hashicorp.com/tutorials/terraform/oci-build?in=terraform/oci-get-started).
6. Download this project and enter its folder.
7. `terraform init`
8. `terraform apply`

That's it!

You can also log into the VMs. At the end of the Terraform output
you should see a command that you can use to SSH into the first VM
(just copy-paste the command).

## Customization

Check `variables.tf` for adjustable parameters. You can change the number of machines, the shape of the machines or switch to Intel/AMD instances if you want.
Keep in mind that if you switch to Intel/AMD instances, you will not take advantage of the free tier.

## Destroying the project

If you want or need to destroy the project, just run the command: `terraform destroy`
Then confirm the destruction. Terraform will show you everything that will be destroyed. This is AMAZING.
## Possible errors and how to address them

### Authentication problem

If you configured OCI authentication using a session token
(with `oci session authenticate`), please note that this token
is valid 1 hour by default. If you authenticate, then wait more
than 1 hour, then try to `terraform apply`, you will get
authentication errors.

#### Symptom

The following message:

```
 Error: 401-NotAuthenticated
│ Service: Identity Compartment
│ Error Message: The required information to complete authentication was not provided or was incorrect.
│ OPC request ID: [...]
│ Suggestion: Please retry or contact support for help with service: Identity Compartment
```

#### Solution

Authenticate or re-authenticate, for instance with
`oci session authenticate`.

### Capacity issue

#### Symptom

If you get a message like the following one:
```
Error: 500-InternalError
│ ...
│ Service: Core Instance
│ Error Message: Out of host capacity.
```

It means that there isn't enough servers available at the moment
on OCI to create the cluster.

#### Solution

One solution is to switch to a different *availability domain*.
This can be done by changing the `availability_domain` input variable. (Thanks @uknbr for the contribution!)

Note 1: some regions have only one availability domain. In that
case you cannot change the availability domain.

Note 2: OCI accounts (especially free accounts) are tied to a
single region, so if you get that problem and cannot change the
availability domain, you can [create another account][createaccount].

### Using the wrong region

#### Symptom

When doing `terraform apply`, you get this message:

```
oci_identity_compartment._: Creating...
╷
│ Error: 404-NotAuthorizedOrNotFound
│ Service: Identity Compartment
│ Error Message: Authorization failed or requested resource not found
│ OPC request ID: [...]
│ Suggestion: Either the resource has been deleted or service Identity Compartment need policy to access this resource. Policy reference: https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm
│
│
│   with oci_identity_compartment._,
│   on main.tf line 1, in resource "oci_identity_compartment" "_":
│    1: resource "oci_identity_compartment" "_" {
│
╵
```

#### Solution

Edit `~/.oci/config` and change the `region=` line to put the correct region.

To know what's the correct region, you can try to log in to
https://cloud.oracle.com/ with your account; after logging in,
you should be redirected to an URL that looks like
https://cloud.oracle.com/?region=us-ashburn-1 and in that
example the region is `us-ashburn-1`.


