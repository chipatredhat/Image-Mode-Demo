#!/bin/bash
# Make and push rhel9-soe
cd /home/lab-user/Workshop
podman build -f Containerfile-new --tag registry.example.com:5000/rhel9/rhel-bootc:latest
podman push registry.example.com:5000/rhel9/rhel-bootc:latest

# Start runner. ????
/home/lab-user/runner/start_runner.sh

# Copy across files
CONTENTDIR=/home/lab-user/Workshop/content
mkdir -p ${CONTENTDIR}/{petclinic,petclinic/files}
cp /tmp/ImageModeWorkshop/files/{local.repo,local10.repo,spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar,petclinic.sql,petclinic.service,build_petclinic.yaml} ${CONTENTDIR}/petclinic/files
cp /tmp/ImageModeWorkshop/files/Containerfile-app-RHEL9 ${CONTENTDIR}/petclinic/Containerfile9
cp /tmp/ImageModeWorkshop/files/Containerfile-rhel10-app-21 ${CONTENTDIR}/petclinic/Containerfile10
cd /home/lab-user/git/petclinic
cp -a ${CONTENTDIR}/petclinic/* .
mkdir -p .gitea/workflows
mv files/build_petclinic.yaml /home/lab-user/git/petclinic/.gitea/workflows/build_petclinic.yaml
git config --global user.name "lab-user" && git config --global user.email "lab-user@example.com"
