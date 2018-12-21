## Apache Drill on Kubernetes

### Embedded mode:

To quickly try out Apache Drill on a single node, install Drill in embedded mode. When launching Drill in embedded mode via the Drill shell, a local Drillbit service starts automatically. Drillbits are also automatically stopped when exiting from the shell. 

Below are steps to launch a single Drillbit in a Docker environment. It assumes that the Docker service is up and running on the host.

#### Launch Drill container 

```
git clone git@github.com:Agirish/drill-containers.git
cd drill-containers/yaml-def/[centos/ubuntu]
kubectl -create drill-pod.yaml
``` 

#### Start Drillbits 

```
/opt/drill/bin/drill-embedded
```
 

### Distributed mode:

Drill can be deployed in a distributed cluster environment, for large-scale data processing. Zookeeper is used for cluster co-ordination and is a pre-requisite for this mode. The current set of images include stand-alone zookeeper and drill. HDFS is not included.

#### Launch Zookeeper container 

```
git clone git@github.com:Agirish/drill-containers.git
cd drill-containers/yaml-def/[centos/ubuntu]
kubectl -create zk-service.yaml
```
Make a note of the ZK container IP address (ZK_IP_ADDR)
    
#### Launch Drill container 

```
kubectl -create drill-service.yaml
```

#### Configure Drillbits

Edit `/opt/drill/conf/drill-override.conf`. Update the `zk.connect` string with ZK_IP_ADDR 
    
#### Start Drillbits 

```
/opt/drill/bin/drillbit.sh start
/opt/drill/bin/sqlline -u jdbc:drill:zk=ZK_IP_ADDR:2181
```
