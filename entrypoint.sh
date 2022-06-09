#!/bin/bash

if [[ "$FLASK_ENV" == "production" ]] ; 
  then
    if [[ "$SCRIPT_NAME" != "" ]] ;
      then
        echo "prefix: $SCRIPT_NAME"
        gunicorn -e SCRIPT_NAME=/${SCRIPT_NAME} -b 0.0.0.0:8000 --timeout 60000 -w ${N_WORKERS} ${BUILD_NAME}:app
      else
        gunicorn -b 0.0.0.0:8000 --timeout 60000 -w ${N_WORKERS} ${BUILD_NAME}:app
      fi
elif [[ "$FLASK_ENV" == "development" ]] ; 
  then
    tail -f /dev/null
fi