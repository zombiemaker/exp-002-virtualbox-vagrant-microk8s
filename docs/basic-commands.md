# Basic Commands

## Create landscape using PowerShell script

* From PowerShell
    ```
    scripts\up.ps1
    ```

## Destroy landscape using PowerShell script

* From PowerShell
    ```
    scripts\down.ps1
    ```

## Create landscape without PowerShell script

* From PowerShell
    ```
    cd src
    vagrant up
    ```

## Halt landscape without destroying VMs without PowerShell script

* From PowerShell
    ```
    cd src
    vagrant halt
    ```

## Destroy landscape without PowerShell script

* From PowerShell
    ```
    cd src
    vagrant destroy -f
    ```

## Landscape status

* From PowerShell
    ```
    cd src
    vagrant status

    Current machine states:

    k8s-r1-c1-m1              running (virtualbox)
    k8s-r1-c1-m2              running (virtualbox)
    ```

## SSH into VM using vagrant ssh

* This example uses the VM k8s-r1-c1-m1
* From PowerShell
    ```
    cd src
    vagrant ssh k8s-r1-c1-m1
    ```

## SSH into VM using Windows OpenSSH

* This example uses the VM k8s-r1-c1-m1
* Default username / password : vagrant / vagrant
* From PowerShell
    ```
    ssh vagrant@k8s-r1-c1-m1
    ```

## SSH remote command to get MicroK8s status 

* This example uses the VM k8s-r1-c1-m1
* From PowerShell
    ```
    cd src
    vagrant ssh -c "microk8s status" k8s-r1-c1-m1
    ```

## SSH remote command to get Kubernetes cluster info

* This example uses the VM k8s-r1-c1-m1
* From PowerShell
    ```
    cd src

    vagrant ssh -c "kubectl cluster-info" k8s-r1-c1-m1

    Kubernetes control plane is running at https://10.1.1.6:16443

    To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
    Connection to 127.0.0.1 closed.
    ```
    ping 

## SSH remote command to Kubernetes cluster connection configuration
* This example uses the VM k8s-r1-c1-m1
* From PowerShell
    ```
    cd src

    vagrant ssh -c "microk8s config" k8s-r1-c1-m1     
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUREekNDQWZlZ0F3SUJBZ0lVR1VUYjVGTmJIeWZBQll0MzR2bFZHM1JndVYwd0RRWUpLb1pJaHZjTkFRRUwKQlFBd0Z6RVZNQk1HQTFVRUFFlrUXRHUVVJbVJDd09RelpBUkNEdwp2R3dLZEdjbGhwb2RRMGl6VlJMUnRsMG5IR0paVkFvZXFpazdtY3ZITDkwTG16VUp5RlRMdHF4MndNN09NU2t1CklQbGMxSzdPUU81bzhEMHIyUjZTaWNVMkE3bzlVU2REZmVmdHB3YVVCODhGQTVTSC9EeENERzNycnVjcVRWTDgKZVJQOFUyRmFGR0FNN21ielhtWWdVb1BORyt6K1pSemNYZ3RtWnpTdE9KSlVKZHZsQkprS1VBYnhGK253NE9UTQpBajVoalg0K3VyenpYCkJJVjRRZXhLK3B5b0R5c1p5VmJKNTdvaUR4U20xSlAvazlZMzRXS29rUEhNclBpT3JET0QxOVhZWEJ4c1lZb2kKdmY0dm1MbDhWdXpEaFM3bVZFTThoS3EyeGc9PQotLS0tLUXNFAvbk1UZksxaU1jTllmaiswc2dXQm5sK2JzT01ZdUMraXczcVB2bndWQjhMUUlEQVFBQm8xTXdVVEFkCkJnTlZIUTRFRmdRVWdYK1c5T3dmMzNjVGtpOWEwWlczUzRHUk40OHdId1lEVlIwaklHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFyZVNTNlZGVmRVdEx5NTYzK3VBZ3F4ZnlkZHN0VFloQW13cCsKc0ZCZTRPMjZja3ljOGU0VHdtcXJCanJMWi9QMXo2SDNzMG03cURXTEg4aJCZ3dGb0FVZ1grVzlPd2YKMzNjVGtpOWEwWlczUzRHUk40OHdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QU5CZ2txaGtpRzl3MEJBUXNGQUFPQwpBUUVBWXhhVUNHcXNDc1BQckJUZGluUU4wMjNUOTI3aW81WDhNUTc3Q01DanlXL01WcUNDNXFlRXVKQk50YXNNCitQV3pRUDlCZ21QaUp3SllqTXJCS2p5bzhBSW1FNkZQSUEvR09SMFNlM1Y4OVl1TGt5eEl0WTBkYnQ4Q0VGT1oKODJJS3ZqaVROMEdWczRWVlg1Yk05Z0ZvYVJvbDZNeEZyOVNxaG1wS1RhN0VKVTUzYlBiOXAwbW9xcGNyZTVSUApqaDR0cUlHM3N1Wnpjc1EydDloWHlWaE55UVA5WlNxc0xhYkZVTVpJVHBTYUxwc1M4QzdaZXZVORCBDRVJUSUZJQ0FURS0tLS0tCg==
        server: https://10.0.2.15:16443
    name: microk8s-cluster
    contexts:
    - context:
        cluster: microk8s-cluster
        user: admin
    name: microk8s
    current-context: microk8s
    kind: Config
    preferences: {}
    users:
    - name: admin
    user:
        token: ZExoZnIxK3paasdfasdfdfdfdswereiY0c4VVpZWEdOVWF6OD0K
    ```
* Save the response to a file in [your Windows user home directory]\.kube (default Kubernetes cluster should be saved in a file named "config")
* Edit the "server: https://[ip address]:16443" in the file to use the IP address of the VM (e.g., 10.1.1.6).  MicroK8s configures Kubernetes to use the IP address of the network adapter that has the default route, which in this case, the adapter connected to VirtualBox NAT.