<!DOCTYPE html>
<html>
<head>
<style>
.btn {
  border: 2px solid black;
  background-color: white;
  color: black;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
}
.green {
  border-color: #04AA6D;
  color: green;
}
.green:hover {
  background-color: #04AA6D;
  color: white;
}
</style>
</head>

<body>
<center>
<h1 style="color: red;">Automate your deployment with the Ansible API</h1>
<h2 style="color: black;">These two buttons use the Ansible API to maintain <u>petclinic.acme.com</u></h2>
<button class="btn green" onClick="document.location='http://web.acme.com/update.php'">Update and reboot petclinic.acme.com</button><P>
<button class="btn green" onClick="document.location='http://web.acme.com/switch.php'">Switch to RHEL 10 and reboot petclinic.acme.com</button><P>
<button class="btn green" onClick="document.location='http://web.acme.com/rollback.php'">Rollback and reboot petclinic.acme.com</button><P>
