# Image-Mode-Demo  

This is a collection of ansible rolls to setup a demo of RHEL Image Mode with a pipeline from demo.redhat.com

This is meant to be run as an Ansible Playbook.  To use:

* Checkout this repository:

```text
git clone https://github.com/chipatredhat/Image-Mode-Demo.git
```

* Install the required collections:

```text
ansible-galaxy collection install -r Image-Mode-Demo/ansible/requirements.yml
```

* Populate Image-Mode-Demo/ansible/credentials.yml with your credentials (**REQUIRED** unless you are passing the values on the command line)

* Edit the inventory file at Image-Mode-Demo/ansible/inventory.ini

  ***NOTE**: Use the values from the deployed systems provision messages to fill in ansible_host= ansible_port= ansible_ssh_pass=*
  
* Run the playbook

```text
ansible-playbook Image-Mode-Demo/ansible/setup-demo.yml -i ansible/inventory.ini
```

OR

```text
cd ansible
ansible-playbook Image-Mode-Demo/ansible/setup-demo.yml
```

* If you wish to prep the environment for just the workflow portion of the workshop, set the PREP_WORKFLOW environment variable to true

```text
ansible-playbook Image-Mode-Demo/ansible/setup-demo.yml -e PREP_WORKFLOW=True
```
