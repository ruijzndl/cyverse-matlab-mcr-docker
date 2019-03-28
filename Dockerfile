FROM debian:stretch

ARG MATLAB_MCR_URL
ARG MATLAB_LD_LIBRARY_PATH

# update apt
RUN apt-get update && apt-get upgrade && \
    apt-get --no-install-recommends -y install bash unzip wget && \
    rm -rf /var/lib/apt/lists/*

# construct the mcr install directory
RUN mkdir /opt/mcr_install
WORKDIR /opt/mcr_install

ENV LD_LIBRARY_PATH=${MATLAB_LD_LIBRARY_PATH}

WORKDIR /
