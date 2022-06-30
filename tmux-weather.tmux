#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
tmux bind-key y display-popup -w 80 -h 50 "$CURRENT_DIR/scripts/weather.sh"
