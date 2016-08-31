#!/bin/sh


kafkaHome=$1
zookeeper=$2
groupId=$3
hostname=$4
topicName=$5
lagValue=$6

Lag=`$kafkaHome/kafka-consumer-offset-checker.sh --zookeeper $zookeeper --topic $topicName --group $groupId|grep -v Group|awk '{total+=$6}END{print total}'`

if [ $Lag -lt $lagValue ];then
   echo -e '\033[0;32;1m [#SUCESS on lag check#] The consumer group '${groupId}' on '${hostname}' lag is normal \033[0m' 
else
   echo -e '\033[0;31;1m [#FAIL on lag check#] The consumer group '${groupId}' on '${hostname}' lag is too many \033[0m'
fi
