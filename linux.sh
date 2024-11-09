#!/usr/bin/env bash

ETC_HOSTS="/etc/hosts"
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

IP="127.0.0.1"
HOSTNAME="s.optifine.net s-optifine.lunarclientcdn.com"
HOSTS_LINE="$IP[[:space:]]$HOSTNAME"

function uninstall() {
    echo -e "${BLUE}======= PiCapes Legacy Installer =======${NC}"
    
    # Backup /etc/hosts
    sudo cp $ETC_HOSTS "$ETC_HOSTS.bak"
    
    # Remove all lines containing s.optifine.net
    if [ -n "$(grep -P 's.optifine.net' $ETC_HOSTS)" ]; then
        sudo sed -i "/s.optifine.net/d" $ETC_HOSTS
    fi

    # Remove all lines containing s-optifine.lunarclientcdn.com
    if [ -n "$(grep -P 's-optifine.lunarclientcdn.com' $ETC_HOSTS)" ]; then
        sudo sed -i "/s-optifine.lunarclientcdn.com/d" $ETC_HOSTS
    fi

    # Confirmation
    if [ -z "$(grep -P 's.optifine.net' $ETC_HOSTS)" ] && [ -z "$(grep -P 's-optifine.lunarclientcdn.com' $ETC_HOSTS)" ]; then
        echo -e "${GREEN}Uninstall successful! PiCapes has been uninstalled from your system.${NC}"
    else
        echo -e "${RED}Uninstall failed. PiCapes may still be present.${NC}"
    fi
}

function install() {
    echo -e "${BLUE}======= PiCapes Legacy Installer =======${NC}"
    line_content=$( printf "%s\t%s\n" "$IP" "$HOSTNAME" )

    # Backup /etc/hosts
    sudo cp $ETC_HOSTS "$ETC_HOSTS.bak"
    
    # Remove all lines containing s.optifine.net
    if [ -n "$(grep -P 's.optifine.net' $ETC_HOSTS)" ]; then
        sudo sed -i "/s.optifine.net/d" $ETC_HOSTS
    fi

    # Remove all lines containing s-optifine.lunarclientcdn.com
    if [ -n "$(grep -P 's-optifine.lunarclientcdn.com' $ETC_HOSTS)" ]; then
        sudo sed -i "/s-optifine.lunarclientcdn.com/d" $ETC_HOSTS
    fi
    
    # Add line to install PiCapes on your system.
    if [ -n "$(grep -P $HOSTS_LINE $ETC_HOSTS)" ]
    then
        echo -e "${RED}PiCapes is already installed : ${YELLOW}$(grep $HOSTNAME $ETC_HOSTS)${NC}"
    else
        echo -e "${YELLOW}Installing PiCapes...${NC}";
        sudo sh -c "echo '$line_content' >> /etc/hosts";

        if [ -n "$(grep -P $HOSTNAME $ETC_HOSTS)" ]
        then
            echo -e "${GREEN}PiCapes was installed succesfully!${NC}";
        else
            echo -e "${RED}Failed to install PiCapes, Try again.${NC}";
        fi
    fi
}

if [ $# -eq 0 ]
then
    echo -e "${BLUE}======= PiCapes Legacy Installer =======${NC}"
    echo -e "${RED}Please supply an argument (install/uninstall) and try again.${NC}"
    exit 1
fi
