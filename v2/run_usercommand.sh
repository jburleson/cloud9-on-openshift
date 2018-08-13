#!/bin/bash

if [ ! -z "$C9_PASSWORD" ] && [ ! -z "$C9_USERNAME" ]; then
   echo "Starting Cloud9..."
   node cloud9/server.js -w /workspace -l 0.0.0.0 -p 8181 --username $C9_USERNAME --password $C9_PASSWORD;
else
   echo "[warn] Starting Cloud9 Without Authorization is highly discouraged. Set them from the C9_USERNAME and C9_PASSWORD variables!"
   node cloud9/server.js -w /workspace -l 0.0.0.0 -p 8181;
fi
