#!/usr/bin/env bash
# Install Headlamp using in-cluster deployment method using Helm charts

set -euo pipefail
set -x

HEADLAMP_VERSION="0.39.0"
NAMESPACE="k8s-tools"
RELEASE_NAME="headlamp"
SCRIPT_DIR="$(dirname "$0")"

# Ensure namespace exists (Helm won't create it unless --create-namespace is used)
kubectl get namespace "${NAMESPACE}" >/dev/null 2>&1 || kubectl create namespace "${NAMESPACE}"

# Apply custom read-only ClusterRole
kubectl apply -f "${SCRIPT_DIR}/headlamp-readonly-clusterrole.yaml"

# Install via official helm repo chart.
# NOTE: The local ./Tools/HeadLamp folder is missing a templates/ directory, so it renders no resources.
helm repo add headlamp https://kubernetes-sigs.github.io/headlamp/
helm repo update

helm upgrade --install "${RELEASE_NAME}" headlamp/headlamp \
  --namespace "${NAMESPACE}" \
  --version "${HEADLAMP_VERSION}" \
  --values "${SCRIPT_DIR}/values.yaml" \
  --wait

# Quick sanity checks
helm status "${RELEASE_NAME}" --namespace "${NAMESPACE}"
kubectl get all -n "${NAMESPACE}" -l app.kubernetes.io/instance="${RELEASE_NAME}" || true