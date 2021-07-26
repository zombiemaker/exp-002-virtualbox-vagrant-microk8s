# Multi-Region & Multi-Cluster Kubernetes Landscape Deployment Using VirtualBox + Vagrant + Ubuntu + MicroK8s

The goal of this setup is to mimic creating a Kubernetes landscape for an internet application system.

It allows software engineers, devops process engineers, and application system engineers to experiment with a fuller representation of how major pieces work together to deliver internet applications to the world.

## Landscape Components Types

Implemented:

* Multi-region, multi Kubernetes cluster deployment


TODOs:

* K8s cluster for GitOps application systems
  * Apache Kafka (Kubernetes Operator)
  * ArgoCD (Kubernetes Operator)
  * GitHub Actions Runners
    * Linux runners
    * Microsoft Windows runners
* K8s cluster for product application systems
* External K8s cluster services
  * K8s cluster external load balancer resource service provider
  * K8s cluster external DNS resource service provider
  * K8s cluster external TLS CA certificate resource service provider
  * Traffic manager DNS service 
  * Internet firewall
  * Internet CDN service
  * Virtual Kubelet


## Host Machine Requirements

It is assumed that the host machine is using Microsoft Windows 10 Pro.  The HashiCorp Vagrant programs might work fine on Linux or MacOS machines.  However, they have not been tested to confirm that this is the case.

At a minimum, install the following software components on the host OS:

* Docker Desktop for Windows (kubectl for Windows is included)
* Oracle VirtualBox 6.1.22
* HashiCorp Vagrant 2.2.17

Make sure that the host OS search path environment variable is configured to find the kubectl, VirtualBox, and Vagrant programs.  You might have to restart ore re-login to the machine to make the changes active.

See [the description of the environment where this has been tested](docs/environment-tested.md). 

## Usage

The configuration file is located at src/config.yaml.  Alter it to suite your preferences.

You can start Vagrant manually or use the scripts provided in the scripts directory.

## Issues

Report issues [here](https://github.com/zombiemaker/exp-002-virtualbox-vagrant-microk8s/issues)