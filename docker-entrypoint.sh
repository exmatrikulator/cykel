#!/bin/bash

python manage.py migrate

# Do we have the source code mounted? If yes, we start the debugging
if [ -n  "$(mount | grep "cykel " )" ]; then
    python manage.py runserver 0.0.0.0:8000
else
    # generate /static
    python manage.py collectstatic

    # start app
    [ -n "$LOGLEVEL" ] && LOGLEVEL="--log-level $$LOGLEVEL"
    gunicorn -D --workers 3 --bind :8001 $LOGLEVEL cykel.wsgi:application
    
    nginx -g "daemon off;"
fi
