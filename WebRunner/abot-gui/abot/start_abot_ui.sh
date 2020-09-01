#! /bin/bash

if [ ! -f /etc/rebaca-test-suite/abot/app.py ]; then
   echo "ABot UI startup file not found - exiting ..."
   exit 1
fi

#Check for flask process and stop it if it it running
flask_process_id=`ps -ef | grep python | grep app.py | awk '{print $2}'`
if [ ! -z ${flask_process_id} ]; then
    echo "Stopping flask process with id ${flask_process_id}"
    kill -9 ${flask_process_id}
fi

cd /etc/rebaca-test-suite/abot
echo "Starting ABot(flask) GUI..."  >> abot-ui.log
python app.py
