#!/bin/bash

# The following command uses the Ansible AAP API to run a job template
#curl -s -k -c - -X POST --user 'admin:redhat' https://aap.acme.com/api/controller/v2/job_templates/15/launch/

# This command runs a local playbook when AAP isn't available
ansible-playbook /home/lab-user/ansible/rollback.yaml
