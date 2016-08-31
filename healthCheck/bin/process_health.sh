#!/bin/sh


port=$1
name=$2
hostname=$3
echo $name
echo $hostname

echo $port

if [ "$port" != "null" ];then
    portNum=`netstat -an |grep -w LISTEN|grep -w "${port}"|wc -l`

    if [ $portNum -ge 1 ];then

        echo -e '\033[0;32;1m [#SUCESS on port check#]'${name}' port '${port}' on '${hostname}' is alive  \033[0m'
    else

        echo -e '\033[0;31;1m [#FAIL on port check#]'${name}' port '${port}' on '${hostname}' is dead  \033[0m'
    fi

fi


processNum=`ps -ef |grep ${name}|grep -v grep|wc -l`

if [ $processNum -ge 1 ];then

    echo -e '\033[0;32;1m [#SUCESS on process check#]'${name}' process on '${hostname}' is alive  \033[0m' 
else

    echo -e '\033[0;31;1m [#FAIL on process check#]'${name}' process on '${hostname}' is dead  \033[0m'
fi
