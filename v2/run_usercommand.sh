#!/bin/sh
ls cloud9
node cloud9/server.js -w /workspace -l 0.0.0.0 -p 8181 --username $C9_USERNAME --password $C9_PASSWORD;