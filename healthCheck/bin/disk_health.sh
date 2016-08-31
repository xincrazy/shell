#!/bin/sh

hostname=$1
diskvalue=`df -lh|awk '{value=substr($5,0,length($5)-1);if(int(value)>90){printf("%s used %s,",$6,$5)}}'`

if [ -z "$diskvalue" ]
then
    echo -e '\033[0;32;1m [#SUCESS on disk check#] disk on '${hostname}' is health  \033[0m' 
else
    echo -e '\033[0;31;1m [#FAIL on disk check#] '${diskvalue}' on '${hostname}' \033[0m'
fi
