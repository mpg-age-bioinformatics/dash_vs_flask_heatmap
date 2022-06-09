FROM debian:buster-slim

LABEL maintainer "bioinformatics@age.mpg.de"

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ftp.debian.org/debian buster main non-free contrib" >> /etc/apt/sources.list && \
echo "deb-src http://ftp.debian.org/debian buster main non-free contrib" >> /etc/apt/sources.list && \
echo "deb http://ftp.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list && \
echo "deb-src http://ftp.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list 

RUN apt-get update && apt-get -yq dist-upgrade && \
apt-get install -yq --no-install-recommends locales && \
apt-get clean && rm -rf /var/lib/apt/lists/* && \
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

ENV TZ="Europe/Berlin"

ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get -yq dist-upgrade && \
apt-get install -yq libcairo2-dev python3 python3-pip pkg-config mariadb-client cron rsync sudo && \
python3 -m pip install -U pip && \
apt-get clean && rm -rf /var/lib/apt/lists/*

ENV BUILD_NAME heatmap

RUN groupadd ${BUILD_NAME} --gid=1000 && useradd -m ${BUILD_NAME} --uid=1000 --gid=1000 && echo "${BUILD_NAME}:4.iMkMm4zFoNViof" | \
    chpasswd

RUN mkdir /${BUILD_NAME} && chown -R ${BUILD_NAME}:${BUILD_NAME} /${BUILD_NAME}
COPY requirements.txt /${BUILD_NAME}/requirements.txt
RUN pip3 install --ignore-installed pyxdg==0.26 ; pip3 install -r /${BUILD_NAME}/requirements.txt


USER ${BUILD_NAME}:${BUILD_NAME}
WORKDIR /${BUILD_NAME}

ENTRYPOINT /${BUILD_NAME}/entrypoint.sh