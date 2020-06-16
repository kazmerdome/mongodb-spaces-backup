FROM alpine:latest

RUN apk add --no-cache mongodb-tools python3 py3-pip

RUN pip3 install awscli

ENV BACKUP_FOLDER=backup
ENV REGION=fra1

WORKDIR /usr/local/bin
COPY entrypoint.sh ./
COPY backup.sh ./
COPY env_secrets_expand.sh ./
RUN chmod +x ./entrypoint.sh && chmod +x ./backup.sh && chmod +x ./env_secrets_expand.sh

CMD ["sh", "entrypoint.sh"]
