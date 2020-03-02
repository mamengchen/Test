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
        return
    fi
    pro_cpu=`ps aux | awk -v pid=$1 '$2==pid{print $3}'`
    pro_mem=`ps aux | awk -v pid=$1 '$2==pid{print $4}'`
    pro_start_time=`ps -p $1 -o lstart | grep -v STARTED`
}


function is_process_in_config
{
    for pn in `get_all_process`;
    do
        if [ "$1" == "$pn" ];then
            return
        fi
    done
    return 1
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

function get_group_by_process_name
{
    for g_li in `get_all_group`;
    do
        for p_li in `get_all_process_by_group $g_li`;
        do
            if [ $1 == $p_li ];then
                echo "$g_li"
            fi
        done
    done
    return
}


function format_print
{
    ps -ef | grep $1 | grep -v grep | grep -v $0  &>/dev/null
    if [ $? -eq 0 ];then
        pids=`get_process_pid_by_name $1`
        for pid_li in $pids;
        do
            get_process_info_by_pid $pid_li
            awk -v p_name=$1 \
                -v g_name=$2 \
                -v p_status=$pro_status \
                -v p_pid=$pid_li \
                -v p_cpu=$pro_cpu \
                -v p_mem=$pro_mem \
                -v p_start_time="$pro_start_time" \
                'BEGIN{printf "%-25s%-20s%-20s%-20s%-20s%-20s%-25s\n",p_name,g_name,p_status,p_pid,p_cpu,p_mem,p_start_time}'
        done
    else
            
            awk -v p_name=$1 \
                -v g_name=$2 \
                -v p_status="STOPED" \
                'BEGIN{printf "%-25s%-20s%-20s%-20s%-20s%-20s%-25s\n",p_name,g_name,p_status,"NULL","NULL","NULL","NULL"}'

    fi
}


awk 'BEGIN{printf "%-25s%-20s%-20s%-20s%-20s%-20s%-25s\n","PROCESS","GROUP","STATUS","PID","CPU","MEM","DATA"}'

if [ ! -e $HOME_DIR/$CONFIG_FILE ]; then
    echo "$CONFIG_FILE is not exit"
    exit 1
else
    if [ $# -gt 0 ];then
        if [ "$1" == "-g" ];then
            shift
            for gn in $@;do
                is_group_in_config $gn || continue
                for pn in `get_all_process_by_group $gn`;do
                    is_process_in_config $pn && format_print $pn $gn
                done
            done
        else
            for pn in $@;do
                gn=`get_group_by_process_name $pn`
                is_process_in_config $pn && format_print $pn $gn
            done
        fi
    else
        gns=`get_all_group`
        for gn in $gns;do
            for pn in `get_all_process_by_group $gn`;do
                format_print $pn $gn
            done
        done
    fi
fi
