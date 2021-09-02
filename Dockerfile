# This builds an image that builds and runs a small C++ program with Datadog tracing.

# FROM ecraft/centos:7.3
FROM centos:7

# directory for "build" scripts
RUN mkdir -p /opt/build
WORKDIR /opt/build

# `yum install` a bunch of stuff
COPY ./setup-base.sh /opt/build/
RUN ./setup-base.sh

# install-datadog.sh installs the nginx-opentracing module into the nginx
# installed above, and then installs the Datadog opentracing plugin.
COPY ./install-datadog.sh /opt/build/
RUN scl enable devtoolset-7 ./install-datadog.sh

COPY ./Makefile ./tracer.cpp /opt/build/
RUN scl enable devtoolset-7 make

CMD ["./tracer"]
# or maybe CMD ["scl", "enable", "devtoolset-7", "./tracer"]
