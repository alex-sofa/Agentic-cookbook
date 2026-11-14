# Keeping host, containers and VMs updated

**Problem:** Many LXCs and VMs, each needing `apt upgrade`.

**Solution:** Community script for all LXCs (on demand or weekly cron), `unattended-upgrades` inside VMs, host via GUI or `apt`.

## LXCs

Run in the Proxmox host shell (interactive, can exclude CTs and skip stopped ones):
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/update-lxcs.sh)"
```

Weekly cron instead (installs a local copy, no remote code at runtime):
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/update-lxcs-cron.sh)"
```
Exclude CTs in `/etc/update-lxcs.conf`: `EXCLUDE=100,101`. Log: `/var/log/update-lxcs-cron.log`.

Note: only the OS is updated, not apps installed inside the container.

## VMs

Inside each Debian/Ubuntu VM, once:
```
apt install unattended-upgrades && dpkg-reconfigure -plow unattended-upgrades
```

Or from the host, if `qemu-guest-agent` runs in the VMs:
```
for id in $(qm list | awk '$3=="running"{print $1}'); do
  qm guest exec "$id" --timeout 600 -- bash -c "apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y full-upgrade"
done
```

## Host

GUI: *Node → Updates → Refresh → Upgrade*, or `apt update && apt dist-upgrade`. Reboot after kernel updates.

## Notes

- Read remote scripts before piping them into `bash`.
- Snapshot or back up before large upgrades.

## References

- [community-scripts: PVE LXC Updater](https://community-scripts.org/scripts/update-lxcs)
- [community-scripts: Cron LXC Updater](https://community-scripts.org/scripts/cron-update-lxcs)
- [Debian: UnattendedUpgrades](https://wiki.debian.org/UnattendedUpgrades)
