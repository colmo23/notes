
## service
Selector links service to pods using labels
Can map port to targetPort

## kube-proxy
every node runs kube-proxy

it takes traffic from service's clusterIP and port and redirect it to service's backend pods

## clusterIp
this ip is only accessible internally

## nodePort
exposes the service on the worker node's port


## pod selection

Scheduler assigns pods to nodes

Filtering - can a pod run on a node

Scoring - what is the best node to run a pod on

https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

Affinity attracts pods to nodes

Taints allow nodes to repel pods

Node controller can taint a node when there is memory pressure or other situations

Node-pressure eviction is the process by which the kubelet proactively terminates pods to reclaim resources on nodes.


