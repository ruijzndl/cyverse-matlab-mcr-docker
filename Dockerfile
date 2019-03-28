FROM debian:stretch

ARG MATLAB_MCR_URL=http://ssd.mathworks.com/supportfiles/downloads/R2019a/Release/0/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019a_glnxa64.zip
ARG MATLAB_LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Runtime/v96/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v96/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v96/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v96/extern/bin/glnxa64

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
