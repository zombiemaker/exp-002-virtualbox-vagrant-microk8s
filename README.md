# Multi-Region & Multi-Cluster Kubernetes Landscape Deployment Using VirtualBox + Vagrant + Ubuntu + MicroK8s

The goal of this setup is to mimic creating a Kubernetes landscape for an internet application system.

It allows software engineers, devops process engineers, and application system engineers to experiment with a fuller representation of how major pieces work together to deliver internet applications to the world.

## Landscape Components Types

Implemented:

* MicroK8s Kubernetes Cluster

WIP:

* External Kubernetes cluster load balancers to balance traffic across Kubernetes API servers and worker nodes
* External Kubernetes cluster DNS servers

TODOs:

* GitOps K8s Cluster
* Product Application K8s Cluster
* Apache Kafka (Kubernetes Operator)
* ArgoCD (Kubernetes Operator)
* Internet traffic manager DNS service 
* Internet firewall
* Internet CDN service