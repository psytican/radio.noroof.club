FROM debian:bookworm-slim

MAINTAINER Evgenii Panov <ev.panov@gmail.com>

ENV	DEBIAN_FRONTEND noninteractive

RUN	apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq supervisor

RUN	apt-get install -yqq icecast2 curl libxml2-utils \
    && apt-get clean

ADD bin/boot.sh /root/boot.sh
RUN chmod 500 /root/boot.sh

CMD ["/root/boot.sh"]