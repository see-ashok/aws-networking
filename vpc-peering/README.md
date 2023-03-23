# VPC Peering
A network connection between two VPCs enables you to route traffic between them using private IPv4 or IPv6 addresses. Peering can happen between your own VPCs or with a VPC in another AWS Account in the same or different Regions.

## Create VPCs using Terraform

- First create a resource block for VPC, Subnets, Route Tables and Internet Gateway in our main.tf file in the networking module.
- Next create Internet Gateway and attach it to VPC and adjust the route tables of the Public Subnet
- Create two VPCs VPC-A and VPC-B
- Peer the VPCs
- Modify Route Tables 

Peering Connection is not possible with overlapping CIDR blocks and it is not transitive. There is a limit to the number of VPCs that can be peered on as well.

