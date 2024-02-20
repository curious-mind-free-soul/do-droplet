#!/bin/bash

# follow the instructions in the link below to create a new user
# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04

# Step 1 — Logging in as root
# ssh root@your_server_ip

# Step 2 — Creating a New User
adduser sammy

#
# Step 3 — Granting Administrative Privileges
usermod -aG sudo sammy

# Step 4 — Setting Up a Basic Firewall
sudo ufw app list
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status

# Copy the public key to the new user's home directory
# rsync --archive --chown=sammy:sammy ~/.ssh /home/sammy

# Test the new user's SSH key
# ssh sammy@your_server_ip

# Exit the root session
# exit
