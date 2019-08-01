#!/bin/bash

echo "127.0.0.1 localhost" > /etc/hosts
echo "127.0.1.1 $(hostname).wgcz.cz $(hostname)" >> /etc/hosts
echo "" >> /etc/hosts

echo "# The following lines are desirable for IPv6 capable hosts" >> /etc/hosts
echo "::1 ip6-localhost ip6-loopback" >> /etc/hosts
echo "fe00::0 ip6-localnet" >> /etc/hosts
echo "ff00::0 ip6-mcastprefix" >> /etc/hosts
echo "ff02::1 ip6-allnodes" >> /etc/hosts
echo "ff02::2 ip6-allrouters" >> /etc/hosts
echo "ff02::3 ip6-allhosts" >> /etc/hosts

sysctl kernel.hostname=`hostname`

wget --quiet -O - http://apt1.cz2.cloudevelops.com/key.asc | apt-key add -
echo "deb http://apt1.cz2.cloudevelops.com/cloudevelops xenial main" > /etc/apt/sources.list.d/cloudevelops-deploy.list
apt-get update && apt-get install -y puppet-agent=5.3.2-1xenial && /opt/puppetlabs/bin/puppet agent -tv --use_srv_records --srv_domain cloudevelops.com
