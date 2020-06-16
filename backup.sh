#!/bin/bash

source ./env_secrets_expand.sh

BACKUP_NAME="$(date -u +%Y-%m-%d_%H-%M-%S)_UTC.gz"
ENDPOINT="https://${REGION}.digitaloceanspaces.com"

# Run backup
mongodump --uri "$MONGO_URI/$MONGO_DB_NAME" -o /backup/dump

# Compress backup
cd /backup/ && tar -cvzf "${BACKUP_NAME}" dump

# Upload backup
export AWS_ACCESS_KEY_ID=$ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY
aws s3 --endpoint=$ENDPOINT cp "/backup/${BACKUP_NAME}" "s3://${BUCKET_NAME}/${BACKUP_FOLDER}/${BACKUP_NAME}"

# Delete backup files
if [ -n "${MAX_BACKUPS}" ]; then
  while [ $(ls /backup -w 1 | wc -l) -gt ${MAX_BACKUPS} ];
  do
    BACKUP_TO_BE_DELETED=$(ls /backup -w 1 | sort | head -n 1)
    rm -rf /backup/${BACKUP_TO_BE_DELETED}
  done
else
  rm -rf /backup/*
fi
