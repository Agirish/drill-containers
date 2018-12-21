#!/bin/bash

PROJECT=zookeeper
OS=centos
VERSION=3.4.10

docker build --build-arg VERSION=${VERSION} -t ${PROJECT}:${VERSION}-${OS} .

docker tag ${PROJECT}:${VERSION}-${OS} agirish/${PROJECT}:${VERSION}-${OS}
docker push agirish/${PROJECT}:${VERSION}-${OS}

docker tag ${PROJECT}:${VERSION}-${OS} agirish/${PROJECT}:${VERSION}
docker push agirish/${PROJECT}:${VERSION}
