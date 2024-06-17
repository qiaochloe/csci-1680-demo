FROM ubuntu:jammy

LABEL org.opencontainers.image.source=https://github.com/brown-csci1680/container-dev

# set environment variables for tzdata
ARG TZ=America/New_York
ENV TZ=${TZ}

# include manual pages and documentation
ARG DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8

COPY container-setup-amd64.sh /usr/local/bin/container-setup-amd64
COPY container-setup-common.sh /usr/local/bin/container-setup-common
COPY entrypoint.sh /usr/local/bin/container-entrypoint
COPY .image-version /etc/image-version

RUN /usr/local/bin/container-setup-amd64

# Add configuration for XPRA (required for graphical support only, must happen after setup script)
COPY ./xpra.conf /etc/xpra/xpra.conf

# git build arguments
ARG USER=cs1680\ User
ARG EMAIL=nobody@example.com

# configure your environment
USER cs1680-user
RUN rm -f ~/.bash_logout

ENTRYPOINT ["container-entrypoint"]

WORKDIR /home/cs1680
CMD ["/bin/bash", "-l"]
