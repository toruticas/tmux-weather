#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
tmux bind-key y new-window "$CURRENT_DIR/scripts/weather.sh"

