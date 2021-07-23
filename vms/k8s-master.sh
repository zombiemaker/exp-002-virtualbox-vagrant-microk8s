echo "Configuring $(hostname)"
echo "master_node_m1_vm_ipv4_address = $1"

# Update and upgrade apt packages
sudo apt update && apt upgrade -y

# Update snap packages
sudo snap refresh

# Install MicroK8s snap package
sudo snap install microk8s --classic
sudo usermod -a -G microk8s vagrant

# Check if MicroK8s is running - wait until process is ready
microk8s status --wait-ready
microk8s kubectl cluster-info

# If not main master, join main master
if [ "$(hostname)" = "k8s-r1-c1-m1" ] 
then
    echo "This node is the main master node"
else
    echo "This node is NOT the main master node"
fi
