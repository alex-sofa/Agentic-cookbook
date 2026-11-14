# Agent-VM ohne VLANs abschotten

Die FRITZ!Box kann keine VLANs. Einfachste Lösung: **Proxmox-Firewall pro VM.** Die Regeln greifen auf dem Host, der Agent kann sie auch als Root in der VM nicht abschalten.

## Einrichtung

1. Firewall aktivieren auf allen Ebenen: **Datacenter → Node → VM**.
2. An der Netzwerkkarte der VM `firewall=1` setzen (Hardware → Network Device → Firewall).
3. In den Firewall-Optionen der VM **IP filter** und **MAC filter** aktivieren, damit die VM ihre Adresse nicht ändern kann.
4. Eingehende Policy: `DROP`. Ausgehende Policy: `ACCEPT`.

## Regeln

Werden von oben nach unten geprüft, die erste passende gilt. Beispiel für das FRITZ!Box-Standardnetz `192.168.178.0/24`:

| # | Richtung | Aktion | Ziel / Quelle | Proto | Port | Zweck |
|---|---|---|---|---|---|---|
| 1 | out | ACCEPT | 192.168.178.1 | udp | 53 | DNS |
| 2 | out | ACCEPT | 192.168.178.1 | tcp | 53 | DNS |
| 3 | out | ACCEPT | `<LiteLLM-IP>` | tcp | 4000 | LLM-Proxy |
| 4 | out | ACCEPT | `<NAS-IP>` | tcp | 2049 | NFS (bzw. 445 für SMB) |
| 5 | out | DROP | 192.168.178.0/24 | | | restliches LAN sperren |
| 6 | in | ACCEPT | `<PC-IP>` (Quelle) | tcp | 22 | SSH von deinem PC |

Alles andere ausgehend (Internet, Tailscale) bleibt durch die Policy erlaubt.

Datei-Variante: `/etc/pve/firewall/<VMID>.fw`
```
[OPTIONS]
enable: 1
ipfilter: 1
macfilter: 1
policy_in: DROP
policy_out: ACCEPT

[RULES]
OUT ACCEPT -dest 192.168.178.1 -p udp -dport 53
OUT ACCEPT -dest 192.168.178.1 -p tcp -dport 53
OUT ACCEPT -dest <LiteLLM-IP> -p tcp -dport 4000
OUT ACCEPT -dest <NAS-IP> -p tcp -dport 2049
OUT DROP -dest 192.168.178.0/24
IN ACCEPT -source <PC-IP> -p tcp -dport 22
```

## Alternativen

- **Gast-LAN der FRITZ!Box (LAN 4):** echt getrenntes Netz. Braucht eine zweite Netzwerkkarte am Proxmox-Host. Von dort sind LiteLLM und NAS nicht mehr direkt erreichbar.
- **OPNsense als VM:** interner Bridge `vmbr1` ohne physischen Port, OPNsense routet zwischen `vmbr0` (FRITZ!Box-LAN) und `vmbr1`. Echte Segmente und Logs, aber doppeltes NAT und mehr Aufwand.
