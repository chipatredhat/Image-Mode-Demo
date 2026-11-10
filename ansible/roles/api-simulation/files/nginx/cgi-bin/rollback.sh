#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><meta http-equiv='refresh' content='5;url=/useapi.php'></head>"
echo "<body style='font-family:sans-serif; padding:20px;'>"
echo "<center>"
echo "<h1>Running rollback on Petclinic Application Server and rebooting into previous image</h1><hr><pre></center>"
sudo -H -u lab-user /usr/local/bin/petclinic-api rollback
echo "</pre>"
echo "</body></html>"
