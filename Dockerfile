# Docker container for the Raspberry Pi development with Python 3 and the
# modern libgpiod-based interface to hardware IO.
# Author: Tony DiCola
FROM resin/rpi-raspbian:stretch

# Informative labels.
LABEL description="Docker container for the Raspberry Pi development with Python 3 and the modern libgpiod-based interface to hardware IO."
LABEL maintainer="tony@tonydicola.com"

# Install dependencies.
RUN apt-get update && apt-get install -y \
   autoconf \
   autoconf-archive \
   automake \
   build-essential \
   git \
   libtool \
   pkg-config \
   python3 \
   python3-dev \
   python3-setuptools \
   raspberrypi-kernel-headers \
   swig3.0 \
   wget

# Install libgpiod
WORKDIR /opt/
RUN git clone -b v1.0.x git://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git
WORKDIR /opt/libgpiod/
RUN ./autogen.sh --enable-tools=yes --prefix=/usr/local/ \
   && make \
   && make install \
   && ldconfig

# Install libgpiod-python wrapper using SWIG to generate code.
WORKDIR /opt/
RUN git clone https://github.com/tdicola/libgpiod-python.git
WORKDIR /opt/libgpiod-python/
RUN swig3.0 -python -I/usr/local/include libgpiod.i \
    && python3 setup.py build_ext \
    && python3 setup.py install

# Clean up apt cache.
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
