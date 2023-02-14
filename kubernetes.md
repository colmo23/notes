# Kubernetes components
## Control plane
aka "master"
* api server
* cluster store - etcd
* controller manager - Deployment controller, StatefulSet controller, ReplicaSet controller, etc
* scheduler

## worker
* kubelet - watches the api server and executes tasks
* container runtime - eg Docker
* kube-proxy - node networking

# Services
## service
Selector links service to pods using labels
Can map port to targetPort

eg 
```
kubectl get services
...
reporting-messaging-opendistro-es-kibana-svc         ClusterIP   10.192.239.64    <none>        443/TCP                               21h
traffic-processing-messaging-ams-pxp-rest            NodePort    10.192.236.117   <none>        8000:30800/TCP                        21h
```
On a pod in the cluster reporting-messaging-opendistro-es-kibana-svc:443 or 10.192.239.64:443 is accessible but not accessible from outside the cluster
<worker ip>:30800 is accessible outside the cluster.

## kube-proxy
every node runs kube-proxy

it takes traffic from service's clusterIP and port and redirect it to service's backend pods

## clusterIp
This is the default service type.
This ip is only accessible internally

## nodePort
Exposes the service on the worker node's port


## pod selection

Scheduler assigns pods to nodes

Filtering - can a pod run on a node

Scoring - what is the best node to run a pod on

https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

Affinity attracts pods to nodes

Taints allow nodes to repel pods

Node controller can taint a node when there is memory pressure or other situations

Node-pressure eviction is the process by which the kubelet proactively terminates pods to reclaim resources on nodes.

# Pods
Each pod has its own IP address. Containers in the pod share the IP address. Same applies for hostname.

Pods are immutable.

## Sidecar containter
This is a helper container in a pod. Helps the main container do its job.
## Init container
Starts and finishes before the main container is allowed to start.

## Getting information
```
# get pod manifest:
kubectl get pods pod-name -o yaml
# get pod info and event history:
kubeclt describe pod pod-name
```

# Deployments
Individual Pods don't self-heal, scale or allow for easy upgrade and rollback. Hence Pods are wrapped in Deployments.

# Help
## get list of topics:
```
kubectl api-resources
```
## get help on a topic
```
kubectl explain <topic name>
```
## get help on all fields of a topic
```
kubectl explain <topic name> --recursive
```
then get help for one of the fields
```
kubectl explain sts.status.readyReplicas
```


