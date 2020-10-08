#!/bin/bash
# Purpose: Creates a menu of Azure subscriptions that a user has access to, for easy subscription choosing. Returns subscription id.
# Usage:  This script can be called directly to choose a subscription, and used from other scripts like so: SUBSCRIPTION=`. "$(dirname '$0')/subscription-chooser.sh"`

MENU=""
IFS=$(echo -en "\n\b")
ITEMS=0
for SUBCRIPTION in $(az account list --query "sort_by([], &name) | [?state=='Enabled'].[name, id, isDefault]" --all | jq -rc '.[] | @csv')
do
    NAME=$(echo $SUBCRIPTION | awk -F',' '{print $1}' | tr -d \" )
    ID=$(echo $SUBCRIPTION | awk -F',' '{print $2}' | tr -d \")
    IS_DEFAULT=$(echo $SUBCRIPTION | awk -F',' '{print $3}' | tr -d \")

    NAME=`printf '%-40s' "$NAME"`

    MENU+="$NAME ($ID) \n  \n"
    ITEMS=$((ITEMS + 1))
done

export NEWT_COLORS='
'
RESULT=$(whiptail --title "Azure Subscriptions" --menu "" $((ITEMS + 8)) 90 $ITEMS $(echo -e $MENU) 3>&1 1>&2 2>&3)

SUBSCRIPTION_ID=$(echo $RESULT | sed 's/.*(\(.*\))/\1/' | sed 's/\s*$//g')
if [ -z $SUBSCRIPTION_ID ]; then exit; fi

if [[ -t 1 ]]; then
    # executed directly, set the subscription
    az account set --subscription $SUBSCRIPTION_ID
    echo ""
    az account show --query "{name:name, subscriptionId:id, tenantId:tenantId}" --output table --only-show-errors
else
    # executed by another script, return the subscription id
    echo $SUBSCRIPTION_ID
fi
