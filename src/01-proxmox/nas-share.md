# Mounting a NAS share

**Problem:** The agent needs data from the NAS. NFS/CIFS mounts fail inside an unprivileged LXC.

**Solution:** In a VM, mount directly. In an unprivileged LXC, mount on the host and bind-mount into the container.

## VM

NFS (`/etc/fstab`):
```
<NAS-IP>:/volume1/data  /mnt/nas  nfs  ro,_netdev,nofail  0  0
```

SMB/CIFS (`/etc/fstab`; credentials in `/root/.smbcred`, `chmod 600`):
```
//<NAS-IP>/data  /mnt/nas  cifs  ro,credentials=/root/.smbcred,uid=1000,gid=1000,_netdev,nofail  0  0
```

Drop `ro` only if the agent must write.

## Unprivileged LXC

1. Mount the share on the Proxmox host, e.g. at `/mnt/nas`.
2. Bind-mount it into the container:
   ```
   pct set <CTID> -mp0 /mnt/nas,mp=/mnt/nas
   ```
3. Match UIDs. Container root = host UID 100000, container user 1000 = host UID 101000.
   - **CIFS:** mount on the host with `uid=101000,gid=101000`.
   - **NFS:** set squash/anonuid on the NAS accordingly.

## TUN in an unprivileged LXC (e.g. Tailscale)

Add to `/etc/pve/lxc/<CTID>.conf` and restart the container:
```
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```

## References

- [Proxmox: Linux Container – bind mount points](https://pve.proxmox.com/wiki/Linux_Container#_bind_mount_points)
- [Proxmox: Unprivileged LXC containers](https://pve.proxmox.com/wiki/Unprivileged_LXC_containers)
- [Tailscale in LXC containers](https://tailscale.com/kb/1130/lxc-unprivileged)
