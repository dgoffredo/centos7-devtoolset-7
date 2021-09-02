#!/bin/sh

set -e

# Install the nginx-opentracing module to the appropriate location for use by
# nginx.  Then install the Datadog opentracing plugin.
# The module and plugin are fetched from the most recent release in their
# respective github projects.

# This script is agnostic with respect to Linux distribution: it assumes that
# all required command line tools are already installed.

# This is based off of the following documentation:
# <https://docs.datadoghq.com/tracing/setup_overview/proxy_setup/?tab=nginx>.

get_latest_release() {
  wget --quiet -O - "https://api.github.com/repos/$1/releases/latest" | \
    jq --raw-output '.tag_name'
}

DD_OPENTRACING_CPP_VERSION=$(get_latest_release DataDog/dd-opentracing-cpp)

# install Datadog Opentracing library binary
wget "https://github.com/DataDog/dd-opentracing-cpp/releases/download/${DD_OPENTRACING_CPP_VERSION}/libdd_opentracing.so"
mv libdd_opentracing.so /usr/local/lib/

# unpack Datadog Opentracing headers
wget "https://github.com/DataDog/dd-opentracing-cpp/archive/refs/tags/${DD_OPENTRACING_CPP_VERSION}.tar.gz"
mkdir dd-opentracing-cpp
tar -xzf "${DD_OPENTRACING_CPP_VERSION}.tar.gz" -C dd-opentracing-cpp --strip-components 1
rm *.gz

# install opentracing-cpp, zlib, etc.
./dd-opentracing-cpp/scripts/install_dependencies.sh
