# cyverse-matlab-mcr-docker
This is a cyverse curated Dockerfile to build matlab images. Branches in this repo represents supported MCR versions. Master is currently R2109a.

To build your own custom matlab mcr image: checkout master, edit the Dockerfile, and build with the following args:

```
docker build -t cyverse-matlab-mcr-docker .
```
Information about Matlab MCR can be found here:

https://www.mathworks.com/products/compiler/matlab-runtime.html
