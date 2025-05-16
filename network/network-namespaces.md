# Some note based on this:
https://www.youtube.com/watch?v=_WgUwUf1d34&ab_channel=DavidMahler


# References

* man ip-netns

* mininet: an instant virtual network on your laptop Bob Lantz, Brian O'Conner

* openstack.org
* openvswitch.orig
* opencloudblog.com

# Namespaces

* Isolated network environment on the same VM
* Each ns has its own interfaces, routing tables and forwarding tables
* Used in openstack, mininet, docker, 

* SDN - software defined network

* root namespace - default network environment on a Linux system

```
ip link
ip a
ip route

ip netns add red
ip netns add green
ip netns


ls /var/run/netns

ip netns del red

ip netns exec red ip link
```

# can connect namespaces via a virtual switch like ovs

ovs-vsctl add-br OVS1

ovs-vsctl show
# should show up as a link in:
ip link

# virtual ethernet interfaces, create ethernet pair eith0-r and veth-r (where "r" means red)
ip link add eth0-r type veth peer name veth-r

# this should show up in "ip link" command

# place eth0-r into red namespace (it will no longer be visible in the root ns)
ip link set eth0-r netns red

# eth0-r should now be visible in red ns:
ip netns red exec ip link

# connect other end of ethernet pair to ovs:
ovs-vsctl add-port OVS1 veth-r

ovs-vsctl show


# create veth pair for green network
```
ip link add eth0-g type veth peer name veth-g

ip link set eth0-g netns green
ovs-vsctl add-port OVS1 veth-g

ip link set veth-r up

ip netns exec red ip link set dev lo up
ip netns exec red ip link set dev eth0-r up
ip netns exec red ip addresss add 10.0.0.1/24 dev eth0-r
ip netns exec red ip a 
ip netns exec red ip route
```

# start a bash shell inside the green namespace (so that all subsequent network commands will be in the green ns)
ip netns exec green bash
# then run the command for the green ns
ip link set dev lo up
ip link set dev eth0-g up
ip addresss add 10.0.0.2/24 dev eth0-g


# type exit to return to root ns
exit

final state:
```
red ns  eth0-r 10.0.0.1/24 <----------> veth-r open v switch veth-g <-----------> eth0-g 10.0.0.1/24 green ns
```

# check connectivity
```
ip netns exec red bash 
ping 10.0.0.2
```

# using "tag 100" means it uses vlan 100


# Move port tap-r to dhcp-r namespace:
```
ip link set tap-r netns dhcp-r
```
