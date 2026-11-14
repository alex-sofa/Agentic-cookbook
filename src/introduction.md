# Introduction

A collection of concrete, recurring problems and their solutions when running AI agents at home. Each recipe is short: problem, solution, commands, references.

## Ground rules

1. **Run agents in a VM**, not an LXC, as soon as they execute code or shell commands.
2. **Restrict the network.** It matters more than VM vs. LXC: the agent reaches the internet and only the services it needs.
3. **Use dedicated API keys with a budget limit** for each agent.
4. **Mount shares read-only** when reading is enough.
5. **Snapshot** before larger changes.
