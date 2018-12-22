#!/bin/bash

PROJECT=zookeeper
OS=ubuntu
VERSION=3.4.10

docker build --build-arg VERSION=${VERSION} -t ${PROJECT}:${VERSION}-${OS} .

if [[ $? -eq 0 ]]
then
  docker tag ${PROJECT}:${VERSION}-${OS} agirish/${PROJECT}:${VERSION}-${OS}
  docker push agirish/${PROJECT}:${VERSION}-${OS}
fi
