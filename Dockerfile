FROM ubuntu:22.04
LABEL maintainer="Ansu Varghese <avarghese@us.ibm.com>"

#Dockerfile input is the class name whose native image must be generated
ARG CLASS_NAME="Hello"

WORKDIR /jdwp

COPY nativeImageGen.sh .
COPY src/$CLASS_NAME ./src/$CLASS_NAME

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get -qqy update \
&& apt-get -qqy install \
  build-essential \
  valgrind \
  zlib1g-dev

#Graalvm exec jar in current dir downloaded from https://github.com/graalvm/graalvm-ce-builds/releases
COPY graalvm ./graalvm
ENV GRAALVM_HOME /jdwp/graalvm
ENV PATH $PATH:$GRAALVM_HOME/bin
RUN $GRAALVM_HOME/bin/gu install native-image

ENV CLASS_NAME=$CLASS_NAME

ENTRYPOINT ./nativeImageGen.sh -c $CLASS_NAME