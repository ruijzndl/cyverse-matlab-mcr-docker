FROM debian

# update apk
RUN apt-get update && apt-get upgrade

# add bash
RUN apt-get --no-install-recommends -y install bash unzip wget curl

# construct the mcr install directory
RUN mkdir /opt/mcr_install
WORKDIR /opt/mcr_install

# extract and install mcr
RUN wget -q -O MCR_R2018b_glnxa64_installer.zip http://ssd.mathworks.com/supportfiles/downloads/R2018b/deployment_files/R2018b/installers/glnxa64/MCR_R2018b_glnxa64_installer.zip
RUN unzip MCR_R2018b_glnxa64_installer.zip
RUN ./install -mode silent -agreeToLicense yes -outputFile /opt/mcr_install.log

# clean up
RUN rm -rf /opt/mcr_install && rm -rf /tmp/mathworks* && rm -rf /var/lib/apt/lists/*
WORKDIR /
