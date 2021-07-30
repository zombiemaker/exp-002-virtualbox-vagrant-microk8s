# Copying kubectl config for cluster to user .kube directory
& "$PSScriptRoot\env.ps1"

$env:kubeconfig=$home + "\.kube\" + $env:cdir + "-config"

# Start VM landscape
cd ..\..\src\
vagrant --config-file=$env:cpath\k8s-deployment-config.yaml validate

# Copying kubectl config for cluster to user .kube directory
cp .runtime\kubectl-config $env:kubeconfig
cd $env:cpath