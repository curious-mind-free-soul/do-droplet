#!/bin/bash

IP="178.128.8.47"

#ssh sammy@64.23.160.237
# $ pwd
# /home/sammy

# https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-22-04

# Update package index and install necessary packages
# sudo apt update
# sudo apt install python3-venv python3-dev libpq-dev postgresql postgresql-contrib nginx curl

# Clone the Django app repository from GitHub
# git clone https://github.com/curious-mind-free-soul/do-droplet.git ~/do-droplet

# Create a new PostgreSQL database and user
# sudo -u postgres psql -f setup_database.sql
sudo -u postgres psql -c "CREATE DATABASE myproject;"
sudo -u postgres psql -c "CREATE USER myprojectuser WITH PASSWORD 'password';"
sudo -u postgres psql -c "ALTER ROLE myprojectuser SET client_encoding TO 'utf8';"
sudo -u postgres psql -c "ALTER ROLE myprojectuser SET default_transaction_isolation TO 'read committed';"
sudo -u postgres psql -c "ALTER ROLE myprojectuser SET timezone TO 'UTC';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;"
# sudo -u postgres psql -d myproject -f setup_database_permission.sql
sudo -u postgres psql -d myproject -c "GRANT USAGE ON SCHEMA public TO myprojectuser;"
sudo -u postgres psql -d myproject -c "GRANT CREATE ON SCHEMA public TO myprojectuser;"
sudo -u postgres psql -d myproject -c "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO myprojectuser;"
sudo -u postgres psql -d myproject -c "GRANT ALL ON SCHEMA public TO myprojectuser;"
sudo -u postgres psql -d myproject -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myprojectuser;"


# Create a virtual directory
cp -r ~/do-droplet/myprojectdir ~/myprojectdir
#mkdir ~/myprojectdir && cd ~/myprojectdir

cd ~/myprojectdir

# Run the setup script
sh build.sh

sudo ufw allow 8000
~/myprojectdir/manage.py runserver 0.0.0.0:8000

# http://server_domain_or_IP:8000

cd ~/myprojectdir
gunicorn --bind 0.0.0.0:8000 myproject.wsgi

deactivate

# Configure Gunicorn
sudo cp deployment/gunicorn.socket /etc/systemd/system/

sudo cp deployment/gunicorn.service /etc/systemd/system/
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

# Configure Nginx
sed -i "s/server_domain_or_IP/$IP/g" deployment/nginx.conf
sudo cp deployment/nginx.conf /etc/nginx/sites-available/myproject

sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
sudo systemctl restart nginx

# Adjust firewall settings if needed
sudo ufw allow 'Nginx Full'

sudo usermod -a -G sammy www-data
sudo nginx -t
sudo systemctl restart nginx

echo "Django app setup complete. You can now access your app via your server's IP address."

sudo tail -F /var/log/nginx/error.log


