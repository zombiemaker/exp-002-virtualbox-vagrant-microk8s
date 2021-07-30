# Copying kubectl config for cluster to user .kube directory
$env:cpath=(pwd)
$env:cdir=(get-item .).name
$env:kubeconfig=$home + "\.kube\" + $env:cdir + "-config"

# Start VM landscape
cd ..\..\src\
vagrant --config-file=$env:cpath\k8s-deployment-config.yaml destroy
cd $env:cpath