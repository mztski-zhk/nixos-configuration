#!/usr/bin/env bash

echo "Locking down camera..."

PIDS=$(sudo lsof -t /dev/video* 2>/dev/null)
if [ ! -z "$PIDS" ]; then
    echo "Terminating apps using camera: $PIDS"
    sudo kill -9 $PIDS
fi

echo "Pausing audio server..."
systemctl --user stop wireplumber

echo "Unloading uvcvideo driver..."
sudo modprobe -r uvcvideo

echo "Restarting audio server..."
systemctl --user start wireplumber

echo "Camera is disconnected."
