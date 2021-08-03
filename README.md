# Multi-Region & Multi-Cluster Kubernetes Landscape Deployment Using VirtualBox + Vagrant + Ubuntu + MicroK8s

The goal of this setup is to mimic creating a Kubernetes landscape for an internet application system.

It allows software engineers, devops process engineers, and application system engineers to experiment with a fuller representation of how major pieces work together to deliver internet applications to the world.


## Usage

The configuration file is located at src/config.yaml.  Alter it to suite your preferences.

You can start Vagrant manually or use the scripts provided in the scripts directory.  See [basic commands](docs/basic-commands.md) for a sample list of actions that can be performed on the landscape.


## Host Machine Requirements

It is assumed that the host machine is using Microsoft Windows 10 Pro.  The HashiCorp Vagrant programs might work fine on Linux or MacOS machines.  However, they have not been tested to confirm that this is the case.

For hardware requirements, the amount of CPU cores and RAM will determine how large of a landscape you can create.  You will have to review your computer's available resources and the configuration for your Kubernetes cluster landscape.

At a minimum, install the following software components on the host OS:

* Docker Desktop for Windows (kubectl for Windows is included)
* Oracle VirtualBox 6.1.22
* HashiCorp Vagrant 2.2.17
* Vagrant Plugin (i.e. RubyGem) json_schemer

Make sure that the host OS search path environment variable is configured to find the kubectl, VirtualBox, and Vagrant programs.  You might have to restart or re-login to the machine to make the changes active.

To install the Vagrant plugin, execute the following in PowerShell:
```
vagrant plugin install 'json_schemer'
```

See [the description of the environment where this has been tested](docs/environment-tested.md). 


## Landscape Components Types

Implemented:
* Multi-region, multi Kubernetes cluster deployment

Planned to be implemented:
* K8s cluster for GitOps application systems
  * Apache Kafka (Kubernetes Operator)
  * ArgoCD (Kubernetes Operator)
  * GitHub Actions Runners
    * Linux runners
    * Microsoft Windows runners
* K8s cluster for product application systems
* External K8s cluster services
  * K8s cluster external tcp/upd load balancer (HAproxy, NGINX) with virtual IPs to K8s API server
    * [Keepalived](https://keepalived.readthedocs.io/en/latest/index.html)
  * K8s cluster external BGP router load balancer for applications running on the K8s cluster services
  * K8s cluster external DNS resource provider
  * K8s cluster external TLS CA certificate resource provider
  * K8s external load balancer K8s resource provider operator (MetaLB)
  * K8s external DNS record K8s resource provider operator
  * K8s external TLS certificate resource provider operator
  * Traffic manager DNS service 
  * Internet firewall
  * Internet CDN service
  * Virtual Kubelet
* K8s-hosted application system components
  * TCP / UDP ingress controller

## Running Ruby Tests

To run the Ruby test programs, you need to have Ruby installed.  This project uses Visual Studio Code devcontainer features to run inside a WSL2 Docker Linux container.  If you have that configured, simply use Visual Studio Code to switch start in a container.


## Issues

Report issues [here](https://github.com/zombiemaker/exp-002-virtualbox-vagrant-microk8s/issues)