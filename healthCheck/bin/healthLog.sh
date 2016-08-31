#!/bin/sh


usage(){
  echo "  需要三个参数，第一个是登陆执行机器用户名，第二个参数是登陆执行机器的密码，第三个参数是去目标机器执行的脚本
  举例子：sh health.sh 10.128.7.242 hadoop hadoop%123 slave log
   "
}
if [ $# -le 1 ]; then
  usage
  exit 1
fi


user=$2
passwd=$3
ip=$1
dirlog=$5
hostname=$4
script=log_health.sh



expect <<-EOF
set time 30
spawn scp log_health.sh ${user}@${ip}:/tmp/${script}
expect {
"*password:" { send "${passwd}\r";exp_continue}
"yes/no\" {send \"yes\r\"; exp_continue;}
}
EOF


expect <<-EOF
set time 30
spawn ssh ${user}@${ip} "sh /tmp/${script} $dirlog $hostname"
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
