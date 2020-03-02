#!/bin/bash

ftp -inv << EOF
    open 172.16.232.141
    user userftp 123456

    cd /home/userftp/workspace
    put $1
EOF
