FROM python:3-alpine
RUN apk add --update postfix
MAINTAINER mail@martindomke.net
COPY opt /opt
