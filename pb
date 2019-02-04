ubuntu@personnel:~$ ping download.docker.com
PING d2h67oheeuigaw.cloudfront.net (54.230.79.89) 56(84) bytes of data.
64 bytes from server-54-230-79-89.cdg50.r.cloudfront.net (54.230.79.89): icmp_seq=1 ttl=243 time=63.0 ms
64 bytes from server-54-230-79-89.cdg50.r.cloudfront.net (54.230.79.89): icmp_seq=2 ttl=243 time=76.6 ms
64 bytes from server-54-230-79-89.cdg50.r.cloudfront.net (54.230.79.89): icmp_seq=3 ttl=243 time=76.8 ms
^C
--- d2h67oheeuigaw.cloudfront.net ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 63.078/72.202/76.884/6.460 ms
ubuntu@personnel:~$ wget https://download.docker.com/linux/ubuntu/dists/bionic/stable/binary-amd64/Packages.bz2
--2019-02-04 22:29:38--  https://download.docker.com/linux/ubuntu/dists/bionic/stable/binary-amd64/Packages.bz2
Resolving download.docker.com (download.docker.com)... 54.230.79.27, 54.230.79.142, 54.230.79.230, ...
Connecting to download.docker.com (download.docker.com)|54.230.79.27|:443...
