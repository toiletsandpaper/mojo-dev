FROM ubuntu:latest

LABEL org.opencontainers.image.source=https://gist.github.com/toiletsandpaper/9d25e5d70b38cdd3961b57ca200e1caa
LABEL org.opencontainers.image.description="Mojo nightly dev container"
LABEL org.opencontainers.image.licenses=MIT


# https://stackoverflow.com/a/75170380
# https://www.build-python-from-source.com/
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get -y install build-essential \
        zlib1g-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libgdbm-dev \ 
        libnss3-dev \
        libssl-dev \
        libreadline-dev \
        libffi-dev \
        libsqlite3-dev \
        libbz2-dev \
        libedit-dev \
        liblzma-dev \
        llvm \
        xz-utils \
        tk-dev \
        wget \
        curl \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get purge -y imagemagick imagemagick-6-common 

RUN cd /usr/src \
    && wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz \
    && tar -xzf Python-3.11.9.tgz \
    && cd Python-3.11.9 \
    && ./configure --prefix=/opt/python/3.11.9/ --enable-optimizations --with-lto --with-computed-gotos --with-system-ffi --enable-shared \
    && make -j "$(nproc)" \
    && make altinstall \
    && cd .. \
    && rm Python-3.11.9.tgz \
    && rm -rf Python-3.11.9

RUN /opt/python/3.11.9/bin/python3.11 -m pip install --upgrade pip setuptools wheel

RUN ln -s /opt/python/3.11.9/bin/python3.11        /opt/python/3.11.9/bin/python3 \
    ln -s /opt/python/3.11.9/bin/python3.11        /opt/python/3.11.9/bin/python \
    ln -s /opt/python/3.11.9/bin/pip3.11           /opt/python/3.11.9/bin/pip3 \
    ln -s /opt/python/3.11.9/bin/pip3.11           /opt/python/3.11.9/bin/pip \
    ln -s /opt/python/3.11.9/bin/pydoc3.11         /opt/python/3.11.9/bin/pydoc \
    ln -s /opt/python/3.11.9/bin/idle3.11          /opt/python/3.11.9/bin/idle \
    ln -s /opt/python/3.11.9/bin/python3.11-config      /opt/python/3.11.9/bin/python-config 

# https://github.com/modularml/mojo/blob/nightly/CONTRIBUTING.md#getting-the-nightly-mojo-compiler
RUN curl https://get.modular.com | sh -

# https://github.com/MoSafi2/BlazeSeq/blob/main/.github/workflows/package.yml
RUN modular auth examples

# RUN modular install mojo
RUN modular install nightly/mojo

RUN echo export MODULAR_HOME="/root/.modular" >> ~/.bashrc
RUN echo export PATH="/root/.modular/pkg/packages.modular.com_nightly_mojo/bin:$PATH" >> ~/.bashrc

ENTRYPOINT [ "bash" ]
