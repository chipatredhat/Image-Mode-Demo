#!/bin/bash

# Display help if requested:
[[ "${1}" = "-h" ]] || [[ "${1}" = "--help" ]] && printf "\n\nUsage: %s [opcv0#] [ssh port] [password] \n\n" "$0" && exit

# Get the path for the directory we are currently in
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Use a local credentials file if it exists
if [ -f "~/.secrets/credentials.yml" ] ; then
    CREDENTIALS_FILE=~/.secrets/credentials.yml
else
    CREDENTIALS_FILE=${SCRIPT_DIR}/ansible/credentials.yml
fi

# Read our credentials into variables if they are set
API_TOKEN=$(grep OFFLINE_TOKEN ${CREDENTIALS_FILE} | awk '{print $2}')
REGISTRY_TOKEN=$(grep PMPASSWORD ${CREDENTIALS_FILE} | awk '{print $2}')
REGISTRY_ACCOUNT=$(grep PMUSERNAME ${CREDENTIALS_FILE} | awk '{print $2}')

# Ensure we have the latest from git
git pull
 
# Import functions
source ${SCRIPT_DIR}/bin/functions

# Run deployment
CHECK_API_TOKEN
CHECK_REGISTRY_TOKEN
CHECK_REGISTRY_ACCOUNT
VERIFY_API_TOKEN
GET_BUILD_PARAMETERS
WRITE_FILES
INSTALL_DEMO
