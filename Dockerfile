FROM debian:stretch

ARG MATLAB_MCR_URL=http://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/MCR_R2017b_glnxa64_installer.zip
ARG MATLAB_LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Runtime/v93/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v93/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v93/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v93/sys/opengl/lib/glnxa64

ARG MCR_DEPS="bash unzip wget libx11-6 libxt6 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxft2 libxi6 libxrandr2 libxrender1 libxtst6 libxxf86vm1 cairo-5c libfontconfig1 libasound2 libatk1.0-0 libatk1.0-dev libcups2-dev libgconf2-dev libgtk2.0-0 libgdk-pixbuf2.0-0 libgnome-vfs2.0-cil-dev gstreamer1.0-alsa gstreamer1.0-plugins-base libpango-1.0-0 libsndfile1 libxcb1 libxslt1.1 libxss1"

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


RUN echo "" > /etc/ld.so.conf.d/zzmatlab.conf && \
    for i in $(echo $MATLAB_LD_LIBRARY_PATH|tr ':' '\n'); do echo $i >>/etc/ld.so.conf.d/zzmatlab.conf; done && \
    /sbin/ldconfig
#RUN echo "export LD_LIBRARY_PATH=\"${MATLAB_LD_LIBRARY_PATH}\"" >/etc/profile.d/matlab.sh && chmod a+x /etc/profile.d/matlab.sh

WORKDIR /
