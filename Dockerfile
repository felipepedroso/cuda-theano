# Start with cuDNN base image
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# Install git, wget, python-dev, pip, BLAS + LAPACK and other dependencies
RUN apt-get update && apt-get install -y \
  git \
  wget

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.27-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]

RUN conda install -y \
  numpy \
  scipy \
  mkl \
  nose \
  sphinx \
  pydot-ng \
  pip

RUN pip install --upgrade pip

ENV LD_LIBRARY_PATH /lib:/lib64

ENV CUDA_ROOT /usr/local/cuda/bin

RUN conda install -y \
  theano \
  pygpu
