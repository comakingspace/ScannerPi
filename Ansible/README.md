* setup Raspberry OS SD card on pi
* install ssh key on raspberry
  * password option (-k) doesn't work well with most commands
* run Ansible script
  * example: ansible-playbook -i 192.168.188.83, -u pi playbook_setup_scanner-Pi.yml
  * for shared nextcloud folders the username is the shared URL ending e.g. cloud.next.com/s/[username] 
  * password should be optional if none is set

