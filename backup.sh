#!/bin/bash

NOW_DATE=`date`

BACKUP_DATE=`date +"%Y%m%d"`

BACKUP_PATH=/backup

LOG_PATH=/var/log

tar zcf ${BACKUP_PATH}/LOG_${BACKUP_DATE}.tar.gz ${LOG_PATH}

echo "Log_Backup : ${NOW_DATE}"

echo "Backup_PATH : ${BACKUP_PATH}"

echo "Backup_File : ${LOG_PATH}"
