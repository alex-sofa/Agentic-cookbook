# Agent in VM oder LXC?

**Empfehlung:** VM, sobald der Agent Shell-Befehle ausführt, Pakete installiert oder Inhalte aus dem Netz verarbeitet.

## Warum VM

- **Isolation:** Ein LXC teilt sich den Kernel mit dem Proxmox-Host. Eine VM ist die härtere Grenze.
- **Docker-Sandbox** für Terminal-Backends läuft in einer VM ohne Nesting/keyctl-Tricks.
- **Tailscale, Chromium/Playwright, systemd** laufen ohne Gerätefreigaben oder AppArmor-Ärger.
- **NAS-Shares** lassen sich direkt in der VM mounten (siehe [nas-share.md](nas-share.md)).
- **Multi-User:** Eine VM als Sicherheitsgrenze ist leichter zu begründen.

## Wann LXC reicht

- Agent läuft nur als Gateway/Chat, ohne lokale Code-Ausführung.
- RAM ist wirklich knapp.

## Overhead der VM

| | VM | LXC |
|---|---|---|
| RAM im Leerlauf (minimales Debian) | ca. 150–300 MB | ca. 20–50 MB |
| CPU-Overhead (KVM) | ca. 1–5 % | ~0 % |
| Zusätzlicher Speicherplatz | ca. 2–4 GB Gast-OS | gering |

Einstellungen, die den Overhead klein halten:

- **Ballooning** aktivieren (Minimum/Maximum setzen), damit ungenutzter RAM zurück an den Host geht.
- **KSM** auf dem Host teilt identische Speicherseiten.
- CPU-Typ `host`.
- Disk: VirtIO SCSI single + IO-Thread.

Richtwert für Hermes: **2 vCPU, 2–4 GB RAM** mit Ballooning. Mehr nur bei Browser-Tools oder Docker-Sandboxes.

## Wie riskant ist LXC wirklich?

- **Unprivilegierter LXC** (Proxmox-Standard): Root im Container ist auf dem Host UID 100000+. Ein Ausbruch braucht praktisch eine Kernel-Lücke (Beispiele: Dirty COW, Dirty Pipe, CVE-2022-0185). Solche Lücken kommen einige Male pro Jahr vor und werden meist schnell gepatcht. Proxmox aktuell halten.
- **Privilegierter LXC:** keine Sicherheitsgrenze.
- **VM:** Ausbrüche über KVM/QEMU sind deutlich seltener, die Angriffsfläche ist kleiner.

## Das realistischere Risiko

Kein Ausbruch, sondern Missbrauch dessen, was der Agent ohnehin darf, z. B. per Prompt Injection:

- API-Keys exfiltrieren
- andere Dienste im LAN ansprechen (Proxmox-UI, NAS, Medienserver)
- Daten in gemounteten Ordnern ändern oder löschen

Gegenmaßnahmen: Netzwerk abschotten ([firewall-isolation.md](firewall-isolation.md)), Keys mit Budget-Limit, Shares read-only, Backups.
