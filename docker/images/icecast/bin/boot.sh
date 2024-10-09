#!/usr/bin/env bash

env

set -x

ICECAST_LIVE_MOUNT=$(echo $ICECAST_LIVE_MOUNT | sed "s/\//\\\\\//g")
ICECAST_NONSTOP_MOUNT=$(echo $ICECAST_NONSTOP_MOUNT | sed "s/\//\\\\\//g")
STREAM_URL=$(echo $STREAM_URL | sed "s/\//\\\\\//g")

icecast2_config_template=/etc/icecast2/icecast.template.xml
icecast2_config=/etc/icecast2/icecast.xml

cp $icecast2_config_template $icecast2_config

chmod root:icecast $icecast2_config
chmod 640 $icecast2_config

sed -i "s/%ICECAST_HOSTNAME%/$ICECAST_HOSTNAME/g" $icecast2_config
sed -i "s/%ICECAST_LOCATION%/$ICECAST_LOCATION/g" $icecast2_config
sed -i "s/%ICECAST_ADMIN%/$ICECAST_ADMIN/g" $icecast2_config

sed -i "s/%ICECAST_LIMIT_CLIENTS%/$ICECAST_LIMIT_CLIENTS/g" $icecast2_config
sed -i "s/%ICECAST_LIMIT_SOURCES%/$ICECAST_LIMIT_SOURCES/g" $icecast2_config

sed -i "s/%ICECAST_AUTHENTICATION_SOURCE_PASSWORD%/$ICECAST_AUTHENTICATION_SOURCE_PASSWORD/g" $icecast2_config
sed -i "s/%ICECAST_AUTHENTICATION_RELAY_PASSWORD%/$ICECAST_AUTHENTICATION_RELAY_PASSWORD/g" $icecast2_config
sed -i "s/%ICECAST_AUTHENTICATION_ADMIN_USER%/$ICECAST_AUTHENTICATION_ADMIN_USER/g" $icecast2_config
sed -i "s/%ICECAST_AUTHENTICATION_ADMIN_PASSWORD%/$ICECAST_AUTHENTICATION_ADMIN_PASSWORD/g" $icecast2_config

sed -i "s/%ICECAST_PORT%/$ICECAST_PORT/g" $icecast2_config
sed -i "s/%ICECAST_PORT_SECOND%/$ICECAST_PORT_SECOND/g" $icecast2_config

sed -i "s/%ICECAST_LIVE_MOUNT%/$ICECAST_LIVE_MOUNT/g" $icecast2_config
sed -i "s/%ICECAST_NONSTOP_MOUNT%/$ICECAST_NONSTOP_MOUNT/g" $icecast2_config

sed -i "s/%STREAM_NAME%/$STREAM_NAME/g" $icecast2_config
sed -i "s/%STREAM_DESCRIPTION%/$STREAM_DESCRIPTION/g" $icecast2_config
sed -i "s/%STREAM_URL%/$STREAM_URL/g" $icecast2_config
sed -i "s/%STREAM_GENRE%/$STREAM_GENRE/g" $icecast2_config
sed -i "s/%STREAM_BITRATE%/$STREAM_BITRATE/g" $icecast2_config

icecast2_stats_script_template=/var/icecast2/stats.template.sh
icecast2_stats_script=/var/icecast2/stats.sh

cp $icecast2_stats_script_template $icecast2_stats_script

sed -i "s/%ICECAST_AUTHENTICATION_ADMIN_USER%/$ICECAST_AUTHENTICATION_ADMIN_USER/g" $icecast2_stats_script
sed -i "s/%ICECAST_AUTHENTICATION_ADMIN_PASSWORD%/$ICECAST_AUTHENTICATION_ADMIN_PASSWORD/g" $icecast2_stats_script
sed -i "s/%ICECAST_HOSTNAME%/$ICECAST_HOSTNAME/g" $icecast2_stats_script
sed -i "s/%ICECAST_PORT%/$ICECAST_PORT/g" $icecast2_stats_script

chmod +x $icecast2_stats_script

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf