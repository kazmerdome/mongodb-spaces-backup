#!/bin/bash

set +e

if [ -z ${CRON_SCHEDULE+x} ]; then
  ./backup.sh
else
  BACKUP_CRON_SCHEDULE=${CRON_SCHEDULE}
  echo "${CRON_SCHEDULE} ./backup.sh" > /etc/crontabs/root
  
  # Starting cron
  ###############
  crond -f -d 0
fi
