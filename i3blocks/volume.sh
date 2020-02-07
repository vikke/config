#!/usr/bin/env bash

set -euCo pipefail

function get_volume() {
  pactl list sinks \
    | grep 'Volume' | grep -o '[0-9]*%' | head -1 | tr -d '%'
}

function get_muted() {
  pactl list sinks \
    | grep 'Mute' | sed 's/[[:space:]]//g' | cut -d: -f2 | head -1
}

function to_blocks() {
  seq -f '%02g' -s '' 1 5 $1 | sed 's/.\{2\}/■/g'
}

function to_spaces() {
  seq -s ' ' $1 5 100 | tr -d '[:digit:]'
}

function to_meters() {
  echo "[$(to_blocks $1)$(to_spaces $1)]"
}

function print_volume() {
  local -r volume=$(get_volume)
  [[ ${volume} -gt 100 ]] \
    && echo -e "${volume}\n" \
    || echo -e "$(to_meters ${volume})\n"
}

function main() {
  which pactl &> /dev/null || return 1

  print_volume

  declare -Ar colors=( ['yes']='#434447' ['no']='#8fa1b3' )
  echo "${colors[$(get_muted)]}"
}

main
