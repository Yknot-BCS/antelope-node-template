#!/bin/bash

INSTALL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $INSTALL_ROOT/env.sh

$INSTALL_ROOT/stop.sh

$NODEOS --disable-replay-opts \
        --genesis-json $GENESIS_FILE \
        --data-dir $DATADIR \
        --config-dir $INSTALL_ROOT \
        --state-history-dir $DATADIR/state-history \
        "$@" >> "$LOGFILE" 2>&1 &

PID="$!"
echo "nodeos started with pid $PID"
echo $PID > $INSTALL_ROOT/nodeos.pid

if [[ "$PIN_CPU" == "true" ]]; then
  command -v taskset >/dev/null 2>&1 && taskset -cp $CPU $PID && echo "taskset called..."
  command -v schedtool >/dev/null 2>&1 && schedtool -B $PID && echo "schedtool called..."
fi
