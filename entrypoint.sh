#!/bin/bash

set -o errexit
set -o nounset

readonly RSYSLOG_PID="/var/run/rsyslogd.pid"

main() {
    start_lbconfig
    start_rsyslogd
    start_lb "$@"
}

start_lbconfig() {
    sed -i".org" -e "s|SERVER_ADDRESS|$SERVER_ADDRESS|g" /etc/haproxy.cfg
}

start_rsyslogd() {
    rm -f $RSYSLOG_PID
    rsyslogd -n
}

start_lb() {
  exec haproxy "$@"
}

main "$@"
