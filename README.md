# Agentic Cookbook

Rezepte und Notizen zum Betrieb von KI-Agenten (z. B. Hermes Agent, OpenCode) im Homelab mit Proxmox und FRITZ!Box.

## Inhalt

| Rezept | Thema |
|---|---|
| [proxmox/vm-vs-lxc.md](proxmox/vm-vs-lxc.md) | Agent in VM oder LXC? Overhead und Sicherheitsrisiko |
| [proxmox/nas-share.md](proxmox/nas-share.md) | NAS-Share (NFS/SMB) in VM oder unprivilegierten LXC einbinden, TUN im LXC |
| [proxmox/firewall-isolation.md](proxmox/firewall-isolation.md) | Agent-VM ohne VLANs abschotten (Proxmox-Firewall, FRITZ!Box) |

## Grundsätze

1. **Agent in eine VM**, nicht in einen LXC, sobald er Code oder Shell-Befehle ausführt.
2. **Netzwerk begrenzen** bringt mehr als die Wahl zwischen VM und LXC: Der Agent erreicht nur Internet und die Dienste, die er wirklich braucht.
3. **API-Keys mit Budget-Limit** verwenden, nur für den Agenten.
4. **Shares read-only** mounten, wenn Lesen reicht.
5. **Snapshots** vor größeren Änderungen.
