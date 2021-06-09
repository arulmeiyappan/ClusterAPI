#!/bin/bash

set -e

DOCKER_VERSION="20.10.6"
KIND_VERSION="v0.11.1"
CLUSTERCTL_VERSION="v0.3.17"
KUBECTL_VERSION="1.21"

install_kind()
{
    wget https://github.com/kubernetes-sigs/kind/releases/download/$KIND_VERSION/kind-linux-amd64
    chmod +x kind-linux-amd64
    mv kind-linux-amd64 /usr/local/bin/kind
    echo "kind installed succcessfully"
}

install_clusterctl()
{
    wget https://github.com/kubernetes-sigs/cluster-api/releases/download/$CLUSTERCTL_VERSION/clusterctl-linux-amd64
    chmod +x clusterctl-linux-amd64
    mv clusterctl-linux-amd64 /usr/local/bin/clusterctl
    echo "clusterctl installed succcessfully"

}

install_kubectl()
{
    curl -LO https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    echo "kubectl installed succcessfully"
}

create_kind_cluster()
{
    echo "kind cluster creation started, please wait for couple of mintues to come up ..."
    kind create cluster
    echo "kind cluster created successfully"
}

initialize_clusterctl()
{
   clusterctl init --infrastructure=vsphere
   echo "clusterctl initialized successfully"

}

install_kind
install_clusterctl
install_kubectl
create_kind_cluster
initialize_clusterctl
