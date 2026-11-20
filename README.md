# Agentic Cookbook

Short, practical recipes for recurring problems when running AI agents (Hermes Agent, OpenCode, …) in a homelab with Proxmox and a FRITZ!Box.

- Table of contents: [src/SUMMARY.md](src/SUMMARY.md)
- Recipe template: [src/template.md](src/template.md)

## Build

The book is built with [mdBook](https://rust-lang.github.io/mdBook/):

```sh
mdbook serve --open   # local preview
mdbook build          # output in ./book
```

Every push builds the book in GitHub Actions (`.github/workflows/build.yml`) as a check.
The rendered HTML is available as the `book` artifact of each run.
