#!/bin/sh

bin=`dirname "${BASH_SOURCE-$0}"`

HOME=`cd "$bin";cd ..; pwd`

if [ -z $(which expect) ]; then
    yum install expect
fi 


#echo "###Alive Check###"
if [ -f $HOME/conf/hosts.list ]; then
    for i in `cat $HOME/conf/hosts.list |grep -v ip`
    do
        ip=`echo $i|awk -F \| '{print $1}'`
        user=`echo $i|awk -F \| '{print $2}'`
        passwd=`echo $i|awk -F \| '{print $3}'`
        hostname=`echo $i|awk -F \| '{print $4}'`
        name=`echo $i|awk -F \| '{print $6}'`
        port=`echo $i|awk -F \| '{print $7}'`
        sh healthProcess.sh $ip $user $passwd $hostname $name $port|grep \# &
    done
else
    echo "please provide hosts.list"
fi


#echo "###Log Error Check###"
if [ -f $HOME/conf/hosts.list ]; then
    for i in `cat $HOME/conf/hosts.list |grep -v ip`
    do
        ip=`echo $i|awk -F \| '{print $1}'`
        user=`echo $i|awk -F \| '{print $2}'`
        passwd=`echo $i|awk -F \| '{print $3}'`
        hostname=`echo $i|awk -F \| '{print $4}'`
        logdir=`echo $i|awk -F \| '{print $5}'`
        sh healthLog.sh $ip $user $passwd $hostname $logdir|grep \# &
    done
else
    echo "please provide hosts.list"
fi

#echo "###Kafka Topic Lag Check###"

if [ -f $HOME/conf/topic.list ]; then
    for i in `cat $HOME/conf/topic.list |grep -v ip`
    do
        ip=`echo $i|awk -F \| '{print $1}'`
        user=`echo $i|awk -F \| '{print $2}'`
        passwd=`echo $i|awk -F \| '{print $3}'`
        hostname=`echo $i|awk -F \| '{print $4}'`
        groupid=`echo $i|awk -F \| '{print $5}'`
        zookeeper=`echo $i|awk -F \| '{print $6}'`
        kafkaHome=`echo $i|awk -F \| '{print $7}'`
        topicName=`echo $i|awk -F \| '{print $8}'`
        lag=`echo $i|awk -F \| '{print $9}'`
        sh healthKafka.sh $ip $user $passwd $hostname $groupid $zookeeper $kafkaHome $topicName $lag|grep \# &
    done
else
    echo "please provide topic.list"
fi

#echo "###Disk Error Check###"
if [ -f $HOME/conf/hosts.list ]; then
    for i in `cat $HOME/conf/hosts.list |grep -v ip`
    do
        ip=`echo $i|awk -F \| '{print $1}'`
        user=`echo $i|awk -F \| '{print $2}'`
        passwd=`echo $i|awk -F \| '{print $3}'`
        hostname=`echo $i|awk -F \| '{print $4}'`
        sh healthDisk.sh $ip $user $passwd $hostname|grep \# &
    done
else
    echo "please provide hosts.list"
fi

wait
echo "All check is complete"
exit 0
