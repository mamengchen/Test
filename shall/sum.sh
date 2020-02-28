#!/bin/bash


while true
do
    read -p "pls your is a number: " number
    expr $number + 1 &> /dev/null
    if [ $? -eq 0 ];then
        if [ `expr $number \> 0` -eq 1 ];then
            for((i=1;i<= $number;i++))
            do
                sum=`expr $sum + $i`
            done
            echo "1 + 2 + 3 +....+  $number = $sum"
            exit
        fi
    fi
    echo 'scanf is error,continue'
    continue

done
