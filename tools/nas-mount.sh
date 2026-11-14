#!/usr/bin/env bash
# Mount a CIFS share on the Proxmox host and bind-mount it into an unprivileged LXC.
# Usage: nas-mount.sh <CTID> <//NAS-IP/share> [container-uid, default 1000]
# Credentials: /root/.smbcred (username=…, password=…, chmod 600)
# With a 1:1 idmap for the uid, run with HOST_UID=1000.
set -euo pipefail

CTID=$1; SHARE=$2; CT_UID=${3:-1000}
NAME=$(basename "$SHARE")
HOST_DIR=/mnt/nas/$NAME
HOST_UID=${HOST_UID:-$((100000 + CT_UID))}

mkdir -p "$HOST_DIR"
grep -qs " $HOST_DIR " /etc/fstab || echo "$SHARE $HOST_DIR cifs credentials=/root/.smbcred,uid=$HOST_UID,gid=$HOST_UID,file_mode=0660,dir_mode=0770,_netdev,nofail 0 0" >> /etc/fstab
systemctl daemon-reload
mountpoint -q "$HOST_DIR" || mount "$HOST_DIR"

if pct config "$CTID" | grep -q "^mp[0-9]*: $HOST_DIR,"; then
  echo "Already mounted in CT $CTID"; exit 0
fi
i=0; while pct config "$CTID" | grep -q "^mp$i:"; do i=$((i + 1)); done
pct set "$CTID" "-mp$i" "$HOST_DIR,mp=/mnt/$NAME"
echo "mp$i: $HOST_DIR -> CT $CTID:/mnt/$NAME (restart CT if running)"
