#!/bin/sh

PROJECT=$1
OS=$2
VERSION=$3

docker build -t apache-${PROJECT}-${OS}:${VERSION} ../templates/apache-${PROJECT}-${OS}-${VERSION}
