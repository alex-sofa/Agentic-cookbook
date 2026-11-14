# NAS-Share einbinden

## In einer VM (einfach)

Share direkt in der VM mounten, wie auf jedem Linux-System.

NFS (`/etc/fstab`):
```
<NAS-IP>:/volume1/daten  /mnt/nas  nfs  ro,_netdev,nofail  0  0
```

SMB/CIFS (`/etc/fstab`, Zugangsdaten in `/root/.smbcred` mit `chmod 600`):
```
//<NAS-IP>/daten  /mnt/nas  cifs  ro,credentials=/root/.smbcred,uid=1000,gid=1000,_netdev,nofail  0  0
```

`ro` weglassen, wenn der Agent schreiben muss.

## In einem unprivilegierten LXC

Im unprivilegierten LXC funktionieren NFS/CIFS-Mounts nicht direkt. Üblicher Weg: **auf dem Host mounten, per Bind-Mount durchreichen.**

1. Auf dem Proxmox-Host mounten (z. B. per `/etc/fstab` nach `/mnt/nas`).
2. In den Container reichen:
   ```
   pct set <CTID> -mp0 /mnt/nas,mp=/mnt/nas
   ```
3. UIDs anpassen. Im unprivilegierten LXC gilt:
   - Root im Container = UID 100000 auf dem Host
   - User 1000 im Container = UID 101000 auf dem Host

   - **CIFS:** auf dem Host mit `uid=101000,gid=101000` mounten.
   - **NFS:** am NAS Squash/anonuid auf die passende ID setzen.

## TUN im unprivilegierten LXC (z. B. für Tailscale)

In `/etc/pve/lxc/<CTID>.conf` ergänzen und Container neu starten:
```
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```
