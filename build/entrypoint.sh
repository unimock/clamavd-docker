#!/bin/sh

sed -i 's|^#DatabaseDirectory /var/lib/clamav|DatabaseDirectory /data|g'  /etc/clamav/clamd.conf
sed -i 's|^#DatabaseDirectory /var/lib/clamav|DatabaseDirectory /data|g'  /etc/clamav/freshclam.conf

mkdir -p /data
cp -rva --no-clobber /var/lib/clamav/*  /data/
chown -Rvf clamav:clamav /data

freshclam -d &
clamd &

pids=`jobs -p`

exitcode=0

terminate() {
    for pid in $pids; do
        if ! kill -0 $pid 2>/dev/null; then
            wait $pid
            exitcode=$?
        fi
    done
    kill $pids 2>/dev/null
}

trap terminate CHLD
wait

exit $exitcode
