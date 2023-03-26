#!/bin/sh

CSVER=2.31.0
CMDSTAN=/opt/cmdstan-$CSVER

# install opempi and GLPK (brms)
sudo pacman -S gfortran openmpi glpk

# download and extract cmdstan based on CSVER from github
curl -OL https://github.com/stan-dev/cmdstan/releases/download/v$CSVER/cmdstan-$CSVER.tar.gz \
    && tar xzf cmdstan-$CSVER.tar.gz \
    && rm -rf cmdstan-$CSVER.tar.gz 

# enable threading
echo "STAN_THREADS=true" >> "cmdstan-$CSVER"/make/local
echo "STAN_MPI=true" >> "cmdstan-$CSVER"/make/local
echo "CXX=mpicxx" >> "cmdstan-$CSVER"/make/local
echo "TBB_CXX_TYPE=gcc" >> "cmdstan-$CSVER"/make/local
echo "STAN_CPP_OPTIMS=true" >> "cmdstan-$CSVER"/make/local

# build cmdstan using 2 threads
cd cmdstan-$CSVER || exit \
    && make -j2 build examples/bernoulli/bernoulli

cd .. || exit
sudo mv "cmdstan-$CSVER" $CMDSTAN

# export cmdstan variable
echo "CMDSTAN=$CMDSTAN" | sudo tee -a /etc/environment.d/cmdstan.sh
