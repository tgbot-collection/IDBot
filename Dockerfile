FROM python:alpine as builder

RUN apk update && apk add  --no-cache tzdata alpine-sdk libffi-dev ca-certificates
RUN pip3 install --user pyrogram tgbot-ping


FROM python:alpine
COPY --from=builder /root/.local /usr/local
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY . /IDBot

WORKDIR /IDBot
ENV TZ=Asia/Shanghai
CMD ["python", "idbot.py"]