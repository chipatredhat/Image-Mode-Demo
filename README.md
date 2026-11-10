# Image-Mode-Demo  


This is a collection of ansible roles to setup a demo of RHEL Image Mode with a pipeline from demo.redhat.com

This is meant to be run as an Ansible Playbook.  To use:

* Checkout this repository:

```text
git clone https://github.com/chipatredhat/Image-Mode-Demo.git
```

* Install the required collections:

```text
ansible-galaxy collection install -r Image-Mode-Demo/ansible/requirements.yml
```

* Copy Image-Mode-Demo/ansible/credentials.yml.example to Image-Mode-Demo/ansible/credentials.yml and populate it with your credentials (**REQUIRED** unless you are passing the values on the command line).  credentials.yml is ignored by git so your tokens are never committed.

```text
cp Image-Mode-Demo/ansible/credentials.yml.example Image-Mode-Demo/ansible/credentials.yml
```

* Edit the inventory file at Image-Mode-Demo/ansible/inventory.ini

  ***NOTE**: Use the values from the deployed systems provision messages to fill in ansible_host= ansible_port= ansible_ssh_pass=*
  
* Run the playbook

```text
ansible-playbook Image-Mode-Demo/ansible/setup-demo.yml -i Image-Mode-Demo/ansible/inventory.ini
```

OR

```text
cd Image-Mode-Demo/ansible
ansible-playbook setup-demo.yml
```

* If you wish to prep the environment for just the workflow portion of the workshop, set the PREP_WORKFLOW environment variable to true

```text
ansible-playbook Image-Mode-Demo/ansible/setup-demo.yml -e PREP_WORKFLOW=True
```

* If you wish to partition and mount a second disk at /var/lib/libvirt/images (required in RHDP) set
```text
-e PARTITION_DISK=True
```
