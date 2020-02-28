#!/bin/bash


function get_users
{
    users=`cat /etc/passwd | cut -d: -f1`
    echo $users
}

users_list=`get_users`

index=1
for u in $users_list
do
    echo "this is $index user $u"
    index=$(($index+1))
done

