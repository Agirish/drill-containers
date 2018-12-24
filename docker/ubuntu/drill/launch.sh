#!/usr/bin/env bash

PROJECT=drill
VERSION=$1
OS=ubuntu

if [[ ${VERSION} == "" ]]
then
  echo "Please enter the Drill VERSION string. For ex: 1.14.0"
  exit -1
fi

docker pull agirish/${PROJECT}:${VERSION}-${OS}

container_id=`eval "docker run -d --privileged -h ${PROJECT} agirish/${PROJECT}:${VERSION}-${OS}"`
docker exec -it $container_id /bin/bash