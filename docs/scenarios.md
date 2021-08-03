# Scenarios

| Scenario # | # Regions | # Non-Managed K8s Clusters | NMC # Master-Worker Nodes | NMC # Master Nodes | NMC # Worker Nodes | # Managed K8s Clusters | MC # Master-Worker Nodes | MC # Master Nodes | MC # Worker Nodes | # ELBs | # EDNSs | # TLS CAs | Cluster Auto Scaling |
| ---- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | - |
| 1a | 1 | 1 | | | | | | | | | | | |
| 1b | 1 | 1 | | | | | | | | | | | |

## K8s Cluster Components

K8s Cluster
* K8s Datastore (i.e. etcd) Nodes
* K8s Master Nodes
  * K8s API Server
  * K8s Scheduler
  * K8s Controller Manager
* K8s Worker Nodes

K8s Apps
* [LENS](https://k8slens.dev/)