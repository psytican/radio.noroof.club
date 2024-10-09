<?php

$stats = [];

$icecast2_stats = file_get_contents(__DIR__."/stats/icecast2_stats.json");
if(!empty($icecast2_stats)){
    $stats = array_merge($stats, json_decode($icecast2_stats, true));
}

$playlist = file_get_contents(__DIR__."/stats/playlist.json");
if(!empty($playlist)){
    $stats = array_merge($stats, json_decode($playlist, true));
}

header('Content-Type: application/json');
echo json_encode($stats);

exit;