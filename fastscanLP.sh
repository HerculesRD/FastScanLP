#!/bin/bash

int_handler()
{
    echo -e "\n${L_PURPLE}[+]Saliendo...${NC}"
    tput cnorm #Retorning pointer
    # Kill the parent process of the script.
    #kill $PPID
    exit 1
}

trap 'int_handler' INT


YELLOW='\033[1;33m'
L_PURPLE='\033[1;35m'
L_GREEN='\033[1;32m'
NC='\033[0m'
flagH=0
flagP=0
flagl=0

usage()
{
        echo -e "${YELLOW}Uso del script: ${NC}"
        echo -e "${YELLOW}              ./fastscanLP.sh -H <IP> [-m]${NC}"
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
                        echo -e "${L_PURPLE}[+]Comenzando el escaneo de todos los puertos en $IPaddr...${NC}"
                        date
                        if [[ $1 = 1 ]]; then
                                echo -en "${L_GREEN}Lista de puertos abiertos: ${NC}"
                                tput civis; for port in $(seq 1 65535); do
                                        timeout 1 bash -c "echo > /dev/tcp/${IPaddr}/$port" 2>/dev/null && echo -en "${port}," &
                                done; wait; tput cnorm
                                echo -e "${L_GREEN} ${OpenPortsList} ${NC}"
                                echo -e "${L_PURPLE}[+]FIN${NC}"
                                date
                                exit 0
                        elif [[ $1 = 0 ]]; then
                                tput civis; for port in $(seq 1 65535); do
                                        timeout 1 bash -c "echo > /dev/tcp/${IPaddr}/$port" 2>/dev/null && echo -e "${L_GREEN}PUERTO $port - ABIERTO${NC}" &
                                        if [[ $port = 15000 ]]; then
                                                echo -e "${YELLOW}[+]25% Terminado...${NC}"
                                        elif [[ $port = 33000 ]]; then
                                                echo -e "${YELLOW}[+]50% Terminado...${NC}"
                                        elif [[ $port = 45000 ]]; then
                                                echo -e "${YELLOW}[+]75% Terminado... ${NC}"
                                        elif [[ $port = 60000 ]]; then
                                                echo -e "${YELLOW}[+]Ya falta muy poquito...${NC}"
                                        fi
                                done; wait; tput cnorm
                                echo -e "${L_GREEN} ${OpenPortsList} ${NC}"
                                echo -e "${L_PURPLE}[+]FIN${NC}"
                                date
                                exit 0
                        fi
}

parseIP()
{
        for i in $(seq 1 4); do
                if [[ $(echo "$1" | cut -d. -f$i) -ge 0 ]] && [[ $(echo "$1" | cut -d. -f$i) -le 255 ]]; then :
                else
                        echo
                        echo -e "${YELLOW}La IP ${1} es incorrecta ${NC}"
                        echo -e "${L_PURPLE}[+]Saliendo...${NC}"
                        exit 1
                fi
        done
}

while getopts ":H:l" opt; do
        case "${opt}" in

                H)
                        flagH=1
                        IPaddr=${OPTARG}
                        ;;

                d)
                        flagD=1
                        DNSaddr=${OPTARG}
                        ;;

                l)
                        flagl=1
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
        parseIP $IPaddr
        if [[ "$flagl" = 1 ]]; then
                scan 1
        elif [[ "$flagl" = "0" ]]; then
                scan 0
        else
                usage
        fi

fi
