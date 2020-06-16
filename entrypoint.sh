#!/bin/bash

set +e


if [ -z ${CRON_SCHEDULE+x} ]; then
  sh /usr/local/bin/backup.sh
else
  BACKUP_CRON_SCHEDULE=${CRON_SCHEDULE}
  echo "${CRON_SCHEDULE} sh /usr/local/bin/backup.sh" > /etc/crontabs/root
  # Starting cron
  crond -f -d 0
fi
