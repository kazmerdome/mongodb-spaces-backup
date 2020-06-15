FROM mongo:4.2

RUN apt-get update && \
    apt-get install -y cron python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli

ENV BACKUP_FOLDER=backup
ENV REGION=fra1

WORKDIR /mongodb-spaces-backup
COPY entrypoint.sh ./
COPY backup.sh ./
RUN chmod +x ./entrypoint.sh && chmod +x ./backup.sh

CMD ["sh", "entrypoint.sh"]
