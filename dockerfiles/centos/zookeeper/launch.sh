#!/bin/bash

PROJECT=zookeeper
VERSION=$1

if [[ ${VERSION} == "" ]]
then
  echo "Please enter the ZooKeeper VERSION string. For ex: 3.4.10"
  exit -1
fi

docker pull agirish/${PROJECT}:${VERSION}

container_id=`eval "docker run -d --privileged -h ${PROJECT} agirish/${PROJECT}:${VERSION}"`
sleep 10
container_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${container_id} )
echo "Docker container IP address: ${container_ip}"

echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /tmp/hosts.$$
HOSTNAME=`echo -e "${container_ip}" | cut -d '.' -f 4`
echo -e "${container_ip}\t${PROJECT}-${HOSTNAME}\t${PROJECT}-${HOSTNAME}" >> /tmp/hosts.$$

sshpass -p "drill" scp -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -r /tmp/hosts.$$ ${container_ip}:/etc/hosts