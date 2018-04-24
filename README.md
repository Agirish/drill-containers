# Dockerfiles & YAML definitions for Apache Drill

## Bringing up Apache Drill in Docker environment

### Embedded mode:

#### Clone repository 

```git clone git@github.com:Agirish/drill-docker.git```

#### Launch Drill container 

```cd drill-docker/scripts``` 

```./launchDockerContainer.sh drill centos 1.13.0``` 

#### Launch Sqlline 

```/opt/drill/bin/drill-embedded```
 
 

### Distributed mode:

#### Clone repository 

```git clone git@github.com:Agirish/drill-docker.git```

#### Launch Zookeeper container 

```cd drill-docker/scripts` 

```./launchDockerContainer.sh zookeeper centos 3.4.10```

Make a note of the ZK container IP address (ZK_IP_ADDR)
    
#### Launch Drill container 

```cd drill-docker/scripts``` 

```./launchDockerContainer.sh drill centos 1.13.0```

#### Configure Drillbits

Edit `/opt/drill/conf/drill-override.conf`. Update the `zk.connect` string with the ZK container IP address 
    
#### Start Drillbits 

```/opt/drill/bin/drillbit.sh start``` 

#### Launch Sqlline 

```/opt/drill/bin/sqlline -u jdbc:drill:zk=ZK_IP_ADDR:2181``` 

Repeat steps (3)-(5) to add more Drillbits to the Drill cluster

## Bringing up Apache Drill in Kubernetes environment

### Embedded mode:

#### Clone repository 

```git clone git@github.com:Agirish/drill-docker.git```

#### Launch Drill container 

```cd drill-docker/yaml-def``` 

```kubectl -create drill.yaml``` 

#### Launch Sqlline 

```/opt/drill/bin/drill-embedded```
 


### Distributed mode:

#### Clone repository 

```git clone git@github.com:Agirish/drill-docker.git```

#### Launch Zookeeper container 

```cd drill-docker/yaml-def``` 

```kubectl -create zk.yaml```

Make a note of the ZK container IP address (ZK_IP_ADDR)
    
#### Launch Drill container 

```cd drill-docker/yaml-def``` 

```kubectl -create drill.yaml```

#### Configure Drillbits

Edit `/opt/drill/conf/drill-override.conf`. Update the `zk.connect` string with ZK_IP_ADDR 
    
#### Start Drillbits 

```/opt/drill/bin/drillbit.sh start``` 

#### Launch Sqlline 

```/opt/drill/bin/sqlline -u jdbc:drill:zk=ZK_IP_ADDR:2181```

Repeat steps (3)-(5) to add more Drillbits to the Drill cluster
