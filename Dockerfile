FROM python:3-alpine
RUN apk add --update postfix \
&&  pip3 install jinja2 html2text
MAINTAINER mail@martindomke.net
COPY opt /opt
