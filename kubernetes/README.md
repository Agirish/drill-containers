## Apache Drill on Kubernetes

Drill can be deployed in a distributed cluster environment, for large-scale data processing. Zookeeper is used for cluster co-ordination and is a pre-requisite for this mode. The current set of images include stand-alone zookeeper and drill. HDFS is not included.

#### Clone Repository

```
git clone git@github.com:agirish/drill-containers.git
cd drill-containers/kubernetes
``` 

#### Create Namespace

```
$ kubectl create -f namespace.yaml
namespace "apache" created
``` 

#### Launch Zookeeper 

```
$ kubectl create -f zk.yaml 
service "zk-service" created
statefulset.apps "zk" created
```
    
#### Launch Drill 

```
$ kubectl create -f drill.yaml 
service "drill-service" created
statefulset.apps "drillbit" created
```
#### Check Status 

```
$ kubectl get pods -n apache -w
NAME         READY     STATUS    RESTARTS   AGE
drillbit-0   1/1       Running   0          40s
zk-0         1/1       Running   0          1m
```

#### Connect to Sqlline

```
$ kubectl exec -it drillbit-0 --namespace=apache -- bash

# /opt/drill/bin/drill-localhost
apache drill 1.14.0 
"a drill is a terrible thing to waste"
0: jdbc:drill:drillbit=localhost> select version from sys.drillbits;
+----------+
| version  |
+----------+
| 1.14.0   |
+----------+
1 row selected (0.371 seconds)
```
