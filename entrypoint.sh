#!/bin/bash

if [[ "$FLASK_ENV" == "production" ]] ; 
  then
    gunicorn -b 0.0.0.0:8000 --timeout 60000 -w ${N_WORKERS} hetmap:app
elif [[ "$FLASK_ENV" == "development" ]] ; 
  then
    tail -f /dev/null
fi