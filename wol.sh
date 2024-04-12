#!/bin/bash

ping -c 3 <IP address> | grep "+3 errors" && wakeonlan -p 9 <IP/MAC address>
