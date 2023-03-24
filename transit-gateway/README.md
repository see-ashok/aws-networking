[ec2-user@ip-10-2-1-214 ~]$ ping 10.3.2.61
PING 10.3.2.61 (10.3.2.61) 56(84) bytes of data.
^C
--- 10.3.2.61 ping statistics ---
8 packets transmitted, 0 received, 100% packet loss, time 7148ms

[ec2-user@ip-10-2-1-214 ~]$ vi key.pem
[ec2-user@ip-10-2-1-214 ~]$ chmod 400 key.pem 
[ec2-user@ip-10-2-1-214 ~]$ ssh -i key.pem ec2-user@10.2.2.92
The authenticity of host '10.2.2.92 (10.2.2.92)' can't be established.
ECDSA key fingerprint is SHA256:hcwpJeT1iB0h0o4W+h6Un+RMhNAfu7Q3jTecQXraXjw.
ECDSA key fingerprint is MD5:b7:19:3e:9c:5c:a7:ea:9d:8b:56:67:95:e8:06:83:99.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '10.2.2.92' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
[ec2-user@ip-10-2-2-92 ~]$ ping 10.3.2.61
PING 10.3.2.61 (10.3.2.61) 56(84) bytes of data.
64 bytes from 10.3.2.61: icmp_seq=1 ttl=254 time=1.46 ms
64 bytes from 10.3.2.61: icmp_seq=2 ttl=254 time=0.325 ms
64 bytes from 10.3.2.61: icmp_seq=3 ttl=254 time=0.391 ms
64 bytes from 10.3.2.61: icmp_seq=4 ttl=254 time=0.333 ms
^C
--- 10.3.2.61 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3037ms
rtt min/avg/max/mdev = 0.325/0.627/1.461/0.482 ms
[ec2-user@ip-10-2-2-92 ~]$ 