#!/bin/bash
# sh setup_host.sh
sudo apt update
sudo apt install python3-venv python3-dev libpq-dev postgresql postgresql-contrib nginx curl

# Clone the Django app repository from GitHub
git clone https://github.com/curious-mind-free-soul/do-droplet.git ~/do-droplet

# run the setup script
sh ~/do-droplet/myprojectdir/deployment/setup-droplet-do.sh
