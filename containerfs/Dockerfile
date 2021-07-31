FROM ruby/3.0.2-buster

USER root

RUN useradd -ms /bin/bash me \
    && usermod -aG sudo me


USER me
WORKDIR /home/me