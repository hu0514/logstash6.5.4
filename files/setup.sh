#!/bin/bash
data_path=/data/logstash6.5
default_path=/home/logstash
logstash_path=/usr/local/logstash

if [ ! -d ${data_path} ];then
	mkdir -p ${data_path}
	cp -r ${default_path}/config ${data_path}/
	chown -R logstash:logstash ${data_path}
	echo "123"
	exec ${logstash_path}/bin/logstash -f ${logstash_path}/config/logstash-sample.conf
elif [ ! -f ${data_path}/config/logstash.yml ];then
	cp -a ${default_path}/config/logstash.yml ${data_path}/config/logstash.yml
	rm -rf ${logstash_path}/config
	cp -r ${data_path}/config ${logstash_path}/
	chown -R logstash:logstash ${logstash_path}/config
	echo "345"
	exec ${logstash_path}/bin/logstash -f ${logstash_path}/config/logstash-sample.conf
else 
	rm -rf ${logstash_path}/config
        cp -r ${data_path}/config ${logstash_path}/
        chown -R logstash:logstash ${logstash_path}/config
	echo "456"
	exec ${logstash_path}/bin/logstash -f ${logstash_path}/config/logstash-sample.conf
fi

#/usr/local/logstash/bin/logstash -f /usr/local/logstash/config/logstash-sample.conf
