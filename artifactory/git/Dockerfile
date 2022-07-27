FROM registry.access.redhat.com/ubi7

# Prerequisites
RUN yum install -y gcc-c++ gzip make openssl openssl-devel postgresql-libs tar which libyaml
RUN yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/bison-3.0.4-2.el7.x86_64.rpm && \
    yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/flex-2.5.37-6.el7.x86_64.rpm

# Cmake
WORKDIR /tmp/cmake
ENV CMAKE_URL https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0.tar.gz
RUN curl -L -s ${CMAKE_URL} | tar xzv -C . --strip-components 1 && \
    ./configure --prefix=/usr/local && \
    make -j$(nproc) && \
    make install

# Fluent-bit
WORKDIR /tmp/git
ARG GIT_VERSION
ENV GIT_VERSION=$GIT_VERSION
#ENV FLUENT_BIT_URL https://github.com/fluent/fluent-bit/archive/refs/tags/v${FLUENT_BIT_VERSION}.tar.gz
ENV GIT_URL https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz
RUN curl -L -s "${GIT_URL}" | tar xzv -C . --strip-components 1
RUN yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/libyaml-devel-0.1.4-11.el7_0.x86_64.rpm
RUN cd build && \
    cmake ../ && \
    make && \
    make install

WORKDIR /dropbox
RUN mkdir ./git && \
    cp /usr/local/bin/git /usr/lib64/libpq.so.5 ./git && \
    tar -czvf git.tar.gz git && \
    rm -rf ./git
