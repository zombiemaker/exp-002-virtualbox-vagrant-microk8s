# Or Red Hat public container image registry (registry.access.redhat.com)
FROM registry.access.redhat.com/ubi8/ubi:8.4

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=me
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

USER root
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && yum update -y \
    && yum upgrade -y \
    && yum install -y \
        sudo \
    && yum clean all \
    && echo $USERNAME ALL=\(ALL\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
