#!/usr/bin/env bash

. /etc/named/named.env

if [ ! "$DISABLE_ZONE_CHECKING" == "yes" ]; then
    named-checkconf -z "$NAMEDCONF"
else
    echo "Checking of zone files is disabled"
fi

named -c ${NAMEDCONF} ${OPTIONS}