#!/usr/bin/env bash

env

set -x

ICECAST_NONSTOP_MOUNT=$(echo $ICECAST_NONSTOP_MOUNT | sed "s/\//\\\\\//g")
STREAM_URL=$(echo $STREAM_URL | sed "s/\//\\\\\//g")

ezstream_config_template=/etc/ezstream.template.xml
ezstream_config=/etc/ezstream.xml

cp $ezstream_config_template $ezstream_config
chmod 600 $ezstream_config

sed -i "s/%ICECAST_HOSTNAME%/$ICECAST_HOSTNAME/g" $ezstream_config
sed -i "s/%ICECAST_PORT%/$ICECAST_PORT/g" $ezstream_config
sed -i "s/%ICECAST_NONSTOP_MOUNT%/$ICECAST_NONSTOP_MOUNT/g" $ezstream_config
sed -i "s/%ICECAST_AUTHENTICATION_SOURCE_PASSWORD%/$ICECAST_AUTHENTICATION_SOURCE_PASSWORD/g" $ezstream_config
sed -i "s/%STREAM_NAME%/$STREAM_NAME/g" $ezstream_config
sed -i "s/%STREAM_DESCRIPTION%/$STREAM_DESCRIPTION/g" $ezstream_config
sed -i "s/%STREAM_URL%/$STREAM_URL/g" $ezstream_config
sed -i "s/%STREAM_GENRE%/$STREAM_GENRE/g" $ezstream_config
sed -i "s/%STREAM_BITRATE%/$STREAM_BITRATE/g" $ezstream_config

chmod 500 /var/ezstream/playlist.sh
chmod 500 /var/ezstream/metadata.sh

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf