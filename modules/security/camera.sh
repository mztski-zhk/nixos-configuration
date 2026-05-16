#!/usr/bin/env bash

echo "Locking down camera..."

PIDS=$(sudo lsof -t /dev/video* 2>/dev/null)
if [ ! -z "$PIDS" ]; then
    echo "Apps using camera: $PIDS"
    read -r -p "Sure to terminate them? (y/n): " kill_ans

    if [[ "$kill_ans" =~ ^[Yy]$ ]]; then
      echo "Terminating apps..."
      sudo kill -9 $PIDS
    else
      echo "Skip apps termination. (Note: Script might NOT work properly!)"
    fi
else
    echo "No apps using camera."
fi

read -r -p "Disconnect the camera module? (y/n): " disconnect_ans

if [[ "$disconnect_ans" =~ ^[Yy]$ ]]; then
    echo "Pausing audio server..."
    systemctl --user stop wireplumber

    echo "Unloading uvcvideo driver..."

    if sudo modprobe -r uvcvideo 2>/dev/null; then
        echo "Camera driver successfully unloaded."
    else
        echo "Failed to unload camera. Process is still holding the device."
    fi

    echo "Restarting audio server..."
    systemctl --user start wireplumber
else
    echo "Keep camera still connected."
fi
