#!/bin/bash
#
#   Func: Get Porcess status In process.cfg

# define var
HOME_DIR="/home/mmc/workspace/shall/process"
CONFIG_FILE="process.cfg"

function get_all_group
{
    G_LIST=`sed -n '/\[GROUP.*\]/,/\[.*\]/p' process.cfg | egrep -v "(^$|\[.*\])"`
    echo "$G_LIST"
}

function get_process_pid_by_name
{
    if [ $# -ne 1 ];then
        return 1
    else
        PIDS=`ps -ef | grep $1 | grep -v grep | grep -v $0 | awk '{print $2}'`
        echo "$PIDS"
    fi
}

function get_process_info_by_pid
{
    if [ `ps -ef | awk -v pid=$1 '$2==pid{print}' | wc -l` -eq 1 ];then
        pro_status="RUNNING"
    else
        pro_status="STOPED"
    fi
    pro_cpu=`ps aux | awk -v pid=$1 '$2==pid{print $3}'`
    pro_mem=`ps aux | awk -v pid=$1 '$2==pid{print $4}'`
    pro_start_time=`ps -p $1 -o lstart | grep -v STARTED`
}

function is_group_in_config
{
    for gn in `get_all_group`;
    do
        if [ "$1" == "$gn" ];then
            return
        fi
    done
    return 1
}

function get_all_process_by_group
{
    is_group_in_config $1
    if [ $? -eq 1 ];then
        echo "GroupName $1 is not in process.cfg"
    else
        p_list=`sed -n "/\[$1\]/,/\[.*\]/p" $HOME_DIR/$CONFIG_FILE | egrep -v "(^$|\[.*\])"`
        echo $p_list
    fi
}

function get_all_process
{
    for g in `get_all_group`;
    do
        PROCESS=`sed -n '/\['$g'.*\]/,/\[.*\]/p' process.cfg | egrep -v "(^$|\[.*\])"`
        echo "$PROCESS"
    done
}

if [ ! -e $HOME_DIR/$CONFIG_FILE ]; then
    echo "$CONFIG_FILE is not exit"
    exit 1
else
    get_all_process_by_group $1
fi
