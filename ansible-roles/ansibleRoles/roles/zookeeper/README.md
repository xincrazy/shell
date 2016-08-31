# zookeeper cluster setup

## arguments

- hosts: eg. "zookeeper:&local"
- zoo_cfg: zookeeper configuration file name

## this playbook will:

- install jdk 1.8
- install zookeeper in /oneapm/local/zookeeper

## inventory requirements:

each inventory hosts requires a unique `zk_id` variable and must conform to configuration in zoo.cfg

```
[zookeeper]
10.128.7.27 zk_id=1
```
