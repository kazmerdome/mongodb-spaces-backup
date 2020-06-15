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

## Extra environmnet

- `BACKUP_FOLDER` - Default value is `backup`.
- `MAX_BACKUPS` - Default not set. If set doing it keeps the last n backups in /backup

## License

[MIT](https://tldrlegal.com/license/mit-license)


