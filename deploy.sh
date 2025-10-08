#!/bin/bash
# Download this script to your preferred location and make it executeable with: 
# curl -sO https://raw.githubusercontent.com/chipatredhat/Image-Mode-Demo/refs/heads/main/deploy.sh && chmod +x deploy.sh
# Now simply run this script to deploy Image-Mode-Workshop with ./deploy.sh
### NOTE:  This script will self update if there are updates, so once it is deployed, you shouldn't ever have to check for later versions, just run it

VERSION=2025100601

# Display help if requested:
[[ "${1}" = "-h" ]] || [[ "${1}" = "--help" ]] && printf "\n\nUsage: %s \n\n" "$0" && exit

# UPDATE
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

# GET_CREDENTIALS
CREDENTIALS_DIRECTORY=./ansible
API_TOKEN=$(grep OFFLINE_TOKEN ${CREDENTIALS_DIRECTORY}/credentials.yml | awk '{print $2}')
REGISTRY_TOKEN=$(grep PMPASSWORD ${CREDENTIALS_DIRECTORY}/credentials.yml | awk '{print $2}')
REGISTRY_ACCOUNT=$(grep PMUSERNAME ${CREDENTIALS_DIRECTORY}/credentials.yml | awk '{print $2}')

# CHECK_API_TOKEN
if [ "${API_TOKEN}" = "" ] ; then
    echo -e "\n\nYour API Token isn't stored in ${CREDENTIALS_DIRECTORY}/credentials.yml.  If you do not currently have one, you can create one at https://access.redhat.com/management/api"
    read -p "What is your API Token? " API_TOKEN
    echo -e "\n"
    read -n1 -p "Would you like to save your API Token to ${CREDENTIALS_DIRECTORY}/credentials.yml to allow deployments to automatically build? (Y/N) " SAVE_API_TOKEN
    if [ "${SAVE_API_TOKEN}" = "Y" ] || [ "${SAVE_API_TOKEN}" = "y" ] ; then
        sed -i '' -e "s|OFFLINE_TOKEN: .*|OFFLINE_TOKEN: ${API_TOKEN}|g" ${CREDENTIALS_DIRECTORY}/credentials.yml
    fi
fi

# CHECK_REGISTRY_TOKEN
if [ "${REGISTRY_TOKEN}" = "" ] ; then
    echo -e "\n\nYour Registry Token isn't stored in ${CREDENTIALS_DIRECTORY}/credentials.yml.   If you do not currently have one, you can create one at https://access.redhat.com/terms-based-registry"
    read -p "What is your Registry Token? " REGISTRY_TOKEN
    echo -e "\n"
    read -n1 -p "Would you like to save your  Registry Token to ${CREDENTIALS_DIRECTORY}/credentials.yml to allow deployments to automatically build? (Y/N) " SAVE_REGISTRY_TOKEN
    if [ "${SAVE_REGISTRY_TOKEN}" = "Y" ] || [ "${SAVE_REGISTRY_TOKEN}" = "y" ] ; then
        sed -i '' -e "s|PMPASSWORD: .*|PMPASSWORD: ${REGISTRY_TOKEN}|g" ${CREDENTIALS_DIRECTORY}/credentials.yml
    fi
fi

# CHECK_REGISTRY_ACCOUNT
if [ "${REGISTRY_ACCOUNT}" = "" ] ; then
    echo -e "\n\nYour Registry Account Name isn't stored in ${CREDENTIALS_DIRECTORY}/credentials.yml.   If you do not currently have one, you can create one at https://access.redhat.com/terms-based-registry"
    read -p "What is your Registry Account Name? " REGISTRY_ACCOUNT
    echo -e "\n"
    read -n1 -p "Would you like to save your Registry Account Name to ${CREDENTIALS_DIRECTORY}/credentials.yml to allow deployments to automatically build? (Y/N) " SAVE_REGISTRY_ACCOUNT
    if [ "${SAVE_REGISTRY_ACCOUNT}" = "Y" ] || [ "${SAVE_REGISTRY_ACCOUNT}" = "y" ] ; then
        sed -i '' -e "s|PMUSERNAME: .*|PMUSERNAME: ${REGISTRY_ACCOUNT}|g" ${CREDENTIALS_DIRECTORY}/credentials.yml
    fi
fi

# VERIFY_API_TOKEN
token=$(curl -s https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token -d grant_type=refresh_token -d client_id=rhsm-api -d refresh_token=$API_TOKEN | jq --raw-output .access_token)
if [ "${token}" = "null" ] ; then
    echo "Your API Token is not valid.  Please create an updated token at https://access.redhat.com/management/api"
    read -p "Press any key to restart this script and enter a new API Token or Ctrl-C to escape" -n1 -s
    exec bash "$0" "$@" # Have script restart after updating
fi

read -n1 -p "Are you deploying into a CNV Baremetal instance from demo.redhat.com? (Y/N) " RHDP
echo -e "\n"

if  [ "${RHDP}" = "Y" ] || [ "${RHDP}" = "y" ] ; then
[[ -z $1 ]] && read -p "What is the opcv0# of the demo server.  EX: ssh.opcv09.rhdp.net is 9? " CNVHOST || CNVHOST=${1}
[[ -z $2 ]] && read -p "What port is used for ssh? " CNVPORT || CNVPORT=${2}
[[ -z $3 ]] && read -p "What is the default password? " CNVPASS || CNVPASS=${3}
else
[[ -z $1 ]] && read -p "What is IP address or hostname of the server to build? " CNVHOST || CNVHOST=${1}
read -p "Do you need to partition a second disk? (Y/N) " PARTITION_DISK
[[ -z $3 ]] && read -p "Do you need to use a password to connect to the server? (Y/N) " USE_PASS
if [ "${USE_PASS}" = "Y" ] || [ "${USE_PASS}" = "y" ] ; then
    read -s -p "What is the password to connect to the server? " CNVPASS
    echo -e "\n"
echo -e "\n"
fi

# Ask if this should deploy the full pipeline:
read -n1 -p "Do you wish to install the full pipeline? (Y/N) " INSTALL_PIPELINE
echo -e "\n"

# We should now have all the info we need, so let's run the playbook: