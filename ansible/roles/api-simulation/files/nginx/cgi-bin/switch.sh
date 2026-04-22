#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><meta http-equiv='refresh' content='3;url=/useapi.php'></head>"
echo "<body style='font-family:sans-serif; padding:20px;'>"
echo "<center>"
echo "<h1>Switching to RHEL 10 on Petclinic Application Server</h1><hr><pre></center>"
sudo -u lab-user ansible-playbook -v /home/lab-user/ansible/switch.yaml -i appserver, 2>&1
echo "</pre>"
echo "</body></html>"