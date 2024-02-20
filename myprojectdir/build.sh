#

# Create a virtual environment and activate it
cd ~/myprojectdir
python3 -m venv myprojectenv
source myprojectenv/bin/activate

# Install Django and other project dependencies
pip install -r requirements.txt

# Collect static files
python manage.py collectstatic --noinput

python manage.py makemigrations
python manage.py migrate

DJANGO_SUPERUSER_PASSWORD=password python manage.py createsuperuser --username=admin --email=admin@digitalocean.com --noinput

# python manage.py runserver