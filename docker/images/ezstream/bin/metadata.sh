#!/usr/bin/env bash

current_path="$( cd "$( dirname "$0" )" && pwd )"

playlist_json_path=/var/ezstream/stats/playlist.json

previous_track_path=/tmp/icecast2_previous_track
current_track_path=/tmp/icecast2_current_track
next_track_path=/tmp/icecast2_next_track

[ -f $previous_track_path ] || touch $previous_track_path
[ -f $current_track_path ] || touch $current_track_path
[ -f $next_track_path ] || touch $next_track_path

get_track_title (){
    title=$(sed "s/\.mp3$//g" <<< $(basename "$(cat $1)"))
    title=$(sed "s/#\w\+//g" <<< "$title")
    sed "s/\s\+$//g" <<< "$title"
}

previous_track_title="$(get_track_title $previous_track_path)"
current_track_title="$(get_track_title $current_track_path)"
next_track_title="$(get_track_title $next_track_path)"

echo "{\"track\":{\"previous\":\""$previous_track_title"\", \"current\":\""$current_track_title"\", \"next\":\""$next_track_title"\"}}" > $playlist_json_path

get_track_title $current_track_path