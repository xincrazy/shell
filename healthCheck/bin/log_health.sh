#!/bin/sh

logdir=$1
hostname=$2


logError=`tail -100000 ${logdir}|grep " ERROR "`

if [ -z "$logError" ];then
    echo -e '\033[0;32;1m [#SUCESS on log check#] The log '${logdir}' on '${hostname}' does not contains ERROR message \033[0m'
else
    echo -e '\033[0;31;1m [#FAIL on log check#] The log '${logdir}' on '${hostname}' contains ERROR message \033[0m'
fi

