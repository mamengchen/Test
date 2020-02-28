#!/bin/bash

FILE_NAME=/home/mmc/workspace/shall/twoday/my.cnf


function get_mysql_segment
{
    echo `sed -n '/\[.*\]/p' $FILE_NAME | sed -e 's/\[\(.*\)\]/\1/g'`
}

function count_items_in_segment
{
    items=`sed -n '/\['$1'\]/,/\[.*\]/p' $FILE_NAME | grep -v '^#'| grep -v '^$' | grep -v '\[.*\]'`
    index=0
    for item in $items
    do
        index=`expr $index + 1`
    done
    
    echo $index
}

mySegs=`get_mysql_segment`
number=0
for mySeg in $mySegs
do
    segInd=`count_items_in_segment $mySeg`
    number=`expr $number + 1`
    echo "$number: $mySeg $segInd"
done

