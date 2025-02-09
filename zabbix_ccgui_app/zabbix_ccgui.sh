#!/bin/bash
TERM=linux


p="$1 $2"
echo $p
if [ -n "$1" ]
then
response_time=$(cat 20230414.json | grep -w -e "$p" | grep -o '"response_time":"[^"]*' | grep -o '[^"]*$' | awk '{print $0}' ORS=',')
echo $response_time
IFS="," read -r -a customArray <<< $response_time
echo ${customArray[@]}
else
echo "No parameters found. Parameter is name of process. Use for example 'mysqld'"
fi


while [ -n "$1" ]
do
case "$1" in




-p) p="$2"
if [ -n "$2" ]
then
comm=$(cat 20230414.json | grep -w $p | grep -o '"response_time":"[^"]*' | grep -o '[^"]*$')
echo $comm
else
echo "No parameters found. Parameter is name of process. Use for example 'mysqld'"
fi
shift ;;

-j) p="$2"
if [ -n "$2" ]
then
comm=$(grep -o '"'${p}'":"[^"]*' 20230414.json | grep -o '[^"]*$' | awk '{print $0}' ORS=',')
IFS="," read -r -a customArray <<< $comm
echo ${customArray[@]}
else
echo "No parameters found. Parameter is name of process. Use for example 'mysqld'"
fi
shift ;;







esac
shift
done