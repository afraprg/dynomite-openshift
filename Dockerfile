FROM ubuntu:18.04

RUN apt-get update && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
	autoconf \
	build-essential \
	dh-autoreconf \
	git \
	libssl-dev \
	libtool \
	software-properties-common \
	redis-server \
	tcl8.5

RUN git clone https://github.com/Netflix/dynomite.git
RUN echo 'Git repo has been cloned in your Docker VM'

WORKDIR dynomite/

RUN autoreconf -fvi \
	&& ./configure --enable-debug=log \
	&& CFLAGS="-ggdb3 -O0" ./configure --enable-debug=full \
	&& make \
	&& make install

RUN echo 'Exposing peer port 8101'
EXPOSE 8101

RUN echo 'Exposing stats/admin port 22222'
EXPOSE 22222

RUN echo 'Exposing client port for Dynomite 8102'
EXPOSE 8102
