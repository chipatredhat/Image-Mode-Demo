#!/bin/bash

# The following command uses the Ansible AAP API to run a job template
#curl -s -k -c - -X POST --user 'admin:redhat' https://aap.acme.com/api/controller/v2/job_templates/17/launch/

# This command runs a local playbook when AAP isn't available
cd /home/lab-user/ansible
sudo -u lab-user ansible-playbook switch.yaml
