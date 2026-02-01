# headlamp
Kubernetes Dashboard UI

Headlamp is an open-source web-based user interface for managing Kubernetes clusters. It provides a user-friendly way to visualize and interact with your Kubernetes resources.

## Helm installation

To install Headlamp using Helm, you can use the following command:

```bash
helm repo add headlamp https://headlamp-k8s.github.io/helm-charts
helm repo update
helm install headlamp headlamp/headlamp
```

This will install Headlamp in your Kubernetes cluster. You can then access the Headlamp UI by port-forwarding the service:

```bash
kubectl port-forward svc/headlamp 8080:80
```

Then, open your web browser and navigate to `http://localhost:8080` to access the Headlamp UI.

## Install via script
You can also install Headlamp using the installation script provided in the repository. Run the following command:

```bash
sh install-headlamp.sh
```

This script will deploy Headlamp to your Kubernetes cluster.

## ClusterRole
To grant Headlamp the necessary permissions to manage your Kubernetes resources, you may need to create a ClusterRole and ClusterRoleBinding. You can use the following YAML manifest as an example:
Refer to the `headlamp-readonly-clusterrole.yaml` file in the repository for the complete RBAC configuration.

## Maintainers
- [Venu Madhav Palugula](info.venkube@gmail.com)
