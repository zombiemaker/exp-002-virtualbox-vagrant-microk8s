$env:cpath=(pwd)
$env:cdir=(get-item .).name
$env:vagrantfile_relative_path="..\..\src"
$env:configuration_schema_file="..\..\schemas\k8s-cluster-landscape-deployment-schema-v0.1.0.json"