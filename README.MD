# mongodb-spaces-backup

> Docker Image based on mongo:4.2 offical image and awscli for backup mongo database to digital ocean spaces
> Inspired by https://github.com/Drivetech/mongodump-s3
> Compatible with mongodb atlas and mlab uri

## Use

### Periodic backup

Run every day at 2 am

```bash
docker run -d --name mongodump \
  -e "MONGO_URI=mongodb+srv://user:pass@host:port" \
  -e "MONGO_DB_NAME=dbname" \
  -e "ACCESS_KEY_ID=your_access_key" \
  -e "SECRET_ACCESS_KEY=your_secret_access_key" \
  -e "BUCKET_NAME=your_bucket" \
  -e "REGION=fra1" \
  -e "CRON_SCHEDULE=0 2 * * *" \
  kazmerdome/mongodb-spaces-backup
```

### Inmediatic backup

```bash
docker run --rm \
  -e "MONGO_URI=mongodb+srv://user:pass@host:port" \
  -e "MONGO_DB_NAME=dbname" \
  -e "ACCESS_KEY_ID=your_access_key" \
  -e "SECRET_ACCESS_KEY=your_secret_access_key" \
  -e "BUCKET_NAME=your_bucket" \
  -e "REGION=fra1" \
  kazmerdome/mongodb-spaces-backup
```

### Docker Swarm Example with secrets

```yml
services:
  mongodb-spaces-backup:
    image: kazmerdome/mongodb-spaces-backup:latest
    environment:
      # every day at 2am
      - CRON_SCHEDULE="0 2 * * *"
      - REGION=fra1
      - BUCKET_NAME=your-bucket-name
      - ACCESS_KEY_ID=DOCKER-SECRET->ACCESS_KEY_ID__SECRET
      - SECRET_ACCESS_KEY=DOCKER-SECRET->SECRET_ACCESS_KEY__SECRET
      - MONGO_URI=DOCKER-SECRET->MONGO_URI__SECRET
      - MONGO_DB_NAME=DOCKER-SECRET->MONGO_DB_NAME__SECRET
    secrets:
      - ACCESS_KEY_ID__SECRET
      - SECRET_ACCESS_KEY__SECRET
      - MONGO_URI__SECRET
      - MONGO_DB_NAME__SECRET
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure

secrets:
  ACCESS_KEY_ID__SECRET:
    external: true
  SECRET_ACCESS_KEY__SECRET:
    external: true
  MONGO_URI__SECRET:
    external: true
  MONGO_DB_NAME__SECRET:
    external: true
```



## Extra environmnet

- `BACKUP_FOLDER` - Default value is `backup`.
- `MAX_BACKUPS` - Default not set. If set doing it keeps the last n backups in /backup

## License

[MIT]
