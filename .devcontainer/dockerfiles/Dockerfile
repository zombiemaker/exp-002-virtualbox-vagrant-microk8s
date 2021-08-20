FROM library/ruby:3.0.2-buster

USER root

RUN useradd -ms /bin/bash me \
    && usermod -aG sudo me

USER me
WORKDIR /home/me

# Install Ruby gems as user
RUN gem install json_schemer \
    && gem install rspec