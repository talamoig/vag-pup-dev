#!/bin/bash
HOST=$1
if [ $# -ne 1 ]
then
echo "Usage: $0 <hostname>"
echo "<hostname> can be any of:"
grep 'vm.define' Vagrantfile|sed 's/.*:\(.*\) do.*/\1/'
exit 1
fi
COMMAND='sudo puppet apply --pluginsync --verbose --modulepath /vagrant/puppet/modules/ /vagrant/puppet/manifests/site.pp'
vagrant ssh $HOST -c "$COMMAND"
exit $?