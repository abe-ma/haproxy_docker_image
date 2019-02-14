FROM haproxy:1.8.1-alpine
MAINTAINER abe-ma <mas.abe@opt.ne.jp>

ADD ./etc/ /etc/
ADD ./entrypoint.sh /usr/local/bin/entrypoint

RUN set -x && \
    apk upgrade --update && \
    apk add bash ca-certificates rsyslog && \
    mkdir -p /etc/rsyslog.d/ && \
    touch /var/log/haproxy.log && \
    ln -sf /dev/stdout /var/log/haproxy.log && \
    chmod 777 /usr/local/bin/entrypoint

EXPOSE 8080

ENTRYPOINT [ "entrypoint" ]
CMD [ "-f", "/etc/haproxy.cfg" ]
