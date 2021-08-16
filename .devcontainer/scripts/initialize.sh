#!/bin/bash
# This script is executed by Visual Studio Code BEFORE the container is created

echo "====================================================================="
echo "Executing initializeCommand script"
echo "====================================================================="

if [ ! -d containerfs ]; 
then 
    mkdir -p containerfs;
fi

cp .devcontainer/.bashrc containerfs/.bashrc