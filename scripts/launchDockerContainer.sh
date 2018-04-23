#!/bin/bash

PROJECT=$1
OS=$2
VERSION=$3

docker pull drill/apache-${PROJECT}-${OS}:${VERSION}

container_id=`eval "docker run -d --privileged -h ${PROJECT} drill/apache-${PROJECT}-${OS}:${VERSION}"`
sleep 10
container_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${container_id} )
echo "Docker container IP address: ${container_ip}"

echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /tmp/hosts.$$
HOSTNAME=`echo -e "${container_ip}" | cut -d '.' -f 4`
echo -e "${container_ip}\t${PROJECT}-${HOSTNAME}\t${PROJECT}-${HOSTNAME}" >> /tmp/hosts.$$

sshpass -p "mapr" scp -o LogLevel=quiet -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -r /tmp/hosts.$$ ${container_ip}:/etc/hosts
