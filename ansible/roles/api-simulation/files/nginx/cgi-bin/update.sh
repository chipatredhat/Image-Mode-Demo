#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><meta http-equiv='refresh' content='5;url=/useapi.php'></head>"
echo "<body style='font-family:sans-serif; padding:20px;'>"
echo "<center>"
echo "<h1>Running update on Petclinic Application Server and rebooting</h1><hr><pre></center>"
sudo -i -u lab-user tmux new-session -d -s update 'ansible-playbook -vvv /home/lab-user/ansible/update.yaml -i appserver, 2>&1 > /tmp/update_output.txt'
echo "</pre>"
echo "</body></html>"