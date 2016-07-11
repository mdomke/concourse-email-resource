FROM python:3-alpine
RUN apk add --update postfix build-base libxml2-dev libxslt-dev python3-dev \
&&  pip install jinja2 html2text inlinestyler
MAINTAINER mail@martindomke.net
COPY opt /opt
