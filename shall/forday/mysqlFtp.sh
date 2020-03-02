#!/bin/bash

mysqlUser="mmc"
mysqlPassword="123456"
mysqlHost="127.0.0.1"

ftpUser="userftp"
ftpHost="172.16.232.141"
ftpPassword="123456"
ftpDstDir="/home/userftp/workspace"

time_data="`date +%Y%m%d%H%M%S`"
file_name="MySQL_SCHOOL_${time_data}.sql"

function auto_ftp
{
    ftp -inv << EOF
        open $ftpHost
        user $ftpUser $ftpPassword

        cd $ftpDstDir
        put $1
EOF
}

mysqldump -u"$mysqlUser" -p"$mysqlPassword" -h"$mysqlHost" school > ./$file_name && auto_ftp $file_name
rm $file_name
