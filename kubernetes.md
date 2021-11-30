
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


