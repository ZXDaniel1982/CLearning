FROM ubuntu
MAINTAINER Daniel "choku1980@163.com"

USER root

# install ubuntu packages
RUN apt-get update
RUN apt-get install -y wget git

RUN dpkg --add-architecture i386
RUN apt-get update

RUN apt-get install -y build-essential libncurses-dev make
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1
RUN apt-get install -y u-boot-tools

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# install tiny210 compiler
ADD arm-linux-gcc-4.5.1-v6-vfp-20120301.tgz /

# install friendlyarm tiny210 linux kernel 3.0.8
ADD linux-3.0.8-friendlyarm.tgz /

# install friendlyarm tiny210 busybox 1.17.2
ADD busybox-1.17.2-20101120.tgz /
