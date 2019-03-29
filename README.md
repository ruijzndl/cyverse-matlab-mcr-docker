# cyverse-matlab-mcr-docker
This is a cyverse curated Dockerfile to build matlab images. Branches in this repo represents supported MCR versions. Master is currently R2109a.

To build your own custom matlab mcr image: checkout master, edit the Dockerfile, and build with the following args:

docker build --build-arg MATLAB_MCR_URL=MATLAB_MCR_URL=http://ssd.mathworks.com/supportfiles/downloads/R2018b/deployment_files/R2018b/installers/glnxa64/MCR_R2018b_glnxa64_installer.zip \
--build-arg MATLAB_LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Runtime/v95/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v95/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v95/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v95/extern/bin/glnxa64  -t cyverse-matlab-mcr-docker .

Information about Matlab MCR can be found here:

https://www.mathworks.com/products/compiler/matlab-runtime.html
