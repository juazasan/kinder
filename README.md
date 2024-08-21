# Summary

This project automates the setup of a local Kubernetes cluster with a local Docker registry and NGINX Gateway Fabric.

The cluster consists of one control-plane node and three worker nodes.

The control-plane node has additional configurations:

- Kubeadm Configuration Patches: Customizes the kubeadm initialization configuration, including setting node labels (ingress-ready=true) and extra arguments for the kubelet.
- Port Mappings: Maps container ports to host ports for TCP traffic, allowing services running inside the cluster to be accessible from the host machine on ports 8080 and 8443.

The Makefile provides convenient targets to install dependencies, bring up the cluster, and tear it down.

The shell scripts handle the configuration of the local registry and its integration with the kind cluster.

If you have any specific questions or need further details, feel free to ask!

# Key Components

## Makefile

Provides commands to manage the lifecycle of the kind cluster and the local registry.

Makefile Targets:

- **install**: Installs the cloud-provider-kind Go package. Runs install-registry.sh to set up the local Docker registry.
- **up**: Creates the kind cluster using the configuration in kinder.yaml. Runs add-registry.sh to configure the cluster to use the local- Applies NGINX Gateway Fabric CRDs using kubectl kustomize. Installs NGINX Gateway Fabric using Helm with the configuration in values.yaml.
- **delete**: Deletes the kind cluster named kinder.


## kinder.yaml

Defines the configuration for the kind cluster, including control-plane and worker nodes.

## add-registry.sh:

- Configures each node in the kind cluster to recognize a local Docker registry (kinder-registry) running on port 5001.
- Connects the registry to the kind network if it's not already connected.
- Creates a Kubernetes ConfigMap to inform the cluster about the local registry.

## install-registry.sh:

- Ensures that a Docker registry container named kinder-registry is running on port 5001.
- If the registry is not running, it starts a new container with the registry.

