#!/usr/bin/env bash

user=%ICECAST_AUTHENTICATION_ADMIN_USER%
password=%ICECAST_AUTHENTICATION_ADMIN_PASSWORD%
stats_url="http://%ICECAST_HOSTNAME%:%ICECAST_PORT%/admin/stats"

stats_xml_path=/tmp/icecast2_stats.xml
stats_json_path=/var/icecast2/stats/icecast2_stats.json

while true ; do
    curl -s --user ${user}:${password} ${stats_url} > $stats_xml_path

    listeners=$(xmllint --xpath '/icestats/listeners/text()' $stats_xml_path)

    echo "{\"listeners\":\""$listeners"\"}" > $stats_json_path

    sleep 5
done