# Copying kubectl config for cluster to user .kube directory
$env:cpath=(pwd)
$env:cdir=(get-item .).name
$env:kubeconfig=$home + "\.kube\" + $env:cdir + "-config"

# Start VM landscape
cd ..\..\src\
vagrant --config-file=$env:cpath\k8s-deployment-config.yaml up

# Copying kubectl config for cluster to user .kube directory
cp .runtime\kubectl-config $env:kubeconfig

# Creating a PowerShell alias to kubectl with config file
Function kctl { kubectl --kubeconfig=$env:kubeconfig $args }
set-alias -name "kctl-$env:cdir" -value kctl
& kctl-$env:cdir cluster-info

cd $env:cpath