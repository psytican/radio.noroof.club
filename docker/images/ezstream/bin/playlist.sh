#!/usr/bin/env bash

current_path="$( cd "$( dirname "$0" )" && pwd )"

playlist_path=$current_path/playlist.m3u

previous_playlist_path=/tmp/icecast2_previous_playlist
previous_playlist_path_temp=/tmp/icecast2_previous_playlist_temp

[ -f previous_playlist_path ] || touch previous_playlist_path
[ -f previous_playlist_path_temp ] || touch previous_playlist_path_temp

previous_track_path=/tmp/icecast2_previous_track
current_track_path=/tmp/icecast2_current_track
next_track_path=/tmp/icecast2_next_track

[ -f $previous_track_path ] || touch $previous_track_path
[ -f $current_track_path ] || touch $current_track_path
[ -f $next_track_path ] || touch $next_track_path

find -L $current_path/playlist/ -type f -name "*.mp3" -exec echo {} \; > $playlist_path

playlist_count=$(wc -l < $playlist_path)
previous_playlist_count=$(wc -l < $previous_playlist_path)
previous_playlist_tail_count=$(($playlist_count / 2))

if [ "$previous_playlist_tail_count" -lt "$previous_playlist_count" ]
then
    tail -n $previous_playlist_tail_count $previous_playlist_path > $previous_playlist_path_temp && mv $previous_playlist_path_temp $previous_playlist_path
fi

get_random_track () {
    random_track=$(shuf -n 1 $playlist_path)

    track_prev=$(cat $previous_track_path)
    track_now=$(cat $current_track_path)

    in_previous_playlist_path=$(grep "$random_track" $previous_playlist_path)

    if [ "$random_track" == "$track_prev" ] || [ "$random_track" == "$track_now" ] || [ -s "$in_previous_playlist_path" ]
    then
        random_track=$(get_random_track)
    fi

    echo $random_track
}

if [ -s $current_track_path ]
then
    cp $current_track_path $previous_track_path

    if [ -s $next_track_path ]
    then
        cp $next_track_path $current_track_path
    fi
else
    echo "$(get_random_track)" > $current_track_path
fi

cat $current_track_path >> $previous_playlist_path

echo "$(get_random_track)" > $next_track_path

cat $current_track_path