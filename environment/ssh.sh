#!/usr/bin/env bash

if [ -z "$REPTILIAN_SSH_COMMAND" ]; then
  clear
fi
repeat=true
while "$repeat"; do
  ssh "$@" true >/dev/null 2>&1 && repeat=false
  sleep 5
done
if [ -n "$REPTILIAN_SSH_UPLOAD_SOURCE" ] && [ -n "$REPTILIAN_SSH_UPLOAD_TARGET" ]; then
  rsync -qrcz --delete -e "ssh -p 2222" "$REPTILIAN_SSH_UPLOAD_SOURCE" "reptilian@localhost:$REPTILIAN_SSH_UPLOAD_TARGET"
fi
ssh "$@" "$REPTILIAN_SSH_COMMAND"
exit 0
