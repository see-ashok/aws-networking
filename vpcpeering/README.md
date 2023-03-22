# VPC Peering
A network connection between two VPCs enables you to route traffic between them using private IPv4 or IPv6 addresses. Peering can happen between your own VPCs or with a VPC in another AWS Account in the same or different Regions.

## Create VPCs using Terraform

- First create a resource block for VPC, Subnets, Route Tables and Internet Gateway in our main.tf file in the networking module.
- Next create Internet Gateway and attach it to VPC and adjust the route tables of the Public Subnet
- Create two VPCs VPC-A and VPC-B
- Peer the VPCs
- Modify Route Tables 

Peering Connection is not possible with overlapping CIDR blocks and it is not transitive. There is a limit to the number of VPCs that can be peered on as well.

# Commands to Test 

- Login to Bastion Host and ping Private EC2 in same VPC and other VPC ;  




``
[ec2-user@ip-10-1-1-251 ~]$ ping 10.1.2.198
PING 10.1.2.198 (10.1.2.198) 56(84) bytes of data.
64 bytes from 10.1.2.198: icmp_seq=1 ttl=255 time=0.462 ms
64 bytes from 10.1.2.198: icmp_seq=2 ttl=255 time=0.210 ms
64 bytes from 10.1.2.198: icmp_seq=3 ttl=255 time=0.185 ms
64 bytes from 10.1.2.198: icmp_seq=4 ttl=255 time=0.188 ms
64 bytes from 10.1.2.198: icmp_seq=5 ttl=255 time=0.207 ms
^C
--- 10.1.2.198 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4099ms
rtt min/avg/max/mdev = 0.185/0.250/0.462/0.107 ms
[ec2-user@ip-10-1-1-251 ~]$ ping 10.2.2.208
PING 10.2.2.208 (10.2.2.208) 56(84) bytes of data.
^C
--- 10.2.2.208 ping statistics ---
11 packets transmitted, 0 received, 100% packet loss, time 10247ms

[ec2-user@ip-10-1-1-251 ~]$ 
``

## Now Enable Peering 
- Uncomment the peering blocks in main.tf and run apply
Now we should be able to ping the other private hosts in other VPC

``
[ec2-user@ip-10-1-1-251 ~]$ ping 10.2.2.208
PING 10.2.2.208 (10.2.2.208) 56(84) bytes of data.
64 bytes from 10.2.2.208: icmp_seq=1 ttl=255 time=0.574 ms
64 bytes from 10.2.2.208: icmp_seq=2 ttl=255 time=0.186 ms
64 bytes from 10.2.2.208: icmp_seq=3 ttl=255 time=0.177 ms
64 bytes from 10.2.2.208: icmp_seq=4 ttl=255 time=0.150 ms
^C
--- 10.2.2.208 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3062ms
rtt min/avg/max/mdev = 0.150/0.271/0.574/0.176 ms
[ec2-user@ip-10-1-1-251 ~]$ 
``