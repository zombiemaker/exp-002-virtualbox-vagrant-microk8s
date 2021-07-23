# Multi-Region & Multi-Cluster Kubernetes Landscape Deployment Using VirtualBox + Vagrant + Ubuntu + MicroK8s

The goal of this setup is to mimic creating a Kubernetes landscape for an internet application system.

It allows software engineers, devops process engineers, and application system engineers to experiment with a fuller representation of how major pieces work together to deliver internet applications to the world.

Components types include:

* Internet traffic manager DNS service 
* Internet CDN service
* Internet firewall
* External Kubernetes cluster load balancers to balance traffic across Kubernetes API servers and worker nodes
* External Kubernetes cluster DNS servers