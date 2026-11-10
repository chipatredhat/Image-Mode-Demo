#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><meta http-equiv='refresh' content='5;url=/useapi.php'></head>"
echo "<body style='font-family:sans-serif; padding:20px;'>"
echo "<center>"
echo "<h1>Switching to RHEL 10 on Petclinic Application Server and rebooting</h1><hr><pre></center>"
sudo -H -u lab-user /usr/local/bin/petclinic-api switch
echo "</pre>"
echo "</body></html>"