FROM elasticsearch:1.7.1
MAINTAINER Tom Scanlan <tscanlan@vmware.com>


RUN apt-get update
RUN apt-get install -y dnsutils

ADD start.sh /start.sh
ENTRYPOINT /start.sh

