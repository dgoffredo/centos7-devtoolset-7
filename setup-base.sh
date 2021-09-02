#!/bin/sh

set -e

# https://www.softwarecollections.org/en/scls/rhscl/devtoolset-7/
yum install -y centos-release-scl
yum install -y devtoolset-7

# CentOS 7 needs `epel-release` for `jq`
yum install -y epel-release
yum update -y

yum install -y wget jq tar gzi make cmake3

# have `cmake` refer to `cmake3`
ln -s "$(command -v cmake3)" /usr/bin/cmake
