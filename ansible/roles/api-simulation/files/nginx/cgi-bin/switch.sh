#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><meta http-equiv='refresh' content='5;url=/useapi.php'></head>"
echo "<body style='font-family:sans-serif; padding:20px;'>"
echo "<center>"
echo "<h1>Switching to RHEL 10 on Petclinic Application Server and rebooting</h1><hr><pre></center>"
sudo -i -u lab-user tmux new-session -d -s switch 'ansible-playbook -vvv /home/lab-user/ansible/switch.yaml -i appserver, 2>&1 > /tmp/switch_output.txt'
echo "</pre>"
echo "</body></html>"