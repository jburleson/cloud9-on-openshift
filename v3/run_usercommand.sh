#!/bin/sh

/home/user/.c9/node/bin/node /opt/app/server.js \
    --listen 0.0.0.0 \
    --port 8181 \
    -a $C9_USERNAME:$C9_PASSWORD \
    -w /workspace

