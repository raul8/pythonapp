FROM python:3.7.3-alpine

RUN apk update && apk upgrade && apk add gcc libc-dev g++ libffi-dev libxml2 unixodbc-dev mariadb-dev postgresql-dev \
python-dev vim

RUN addgroup -S -g 1000 docker \
    && adduser -D -S -h /var/cache/docker -s /sbin/nologin -G docker -u 1000 docker \
    && chown docker:docker -R /usr/local/lib/python3.7/site-packages/

WORKDIR /app/
COPY application.py /app/
COPY lib.txt /app/
RUN chown docker:docker -R /app/

USER docker

# Install the dependencies
RUN ["pip", "install", "-r", "lib.txt", "--user"]

ENV PYTHONPATH=/usr/local/lib/python2.7/site-packages

RUN echo $PYTHONPATH

CMD [ "python",  "application.py"]
