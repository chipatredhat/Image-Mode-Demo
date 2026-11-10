#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><meta http-equiv='refresh' content='5;url=/useapi.php'></head>"
echo "<body style='font-family:sans-serif; padding:20px;'>"
echo "<center>"
echo "<h1>Running update on Petclinic Application Server and rebooting</h1><hr><pre></center>"
sudo -H -u lab-user /usr/local/bin/petclinic-api update
echo "</pre>"
echo "</body></html>"