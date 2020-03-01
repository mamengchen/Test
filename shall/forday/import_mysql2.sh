#!/bin/bash

user="mmc"
password="123456"
ipad="127.0.0.1"

mysql_conn="mysql -u"$user" -p"$password" -h "$ipad""

Separation="$1"

sed 's/||/\t/g' data2.txt | while read id name birth sex
do
    $mysql_conn -e "insert into school.student2 values('$id','$name','$birth','$sex')"
done
