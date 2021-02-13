#!/bin/bash

int_handler()
{
    echo -e "\n${L_PURPLE}[+]Exiting...${NC}"
    tput cnorm #Retorning pointer
    # Kill the parent process of the script.?
    #kill $PPID
    exit 1
}

trap 'int_handler' INT

#Colors!
YELLOW='\033[1;33m'
BRed='\033[1;31m'
L_PURPLE='\033[1;35m'
L_GREEN='\033[1;32m'
NC='\033[0m'
#Just flags
flagH=0
flagP=0
flagl=0
flag6=0
IPcant=0


usage()
{
        echo -e "${YELLOW}Script usage: ${NC}"
        echo -e "${YELLOW}              ./fastscanLP.sh < -H <IP> | -D <DNS> > [-l] [-6] ${NC}"
        exit 1
}

scan()
{
                        #BANNER
                        echo -e "${YELLOW}           ____              __                             __     ____  ${NC}"
                        echo -e "${YELLOW}          / __/____ _ _____ / /_ _____ _____ ____ _ ____   / /    / __ \ ${NC}"
                        echo -e "${YELLOW}         / /_ / __  // ___// __// ___// ___// __  // __ \ / /    / /_/ / ${NC}"
                        echo -e "${YELLOW}        / __// /_/ /(__  )/ /_ (__  )/ /__ / /_/ // / / // /___ / ____/  ${NC}"
                        echo -e "${YELLOW}       /_/   \__,_//____/ \__//____/ \___/ \__,_//_/ /_//_____//_/       ${NC}"
                        echo ""
                        parsedList2=$(echo -en "$parsedList" | sed 's/ /, /g')
                        echo -e "${L_PURPLE}[+]Starting the scanner for 65535 ports in ${parsedList2}...${NC}"
                        
                        date
                        
                        #mientras tenga ips para scanear que haga este marote

                        for IPSelect in $parsedList ; do
                            if [[ $1 = 1 ]]; then
                                    echo -en "${L_GREEN}Open ports list for ${IPSelect}: ${NC}"
                                    tput civis; for port in $(seq 1 65535); do
                                            timeout 1 bash -c "echo > /dev/tcp/${IPSelect}/$port" 2>/dev/null && echo -en "${port}," &
                                    done; wait; tput cnorm
                                    #echo -e "${L_GREEN} ${OpenPortsList} ${NC}"
                            elif [[ $1 = 0 ]]; then
                                    echo -e "${L_GREEN}Open ports list for ${IPSelect}: ${NC}"
                                    tput civis; for port in $(seq 1 65535); do
                                            timeout 1 bash -c "echo > /dev/tcp/${IPSelect}/$port" 2>/dev/null && echo -e "${L_GREEN}PUERTO $port - OPEN${NC}" &
                                            if [[ $port = 15000 ]]; then
                                                    echo -e "${YELLOW}[+]25% progress...${NC}"
                                            elif [[ $port = 33000 ]]; then
                                                    echo -e "${YELLOW}[+]50% progress...${NC}"
                                            elif [[ $port = 45000 ]]; then
                                                    echo -e "${YELLOW}[+]75% progress... ${NC}"
                                            elif [[ $port = 60000 ]]; then
                                                    echo -e "${YELLOW}[+]Sooo little...${NC}"
                                            fi
                                    done; wait; tput cnorm
                                    #echo -e "${L_GREEN} ${OpenPortsList} ${NC}"
                            fi
                        done
                        echo -e "${L_PURPLE}[+]THE END${NC}"
                        date
                        exit 0
}

parseIP()
{
        for i in $(seq 1 4); do
                if [[ $(echo "$1" | cut -d. -f$i) -ge 0 ]] && [[ $(echo "$1" | cut -d. -f$i) -le 255 ]]; then 
                        IPcant=1
                else
                        echo
                        echo -e "${YELLOW}IP ${1} isnt correct ${NC}"
                        echo -e "${L_PURPLE}[+]Exiting...${NC}"
                        exit 1
                fi
        done
}

resDNS()
{
    IPstring=$(getent ahosts $1 | awk '{ print $1 }' | sort -u | tr '\r\n' ' ')
    
    #IP Amount
    IPcant=$(echo "$IPstring" | wc -w)
    
    if [[ $IPcant -eq 0 ]]; then
        echo -e "${YELLOW}DNS $DNSaddr couldn't be resolved ${NC}" #such a simple parser, right?
        echo -e "${L_PURPLE}[+]Exiting...${NC}"
        exit 1 
    else
        :
    fi
}

while getopts ":H:D:l6" opt; do
        case "${opt}" in

                H)
                        flagH=1
                        IPaddr=${OPTARG}
                        ;;

                D)
                        flagD=1
                        DNSaddr=${OPTARG}
                        ;;

                l)
                        flagl=1
                        ;;

                6)
                        flag6=1
                        ;;

                *)
                        usage
                        ;;

        esac
done

#parsing options
if [[ $flagH = 0 && $flagD = 0 ]]; then
    usage
else
    echo -e "\n\n"
    if [[ $flagH = 1 ]]; then
        if [[ $flag6 = 1 ]]; then
            echo -e "${BRed}Remember that IPv6 doesnt have parser. Check the typing twice, please.\n ${NC}"
        else
            parseIP $IPaddr
        fi
        parsedList=$IPaddr
    else # It should be flagD=0
        resDNS $DNSaddr
        parsedList=$IPstring
    fi
        if [[ "$flagl" = 1 ]]; then
                scan 1
        elif [[ "$flagl" = "0" ]]; then
                scan 0
        else
                usage
        fi

fi
