# Mounting a NAS share

**Problem:** Unprivileged LXCs cannot mount NFS/CIFS. Host mounts appear read-only in the container because host root maps to `nobody`. Privileged LXCs are blocked by AppArmor.

**Solution:** In a VM, mount directly. In an LXC, mount once per share on the host with the right owner and bind-mount it.

## VM

`/etc/fstab`:
```
<NAS-IP>:/volume1/data  /mnt/nas  nfs   ro,_netdev,nofail  0 0
//<NAS-IP>/data         /mnt/nas  cifs  ro,credentials=/root/.smbcred,uid=1000,gid=1000,_netdev,nofail  0 0
```

## Unprivileged LXC: host mount + owner mapping (default)

Container UID `n` is host UID `100000 + n`. Mount on the host with that owner, then bind-mount. One mount per share covers all subfolders; the same host mount can go into several containers.

One command with [`tools/nas-mount.sh`](https://github.com/alexschultze/Agentic-cookbook/blob/main/tools/nas-mount.sh):
```
nas-mount.sh <CTID> //<NAS-IP>/data      # writable for CT user 1000
```

```bash
{{#include ../../tools/nas-mount.sh}}
```

**NFS:** owner options don't exist; set *all squash* on the NAS to the owning user instead.

## Unprivileged LXC: 1:1 idmap

Makes CT UID 1000 equal host UID 1000 (useful for NFS or many containers). `/etc/pve/lxc/<CTID>.conf`:
```
lxc.idmap: u 0 100000 1000
lxc.idmap: g 0 100000 1000
lxc.idmap: u 1000 1000 1
lxc.idmap: g 1000 1000 1
lxc.idmap: u 1001 101001 64535
lxc.idmap: g 1001 101001 64535
```
Add `root:1000:1` to `/etc/subuid` and `/etc/subgid`. Then use `HOST_UID=1000 nas-mount.sh …`.

## Privileged LXC (not for agents)

```
pct set <CTID> -features mount=nfs\;cifs
```
Lifts the AppArmor block; mount inside the container as usual.

## TUN in an unprivileged LXC (e.g. Tailscale)

`/etc/pve/lxc/<CTID>.conf`:
```
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```

## References

- [Proxmox: bind mount points](https://pve.proxmox.com/wiki/Linux_Container#_bind_mount_points)
- [Proxmox: Unprivileged LXC containers](https://pve.proxmox.com/wiki/Unprivileged_LXC_containers)
- [Tailscale in LXC containers](https://tailscale.com/kb/1130/lxc-unprivileged)
