FROM ubuntu:latest

LABEL org.opencontainers.image.source="https://github.com/toiletsandpaper/mojo-dev"
LABEL org.opencontainers.image.description="Mojo Stable Development Container"
LABEL org.opencontainers.image.licenses=MIT

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

# https://github.com/modularml/mojo/blob/nightly/CONTRIBUTING.md#getting-the-nightly-mojo-compiler
RUN curl https://get.modular.com | sh -

# https://github.com/MoSafi2/BlazeSeq/blob/main/.github/workflows/package.yml
RUN modular auth examples

RUN modular install mojo
# RUN modular install nightly/mojo

RUN echo export MODULAR_HOME="/root/.modular" >> ~/.bashrc
RUN echo export PATH="/root/.modular/pkg/packages.modular.com_nightly_mojo/bin:$PATH" >> ~/.bashrc

ENTRYPOINT [ "bash" ]
