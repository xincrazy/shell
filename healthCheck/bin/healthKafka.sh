#!/bin/sh


usage(){
  echo "  需要三个参数，第一个是登陆执行机器用户名，第二个参数是登陆执行机器的密码，第三个参数是去目标机器执行的脚本
  举例子：sh health.sh 10.128.7.242 hadoop hadoop%123 ai consumer 10.128.7.241:2181 /app/kafka/bin
   "
}
if [ $# -le 1 ]; then
  usage
  exit 1
fi


ip=$1
user=$2
passwd=$3
hostname=$4
groupid=$5 
zookeeper=$6
kafkaHome=$7
topicName=$8
lag=$9

script=tag_health.sh



expect <<-EOF
set time 30
spawn scp ${script} ${user}@${ip}:/tmp/${script}
expect {
"*password:" { send "${passwd}\r";exp_continue}
"yes/no\" {send \"yes\r\"; exp_continue;}
}
EOF


expect <<-EOF
set time 30
spawn ssh ${user}@${ip} "sh /tmp/${script} $kafkaHome $zookeeper $groupid $hostname $topicName $lag"
expect {
"*password:" { send "${passwd}\r";exp_continue}
"yes/no\" {send \"yes\r\"; exp_continue;}
}
EOF

expect <<-EOF
set time 30
spawn ssh ${user}@${ip} "rm -rf /tmp/${script}"
expect {
"*password:" { send "${passwd}\r";exp_continue}
"yes/no\" {send \"yes\r\"; exp_continue;}
}
EOF
