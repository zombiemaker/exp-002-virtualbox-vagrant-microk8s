FROM docker.io/library/fedora:34

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

RUN yum install -y \
        git \
        less \
        curl \
        procps \
        unzip \
        openssh-clients \
    && yum clean all

# Network diagnostic tools
RUN yum install -y \
        net-tools \
        traceroute \
        # Make sure you run docker command with "--cap-add=NET_RAW --cap-add=NET_ADMIN" parameters
        wireshark-cli \
    && yum clean all \
    && usermod -a -G wireshark me

USER ${USERNAME}