#!/bin/sh

PROJECT=$1
OS=$2
VERSION=$3

docker tag apache-${PROJECT}-${OS}:${VERSION} drill/apache-${PROJECT}-${OS}:${VERSION}
docker push drill/apache-${PROJECT}-${OS}:${VERSION}
