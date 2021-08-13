FROM docker.io/library/ubuntu:20.04

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=me
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

USER root
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN DEBIAN_FRONTEND="noninteractive" \
    apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y sudo \
    && apt-get clean all \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \
        git \
        less \
        curl \
        procps \
        unzip \
        openssh-client \
    && apt-get clean all

# Network diagnostic tools
RUN DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \    
        iproute2 \
        net-tools \
        iputils-arping \
        iputils-ping \
        iputils-tracepath \
        inetutils-traceroute \
        # Make sure you run docker command with "--cap-add=NET_RAW --cap-add=NET_ADMIN" parameters
        tshark \
    && apt-get clean all \
    # Configuring tshark for non-root user access
    && yes yes | DEBIAN_FRONTEND=teletype dpkg-reconfigure wireshark-common \
    && usermod -a -G wireshark me

USER ${USERNAME}