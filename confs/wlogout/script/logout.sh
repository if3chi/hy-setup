#!/usr/bin/env bash

if ! qs -c "$qsConfig" ipc call TEST_ALIVE; then
    pkill wlogout 2>/dev/null
    wlogout -p layer-shell
fi
