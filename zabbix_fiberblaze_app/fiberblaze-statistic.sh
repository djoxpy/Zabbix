#!/bin/bash
TERM=linux

while [ -n "$1" ]; do
    case "$1" in

    -J)
        debug () {
            echo "========================== Debug =============================="
            echo "Card:  $card  |  Port:  $port"
        }

        network_cards=$(/opt/fiberblaze/bin/cardstat -l | grep "Network card:" | uniq | awk '{print $3}')

        declare -A ports_array

        for card in $network_cards; do
            ports_array["$card"]=$(/opt/fiberblaze/bin/cardstat -l -d "$card" | grep "Port" | tr -d 'Port' | tr ' ' '\n' | grep -v "^$")
        done

        json="["
        for card in "${!ports_array[@]}"; do
            for port in ${ports_array[$card]}; do
                json+="{\"{#CARD}\":\"$card\",\"{#PORT}\":\"$port\"},"        
                #debug
            done     
        done
        json="${json%,}"
        json+="]"

        echo "$json"

    shift
    ;;


    -p)
        card="$2"
        port="$3"

        speed () {
            speed=$(/opt/fiberblaze/bin/cardstat -l -d "$card" | grep "Link speed" | awk 'FNR=='$read_line | cut -d ' ' -f $start-$finish | awk '{$1=$1};1')
            echo $speed
        }

        debug () {
            echo "=============== Debug ================="
            echo "Card   :  $card  |  Port:  $port"
            echo "RL     :  $read_line"
            echo "Start  :  $start"
            echo "Finish :  $finish"
            echo ""
        }
        
        
        case "$port" in
            "0") 
                read_line=1
                start=19
                finish=22
                speed
                #debug
            ;;
            
            "1")
                read_line=1
                start=33
                finish=36
                speed
                #debug
            ;;

            "2")
                read_line=1
                start=47
                finish=50
                speed
                #debug
            ;;

            "3")
                read_line=1
                start=61
                finish=64
                speed
                #debug
            ;;

            "4") 
                read_line=2
                start=19
                finish=22
                speed
                #debug
            ;;

            "5")
                read_line=2
                start=33
                finish=36
                speed
                #debug
            ;;

            "6")
                read_line=2
                start=47
                finish=50
                speed
                #debug
            ;;

            "7")
                read_line=2
                start=61
                finish=64
                speed
                #debug
            ;;

        esac          

    shift
    ;;


    -s)
        card="$2"
        port="$3"

        status () {
            status=$(/opt/fiberblaze/bin/cardstat -l -d "$card" | grep -E 'Link\s+:' | awk 'FNR=='$read_line | cut -d ' ' -f $start | awk '{$1=$1};1')
            echo $status
        }

        debug () {
            echo ""
            echo "=============== Debug ================="
            echo "Card      :  $card  |  Port:  $port"
            echo "RL        :  $read_line"
            echo "Position  :  $start"
        }        
        
        case "$port" in
            "0") 
                read_line=1
                start=30
                status
                #debug
            ;;
            
            "1")
                read_line=1
                start=47
                status
                #debug
            ;;

            "2")
                read_line=1
                start=64
                status
                #debug
            ;;

            "3")
                read_line=1
                start=81
                status
                #debug
            ;;

            "4") 
                read_line=2
                start=30
                status
                #debug
            ;;

            "5")
                read_line=2
                start=47
                status
                #debug
            ;;

            "6")
                read_line=2
                start=64
                status
                #debug
            ;;

            "7")
                read_line=2
                start=81
                status
                #debug
            ;;
        esac          

    shift
    ;;

    -S)
        card="$2"
        port="$3"

        bandwidth=$(/opt/fiberblaze/bin/cardstat -S -F RBPS,TBPS -d $card --ports $port -v 4 -n 1 | awk 'FNR=='2)
        echo $bandwidth

    shift
    ;;
   
    # *) echo "$1 is not an option";;
    esac
    shift
done







