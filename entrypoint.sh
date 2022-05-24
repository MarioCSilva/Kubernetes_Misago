python manage.py migrate
python manage.py createsuperuser --username $SUPERUSER_USERNAME --email $SUPERUSER_EMAIL --password $SUPERUSER_PASSWORD
gunicorn --workers=4 -b 0.0.0.0:8000 devproject.wsgi