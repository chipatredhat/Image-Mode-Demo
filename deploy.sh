#!/bin/bash
# Download this script to your preferred location and make it executeable with: 
# curl -sO https://raw.githubusercontent.com/chipatredhat/Image-Mode-Demo/refs/heads/main/deploy.sh && chmod +x deploy.sh
# Now simply run this script to deploy Image-Mode-Workshop with ./deploy.sh
### NOTE:  This script will self update if there are updates, so once it is deployed, you shouldn't ever have to check for later versions, just run it

VERSION=2025100601

# Display help if requested:
[[ "${1}" = "-h" ]] || [[ "${1}" = "--help" ]] && printf "\n\nUsage: %s \n\n" "$0" && exit

function UPDATE() {
# Check if this is the latest version and update if not:
GITVER=$(curl -s https://raw.githubusercontent.com/chipatredhat/Image-Mode-Demo/refs/heads/main/deploy.sh | grep VERSION | head -1 | cut -d = -f 2)
if test ${GITVER} -gt ${VERSION} ; then
    sudo rm -f $0
    sudo curl -s https://raw.githubusercontent.com/chipatredhat/Image-Mode-Demo/refs/heads/main/deploy.sh > $0
    sudo chmod +x $0
    echo -e "\n\nThis script has been updated and is relaunching\n\n"
    exec bash "$0" "$@" # Have script restart after updating
    exit  # Just a failsafe in case the update goes awry
fi
}

function GET_CREDENTIALS() {
CREDENTIALS_DIRECTORY=./ansible
API_TOKEN=$(grep OFFLINE_TOKEN ${CREDENTIALS_DIRECTORY}/credentials.yml | awk '{print $2}')
REGISTRY_TOKEN=$(grep PMPASSWORD ${CREDENTIALS_DIRECTORY}/credentials.yml | awk '{print $2}')
REGISTRY_ACCOUNT=$(grep PMUSERNAME ${CREDENTIALS_DIRECTORY}/credentials.yml | awk '{print $2}')
}

function CHECK_API_TOKEN() {
if [ ! -f ${API_TOKEN} ] ; then
    echo -e "\n\nYour API Token isn't stored in ${CREDENTIALS_DIRECTORY}/credentials.yml.  If you do not currently have one, you can create one at https://access.redhat.com/management/api"
    read -p "What is your API Token? " API_TOKEN
    echo -e "\n"
    read -n1 -p "Would you like to save your API Token to ${CREDENTIALS_DIRECTORY}/credentials.yml to allow deployments to automatically build? (Y/N) " SAVE_API_TOKEN
    if [ "${SAVE_API_TOKEN}" = "Y" ] || [ "${SAVE_API_TOKEN}" = "y" ] ; then
        sed -i '' -e "s|OFFLINE_TOKEN: .*|OFFLINE_TOKEN: ${API_TOKEN}|g" ${CREDENTIALS_DIRECTORY}/credentials.yml
    fi
fi
}

UPDATE
GET_CREDENTIALS
CHECK_API_TOKEN
