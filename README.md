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

Pushing to `main` publishes the book to GitHub Pages via `.github/workflows/pages.yml`
(enable it once under *Settings → Pages → Source: GitHub Actions*).
