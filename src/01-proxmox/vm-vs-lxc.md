# Agent in a VM or an LXC?

**Problem:** An agent runs shell commands, installs packages and processes untrusted web content. Where should it live?

**Solution:** Use a small VM. Use an LXC only if the agent never executes code locally.

## Why a VM

- An LXC shares the host kernel; a VM is a much stronger boundary.
- Docker sandboxes, Tailscale, Chromium/Playwright and NFS/SMB mounts work without device passthrough, nesting or AppArmor tweaks.
- Easier to justify as a security boundary for multi-user setups.

## Overhead

| | VM | LXC |
|---|---|---|
| Idle RAM (minimal Debian) | ~150–300 MB | ~20–50 MB |
| CPU overhead (KVM) | ~1–5 % | ~0 % |
| Extra disk | ~2–4 GB guest OS | small |

Keep it low:

- Enable **ballooning** (set min/max memory) so unused RAM returns to the host.
- Enable **KSM** on the host.
- CPU type `host`; disk on **VirtIO SCSI single** with **IO thread**.

Sizing for Hermes: **2 vCPU, 2–4 GB RAM**. More only for browser tools or Docker sandboxes.

## How risky is an LXC?

- **Unprivileged LXC** (Proxmox default): container root is UID 100000+ on the host. An escape practically requires a kernel vulnerability (e.g. Dirty COW, Dirty Pipe, CVE-2022-0185). These appear a few times per year and are patched quickly. Keep the host updated.
- **Privileged LXC:** not a security boundary.
- **VM escapes** via KVM/QEMU are much rarer; the attack surface is far smaller.

## The more realistic risk

Not an escape, but abuse of what the agent is already allowed to do (e.g. via prompt injection): leaking API keys, reaching other LAN services, modifying mounted data. Counter it with [network isolation](../02-networking/isolation-without-vlans.md), budget-limited keys, read-only mounts and backups.

## References

- [Proxmox: Unprivileged LXC containers](https://pve.proxmox.com/wiki/Unprivileged_LXC_containers)
- [LXC security](https://linuxcontainers.org/lxc/security/)
