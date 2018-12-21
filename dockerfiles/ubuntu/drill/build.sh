#!/bin/bash

PROJECT=drill
OS=ubuntu
VERSION=$1

if [[ ${VERSION} == "" ]]
then
  echo "Please enter the Drill VERSION string. For ex: 1.14.0"
  exit -1
fi

docker build --build-arg VERSION=${VERSION} -t ${PROJECT}:${VERSION}-${OS} .

docker tag ${PROJECT}:${VERSION}-${OS} agirish/${PROJECT}:${VERSION}-${OS}
docker push agirish/${PROJECT}:${VERSION}-${OS}
