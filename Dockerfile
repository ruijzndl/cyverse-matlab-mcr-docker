FROM debian:buster

ARG MATLAB_MCR_URL=http://ssd.mathworks.com/supportfiles/downloads/R2019a/Release/0/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019a_glnxa64.zip
ARG MATLAB_LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Runtime/v96/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v96/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v96/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v96/extern/bin/glnxa64

ARG MCR_DEPS="dh-autoreconf libcurl4-gnutls-dev libexpat1-dev asciidoc xmlto docbook2x install-info gettext libz-dev libssl-dev bash git unzip wget libx11-6 libxt6 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxft2 libxi6 libxrandr2 libxrender1 libxtst6 libxxf86vm1 cairo-5c libfontconfig1 libasound2 libatk1.0-0 libatk1.0-dev libcups2-dev libgconf2-dev libgtk2.0-0 libgdk-pixbuf2.0-0 gstreamer1.0-alsa gstreamer1.0-plugins-base libpango-1.0-0 libsndfile1 libxcb1 libxslt1.1 libxss1"
ARG GIT_DEPS="install-info asciidoc xmlto docbook2x dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev"

# update apt
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install ${MCR_DEPS} && \
    rm -rf /var/lib/apt/lists/*

# construct the mcr install directory
RUN mkdir /opt/mcr_install
WORKDIR /opt/mcr_install

# extract and install mcr
RUN wget -q -O MCR_installer.zip ${MATLAB_MCR_URL} && \
    unzip MCR_installer.zip && \
    ./install -mode silent -agreeToLicense yes -outputFile /opt/mcr_install.log && \
    rm -rf /opt/mcr_install /tmp/mathworks*

# Download, build and install git 2.22.4
RUN mkdir /tmp/git
WORKDIR /tmp/git
RUN wget https://github.com/git/git/archive/v2.22.4.tar.gz && \
   tar xvfz v2.22.4.tar.gz && \
    cd git-2.22.4 && \
    make configure && \
    ./configure --prefix=/usr && \
    make -j 4 all  && \
    make -j 4 install && \
    cd .. && rm -rf git*

# Uninstall git 2.22.4 build dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get -y remove ${GIT_DEPS}

ENV LD_LIBRARY_PATH=${MATLAB_LD_LIBRARY_PATH}
RUN echo "export LD_LIBRARY_PATH=\"${MATLAB_LD_LIBRARY_PATH}\"" >/etc/profile.d/matlab.sh && chmod a+x /etc/profile.d/matlab.sh

WORKDIR /
