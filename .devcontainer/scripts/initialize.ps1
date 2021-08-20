# This script is executed by Visual Studio Code BEFORE the container is created

echo "====================================================================="
echo "Executing initializeCommand script"
echo "====================================================================="

if (!(Test-Path -Path containerfs)) 
{ 
    New-Item -ItemType Directory -Force -Path containerfs
}

Copy-Item .devcontainer\.bashrc -Destination containerfs\.bashrc

# Write-Host -NoNewLine 'Press any key to continue...';
# $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');