#!/bin/bash

NOW_DATE=`date`

LOG_DATE=`date +"%Y%m%d"`

LOG_PATH=/var/log/apache_health

file1="/var/log/apache_health/apache_${LOG_DATE}.log"

echo "$file1"

if [ -f $file1 ]; then
	echo "Log file exists"
else 
	touch file1
fi


if (( $# > 1 )); then 
	echo "only enter one option!"
	echo "check | start | status"
	exit 1
fi

echo "Default Option is check"
value=1

option=$1


if [ "$option" == "check" ]; then
	value=1

elif [ "$option" == "start" ]; then 
	value=2

elif [ "$option" == "status" ]; then
	value=3
else 
	value=1
fi


case $value in
	"1" ) echo "Start HTTP_Check start"
		if pgrep httpd > /dev/null 2>&1
			then
				if [ $(systemctl is-active httpd) == "active" ]; then
					echo "httpd is running"
					echo "${NOW_DATE}: httpd is running" >> ${LOG_PATH}/apache_${LOG_DATE}.log
				fi
			else
				echo "httpd is not running"
					echo "${NOW_DATE}: httpd is not running" >> ${LOG_PATH}/apache_${LOG_DATE}.log
				systemctl status httpd
				/root/health_check.sh start &
				sleep 2 
				/root/health_check.sh status 
		fi;;

	"2" ) echo "Start HTTP_Service"
		systemctl start httpd
			echo "${NOW_DATE}: httpd is started by shell Script" >> ${LOG_PATH}/apache_${LOG_DATE}.log;;
	"3" ) echo "View HTTP_STATUS"
		systemctl status httpd
			echo "${NOW_DATE}: show httpd stauts shell Script" >> ${LOG_PATH}/apache_${LOG_DATE}.log;;
	* ) echo "NO";;
esac


