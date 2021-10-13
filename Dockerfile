ARG UBUNTU_VERSION="focal-20200729"
FROM ubuntu:${UBUNTU_VERSION}
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt -y install \
    git libtool pkg-config autoconf gettext \
    libpcap-dev g++ vim make cmake wget libssl-dev \
    liblzma-dev pip

RUN pip3 install pyyaml

RUN mkdir /work

RUN cd /work; git clone https://github.com/sentialabs/geneve-proxy

RUN cd /work && git clone https://github.com/snort3/libdaq.git
RUN cd /work/libdaq && ./bootstrap && ./configure && make && make install

RUN cd /work && wget https://github.com/ofalk/libdnet/archive/refs/tags/libdnet-1.14.tar.gz
RUN cd /work && tar -xvf libdnet-1.14.tar.gz && cd libdnet-libdnet-1.14 && ./configure && make && make install 
RUN cd /work && rm -rf libdnet-libdnet-1.14 && rm libdnet-1.14.tar.gz

RUN cd /work && wget https://github.com/westes/flex/files/981163/flex-2.6.4.tar.gz
RUN cd /work && tar -xvf flex-2.6.4.tar.gz && cd flex-2.6.4 && ./configure && make && make install
RUN cd /work && rm -rf flex-2.6.4 && rm flex-2.6.4.tar.gz

RUN cd /work && wget https://download.open-mpi.org/release/hwloc/v2.5/hwloc-2.5.0.tar.gz
RUN cd /work && tar -xvf hwloc-2.5.0.tar.gz && cd hwloc-2.5.0 && ./configure && make && make install
RUN cd /work && rm -rf hwloc-2.5.0 && rm hwloc-2.5.0.tar.gz

RUN cd /work && wget https://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz
RUN cd /work && tar -xvf LuaJIT-2.1.0-beta3.tar.gz && cd LuaJIT-2.1.0-beta3 && make && make install
RUN cd /work && rm -rf LuaJIT-2.1.0-beta3 && rm LuaJIT-2.1.0-beta3.tar.gz

RUN cd /work && wget https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz
RUN cd /work && tar -xvf pcre-8.45.tar.gz && cd pcre-8.45 && ./configure && make && make install
RUN cd /work && rm -rf pcre-8.45 && rm pcre-8.45.tar.gz

RUN cd /work && wget http://www.zlib.net/zlib-1.2.11.tar.gz
RUN cd /work && tar -xvf zlib-1.2.11.tar.gz && cd zlib-1.2.11 && ./configure && make && make install
RUN cd /work && rm -rf zlib-1.2.11 && rm zlib-1.2.11.tar.gz

RUN cd /work && git clone git://github.com/snort3/snort3.git
RUN cd /work/snort3 && export my_path=/usr/local && ./configure_cmake.sh --prefix=$my_path && cd build && make -j 2 install
