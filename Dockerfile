FROM ubuntu:14.04 
# ubuntu:trusty
MAINTAINER Hideyuki Takei <hide@soth.io>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get -yq install build-essential openssl ca-certificates wget tar git vim curl --no-install-recommends
RUN update-ca-certificates
RUN rm -rf /var/lib/apt/lists/*

# Install redis
ENV GOLANG_VERSION 1.4.2
RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
    | tar -v -C /usr/src -xz
RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/src/go/bin:$PATH

RUN mkdir -p /go/src /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

WORKDIR /go/src/github.com/SociableThings/soth-gateway
VOLUME ["/go/src/github.com/SociableThings/soth-gateway"]

