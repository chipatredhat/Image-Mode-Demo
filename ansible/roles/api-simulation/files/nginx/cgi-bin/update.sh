#!/bin/bash
curl -s -k -c - -X POST --user 'admin:redhat' https://aap.acme.com/api/controller/v2/job_templates/16/launch/
