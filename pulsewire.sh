#!/usr/bin/env bash


## Author: Tommy Miland (@tmiland) - Copyright (c) 2023


######################################################################
####                       pulsewire.sh                           ####
####            Automatic script to switch between                ####
####                   PulseAudio and PipeWire                    ####
####                   Maintained by @tmiland                     ####
######################################################################

VERSION='1.0.0' # Must stay on line 14 for updater to fetch the numbers

#------------------------------------------------------------------------------#
#
# MIT License
#
# Copyright (c) 2023 Tommy Miland
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#------------------------------------------------------------------------------#
## Uncomment for debugging purpose
#set -o errexit
#set -o pipefail
#set -o nounset
#set -o xtrace

# Symlink: ln -sfn ~/.scripts/pulsewire.sh ~/.local/bin/pulsewire
pulseaudio=pulseaudio
pipewire=pipewire
systemctl=systemctl
service=service
socket=socket
user="--user"

usage() {
  # shellcheck disable=SC2046
  printf "Usage: %s %s [options]\\n" "${CYAN}" $(basename "$0")
  echo
  echo "  If called without arguments, uses 24 hour clock."
  echo
  printf "  --PulseAudio       use PulseAudio\\n"
  printf "  --PipeWire         use PipeWire\\n"
  printf "\\n"
  printf "  Crontab: @hourly bash ~/.scripts/night_light.sh > /dev/null 2>&1\\n"
  echo
}

PipeWire() {
  $systemctl $user --now stop $pulseaudio.$service $pulseaudio.$socket
  $systemctl $user --now disable $pulseaudio.$service $pulseaudio.$socket
  $systemctl $user enable $pipewire.$service $pipewire.$socket $pipewire-pulse.$service $pipewire-pulse.$socket wireplumber.$service
  $systemctl $user start $pipewire.$service $pipewire.$socket $pipewire-pulse.$service $pipewire-pulse.$socket wireplumber.$service
}

PulseAudio() {
  $systemctl $user --now enable $pulseaudio.$service $pulseaudio.$socket
  $systemctl $user --now start $pulseaudio.$service $pulseaudio.$socket
  $systemctl $user stop $pipewire.$service $pipewire.$socket $pipewire-pulse.$service $pipewire-pulse.$socket wireplumber.$service
  $systemctl $user disable $pipewire.$service $pipewire.$socket $pipewire-pulse.$service $pipewire-pulse.$socket wireplumber.$service
}

ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --help | -h)
      usage
      exit 0
      ;;
    --PulseAudio | -pa)
      PulseAudio
      shift
      ;;
    --PipeWire | -pw)
      PipeWire
      shift
      ;;
    -*|--*)
      printf "Unrecognized option: $1\\n\\n"
      usage
      exit 1
      ;;
    *)
      ARGS+=("$1")
      shift
      ;;
  esac
done

set -- "${ARGS[@]}"
