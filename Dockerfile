FROM python:3.10-alpine as builder

RUN apk update && apk add  --no-cache tzdata alpine-sdk libffi-dev ca-certificates
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --user -r /tmp/requirements.txt


FROM python:3.10-alpine
COPY --from=builder /root/.local /usr/local
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY . /IDBot

WORKDIR /IDBot
ENV TZ=Asia/Shanghai
CMD ["python", "idbot.py"]
