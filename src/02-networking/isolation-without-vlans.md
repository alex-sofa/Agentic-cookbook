# Isolating an agent VM without VLANs

**Problem:** The FRITZ!Box has no VLAN support, but the agent should not reach the rest of the LAN.

**Solution:** Use the Proxmox firewall per VM. Rules are enforced on the host, so the agent cannot disable them even as root inside the VM.

## Steps

1. Enable the firewall at **Datacenter**, **Node** and **VM** level.
2. Set `firewall=1` on the VM's network device.
3. In the VM firewall options enable **IP filter** and **MAC filter** (prevents address spoofing).
4. Policies: inbound `DROP`, outbound `ACCEPT`.
5. Add rules (first match wins). Example for the FRITZ!Box default `192.168.178.0/24`, file `/etc/pve/firewall/<VMID>.fw`:

```
[OPTIONS]
enable: 1
ipfilter: 1
macfilter: 1
policy_in: DROP
policy_out: ACCEPT

[RULES]
OUT ACCEPT -dest 192.168.178.1 -p udp -dport 53     # DNS
OUT ACCEPT -dest 192.168.178.1 -p tcp -dport 53     # DNS
OUT ACCEPT -dest <LITELLM-IP> -p tcp -dport 4000    # LLM proxy
OUT ACCEPT -dest <NAS-IP> -p tcp -dport 2049        # NFS (445 for SMB)
OUT DROP -dest 192.168.178.0/24                     # rest of the LAN
IN ACCEPT -source <PC-IP> -p tcp -dport 22          # SSH from your PC
```

Everything else outbound (internet, Tailscale) stays allowed by the policy.

## Alternatives

- **FRITZ!Box guest LAN (port LAN 4):** a truly separate network. Needs a second NIC on the Proxmox host; LiteLLM and the NAS are then not directly reachable.
- **OPNsense VM:** internal bridge `vmbr1` without a physical port, OPNsense routes between `vmbr0` (FRITZ!Box LAN) and `vmbr1`. Real segments and logs, but double NAT and more effort.

## References

- [Proxmox VE Firewall](https://pve.proxmox.com/wiki/Firewall)
