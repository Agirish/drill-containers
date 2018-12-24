#!/usr/bin/env bash

sed -i 's/localhost/zk-service/g' /opt/drill/conf/drill-override.conf
/opt/drill/bin/drillbit.sh restart

while true; do sleep 5; done
