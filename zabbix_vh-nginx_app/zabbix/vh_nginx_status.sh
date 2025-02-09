#!/bin/bash

while [ -n "$1" ]; do
  case "$1" in

  -l)
    output=$(curl -s http://127.0.0.1:80/vh_nginx_status | jq .serverZones | jq -c 'keys')
    curl=$(echo "${output:1:-1}")

    IFS="," read -r -a customArray <<<$curl

    json="["

    for ((c = 0; c < ${#customArray[@]}; c++)); do
      if ((c == $((${#customArray[@]} - 1)))); then
        json+="{\"{#ZONE}\":${customArray[c]}}"
      else
        json+="{\"{#ZONE}\":${customArray[c]}},"
      fi
    done

    json="${json%,}"
    json+="]"
    echo "$json"
    shift
    ;;

  -d)
    p="$2"
    json=$(curl -s http://127.0.0.1:80/vh_nginx_status | jq --arg p "$p" '.serverZones[$p]')
    echo $json
    shift
    ;;

  esac
  shift
done

