#!/bin/bash

#ssh sammy@64.23.160.237
# $ pwd
# /home/sammy

# https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-22-04

# Update package index and install necessary packages
sudo apt update
sudo apt install python3-venv python3-dev libpq-dev postgresql postgresql-contrib nginx curl


# Create a new PostgreSQL database and user
sudo -u postgres psql
CREATE DATABASE myproject;
CREATE USER myprojectuser WITH PASSWORD 'password';
ALTER ROLE myprojectuser SET client_encoding TO 'utf8';
ALTER ROLE myprojectuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE myprojectuser SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;
\q



# Clone the Django app repository from GitHub
git clone git@github.com:curious-mind-free-soul/do-droplet.git ~

# Create a virtual directory
cp -r ~/do-droplet/myprojectdir ~/myprojectdir
#mkdir ~/myprojectdir && cd ~/myprojectdir

# Run the setup script
sh ../build.sh

# Configure Gunicorn
sudo cp gunicorn.service /etc/systemd/system/
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

# Configure Nginx
sudo cp nginx.conf /etc/nginx/sites-available/myproject
sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
sudo systemctl restart nginx

# Adjust firewall settings if needed
sudo ufw allow 'Nginx Full'

echo "Django app setup complete. You can now access your app via your server's IP address."


