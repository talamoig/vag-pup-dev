#!/bin/bash

PUPPET_CLIENTS='centos6'
MASTER='master'
MODULES='icinga icingaweb2'
LINTOPTS='--no-documentation-check '
ERROR=0
for m in $MODULES
do
    echo -n "puppet-lint on module $m... "
    $command | grep ERROR 
    if [ ${PIPESTATUS[0]} -ne 0 ]
    then
	ERROR=1
	echo 'error'
    else
	echo 'ok'
    fi
done

if [ $ERROR -eq 1 ]
then
    echo "puppet-lint found some errors. Exiting..."
    exit 1
fi
for host in $PUPPET_CLIENTS
#`cat Vagrantfile|grep define|sed 's/.*|\(.*\)|/\1/'|grep -v $MASTER`
do
    echo "Checking $host"
    vagrant destroy $host
    vagrant up $host
    echo -n "$host: "
    STATUS=`vagrant status $host 2> /dev/null|grep $host|tr -s ' ' '\t'|cut -f 2`
    echo $STATUS
    if [ "$STATUS" == 'running' ]
	then
	./pprun.sh $host
    fi
done

