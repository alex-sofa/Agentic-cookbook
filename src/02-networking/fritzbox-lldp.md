# Proxmox host not recognized by the FRITZ!Box

**Problem:** The Proxmox host (static IP, no DHCP) shows up in the FRITZ!Box network overview without a proper name or connection info.

**Solution:** Install `lldpd` on the host. FRITZ!OS (7.50+) understands LLDP for directly connected devices.

## Steps

```
apt install lldpd
lldpcli show neighbors     # should list the FRITZ!Box after ~30 s
```

If syslog repeats `cannot connect to /var/agentx/master`, remove `-x` (SNMP subagent) from `DAEMON_ARGS` in `/etc/default/lldpd` and run `systemctl restart lldpd`.

## Notes

- LLDP only works between directly cabled neighbors; devices behind an unmanaged switch stay invisible to the box.
- Do this on every PVE node.

## References

- [Proxmox forum: LLDP for FRITZ!Box online display](https://forum.proxmox.com/goto/post?id=756325)
