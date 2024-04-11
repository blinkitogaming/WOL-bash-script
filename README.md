# WOL bash script





## Description
This script will wake up any machine by sending a Wake On Lan order to de designated IP or MAC address.

It'll send a ping to the designated IP address every 3 seconds and after 3 errors it will send the WOL order.

## Installation
Steps for creating and making it functional:

### Step 1
Open a file in you favorite text editor. Choose the name you like. For this example we'll name it wol.sh:
    nano wol.sh

### Step 2
Paste the following code into the script making sure you change both the <IP address> and <IP/MAC address>:
    #!/bin/bash

    ping -c 3 <IP address> | grep "+3 errors" && wakeonlan -p 9 <IP/MAC address>

### Step 3
Save the file and exit the editor. IF using nano:
    
    Ctrl + O
    Ctrl + X

And make it executable:
    
    chmod u+x wol.sh

chmod: changes the permission of file.
u+x: argument with chmod command to add the executable permission to the user.

### Step 4
Now let's check the script by running this command:
    
    ./wol.sh

If everything went fine the target machine will be wake up after a few seconds.

### Step 5
Making the script to start running on every boot in a cronjob.

For this we'll use systemd.

We will create a service to execut the script. Just edit this file:
/etc/systemd/system/wol.service

    [Unit]
    Description=WOL script service.

    [Service]
    Type=simple
    ExecStart=/bin/bash /<path_to_our_script>/wol.sh

    [Install]
    WantedBy=multi-user.target

Here's what all this lines mean:

* [Unit]: contains general metadata like a description.
* [Service]: describes the process and daemonizing behavior, along with the command to start the service.
* [Install]: enables the service to run at startup using the folder specified in WnatedBy to handle dependencies.

Next, we'll need to set the file permissions to 644 and enable our service by using *systemctl*:

    chmod 644 /etc/systemd/system/wol.service
    systemctl enable wol.service

*NOTE: Keep in mind not all distributions has systemd available.*