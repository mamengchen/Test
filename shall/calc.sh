#!/bin/bash

function calcu 
{
    case $2 in
        +)
            echo "$1 + $3 = `expr $1 + $3`"
            ;;
        -)
            echo "$1 - $3 = `expr $1 - $3`"
            ;;
        mul)
            echo "scale=4;$1 * $3" | bc
            ;;
        /)
            echo "$1 / $3 = `expr $1 / $3`"
            ;;
    esac
}

calcu $1 $2 $3
