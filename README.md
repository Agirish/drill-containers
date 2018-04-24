# Dockerfiles & YAML definitions for Apache Drill

Docker images for Apache Drill are available on [Docker Hub](https://hub.docker.com/r/drill/). This repository includes scripts to launch Drill containers under Docker, and YAML files to launch them under Kubernetes. It also incldues Dockerfiles to customize the Docker images.

## Bringing up Apache Drill in Docker environment

### Embedded mode:

To quickly try out Apache Drill on a single node, install Drill in embedded mode. When launching Drill in embedded mode via the Drill shell, a local Drillbit service starts automatically. Drillbits are also automatically stopped when exiting from the shell. 

Below are steps to launch a single Drillbit in a Docker environment. It assumes that the Docker service is up and running on the host.

#### Clone repository 

```git clone git@github.com:Agirish/drill-docker.git```

#### Launch Drill container 

```cd drill-docker/scripts``` 

```./launchDockerContainer.sh drill centos 1.13.0``` 

#### Launch Sqlline 

```/opt/drill/bin/drill-embedded```
 
 

### Distributed mode:

Drill can be deployed in a distributed cluster environment, for large-scale data processing. Zookeeper is used for cluster co-ordination and is a pre-requisite for this mode. The current set of images include stand-alone zookeeper and drill. HDFS is not included.

#### Clone repository 

```git clone git@github.com:Agirish/drill-docker.git```

#### Launch Zookeeper container 

```cd drill-docker/scripts``` 

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

To quickly try out Apache Drill on a single node, install Drill in embedded mode. When launching Drill in embedded mode via the Drill shell, a local Drillbit service starts automatically. Drillbits are also automatically stopped when exiting from the shell. 

Below are steps to launch a single Drillbit in a Docker environment. It assumes that the Docker service is up and running on the host.

#### Clone repository 

```git clone git@github.com:Agirish/drill-docker.git```

#### Launch Drill container 

```cd drill-docker/yaml-def``` 

```kubectl -create drill.yaml``` 

#### Launch Sqlline 

```/opt/drill/bin/drill-embedded```
 


### Distributed mode:

Drill can be deployed in a distributed cluster environment, for large-scale data processing. Zookeeper is used for cluster co-ordination and is a pre-requisite for this mode. The current set of images include stand-alone zookeeper and drill. HDFS is not included.

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
