python manage.py migrate
EXISTING_INSTALLATION=`echo "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.exists())" |python manage.py shell`
if [ "$EXISTING_INSTALLATION" = "True" ]; then 
    echo "Loaddata has already run"
else
    python manage.py createsuperuser --username $SUPERUSER_USERNAME --email $SUPERUSER_EMAIL --password $SUPERUSER_PASSWORD
fi
gunicorn --workers=4 -b 0.0.0.0:8000 devproject.wsgi