#!/usr/bin/env bash

clear
repeat=true
while "$repeat"; do
  ssh "$@" true >/dev/null 2>&1 && repeat=false
  sleep 5
done
ssh "$@"
exit 0
