#!/bin/bash

user="mmc"
password="123456"
host="127.0.0.1"

SQL="$2"
Database="$1"

mysql -u"$user" -p"$password" -h "$host" -D "$Database" -e "$SQL"
