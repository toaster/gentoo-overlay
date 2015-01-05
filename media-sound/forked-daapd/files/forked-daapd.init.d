#!/sbin/runscript
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PIDFILE="/var/run/forked-daapd.pid"
CONFFILE="/etc/forked-daapd.conf"

depend() {
	need net
}

start() {
	ebegin "Starting forked-daapd DAAP server"
	start-stop-daemon --start --quiet --pidfile ${PIDFILE} \
		--exec /usr/sbin/forked-daapd -- -P ${PIDFILE} -c ${CONFFILE}
	eend $?
}

stop() {
	ebegin "Stopping forked-daapd DAAP server"
	start-stop-daemon --stop --quiet --pidfile ${PIDFILE} --signal 2
	eend $?

	rm -f ${PIDFILE}
}
