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

# extract and install mcr
RUN wget -q -O MCR_installer.zip ${MATLAB_MCR_URL} && \
    unzip MCR_installer.zip && \
    ./install -mode silent -agreeToLicense yes -outputFile /opt/mcr_install.log && \
    rm -rf /opt/mcr_install /tmp/mathworks*

ENV LD_LIBRARY_PATH=${MATLAB_LD_LIBRARY_PATH}

WORKDIR /
