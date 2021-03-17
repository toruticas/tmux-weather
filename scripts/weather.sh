#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

wttr() {
  local location=$(get_tmux_option "@tmux-weather-location")
  local language=$(get_tmux_option "@tmux-weather-language" "en")
  local new_version=$(get_tmux_option "@tmux-weather-v2")
  local url="wttr.in"

  if [ ! -z "$location" ]
  then
    url+="/$location"
  fi

  if [ ! -z "$new_version" ]
  then
    url+="?format=v2"
  fi

 echo -e "$(curl -s -H "Accept-Language: $language" $url)"
}

cache() {
  local data=$1
  local cache_version="CACHED: $(date)"

  echo -e "[38;5;220m$cache_version[0m\n\n$response" > "$CURRENT_DIR/../.cache"
}

run() {
  local response=$(wttr)

  if [ -z "$response" ]; then
    local message="SOMETHING WENT WRONG. CHECK YOUR INTERNET CONNECTION."
    local file_cached="$CURRENT_DIR/../.cache"

    echo -e "[38;5;160m$message[0m"

    if test -f "$file_cached"; then
      cat $file_cached
    fi
  else
    echo "$response"
    cache $response
  fi;

  while [ true  ] ; do
    read -t 3 -n 1
    if [ $? = 0  ] ; then
      exit ;
    fi
  done
}

run
