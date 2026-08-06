# nvim

![preview](/assets/preview.jpg)

Minimal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Table of Contents
* [Features](#features)
* [Languages](#languages)
* [File Layout](#file-layout)
* [Requirements](#requirements)
* [Installation](#installation)
* [Keybindings](#keybindings)
* [Versioning](#versioning)
* [Troubleshooting](#troubleshooting)

> Full keybinding documentation: [`KEYBINDINGS.md`](KEYBINDINGS.md).

## Features

* lazy.nvim — lazy-loading, optimised startup.
* Which-key — discoverable leader bindings.
* LSP via mason.nvim + nvim-lspconfig (Lua, Python, JSON, TypeScript/React, CSS, HTML).
* Blink.cmp — autocompletion.
* Telescope — fuzzy finder (files, grep, buffers).
* Treesitter — syntax highlighting, text objects.
* Neo-tree — file explorer with git integration.
* Bufferline — tab-like buffer bar.
* Lualine — status line.
* Auto-sessions — restore editor state on restart.
* Flash — motion with labels.
* Conform — format on save (StyLua, Ruff, fixjson, prettierd).
* Gitsigns — git hunks, preview, blame.
* Noice / Trouble / Todo-comments.
* Auto cleanup — trailing whitespace stripped on save (skips prose and binaries).
* Soft wrapping only for prose filetypes (markdown, text, tex, rst).
* Semantic versioning with `:ConfigVersion` and `scripts/bump.sh`.

## Languages

Per-language tooling is configured centrally in `lua/config/languages.lua` —
a single entry controls the LSP servers, formatters and treesitter parsers
for a language. `lsp.nvim`, `mason.nvim`, `conform.nvim` and `treesitter.nvim`
all read from this file, so there are no duplicated lists.

```lua
-- lua/config/languages.lua
["TypeScript / React"] = {
    enabled = true,                                   -- false = disable the whole language
    ft = { "javascript", "typescript", "typescriptreact" }, -- filetypes for formatters
    lsp = { "ts_ls" },                                -- LSP servers (enabled + auto-installed)
    formatter = { "prettierd", "prettier" },          -- conform formatters (list or per-ft table)
    parsers = { "javascript", "typescript", "tsx" },  -- treesitter parsers
},
```

* **Adding a language** — add one entry and restart nvim: the LSP server and
  parsers install automatically via mason / nvim-treesitter.
* **Disabling a language** — set `enabled = false` to stop its servers from
  starting and its formatter from running on save. Installed binaries are not
  deleted from disk.

Currently configured: TypeScript/React, CSS, HTML, JSON, Lua, Python, Shell, C.

## File Layout

```
~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── CHANGELOG.md
├── KEYBINDINGS.md
├── scripts/
│   └── bump.sh
└── lua/
    ├── config/
    │   ├── options.lua
    │   ├── keymaps.lua
    │   ├── commands.lua
    │   ├── languages.lua
    │   ├── palette.lua
    │   ├── version.lua
    │   ├── lazy.lua
    │   └── autocmds.lua
    ├── plugins/
    │   ├── lsp.lua
    │   ├── mason.lua
    │   ├── treesitter.lua
    │   ├── telescope.lua
    │   ├── blink.lua
    │   ├── neo-tree.lua
    │   ├── bufferline.lua
    │   ├── lualine.lua
    │   ├── auto-session.lua
    │   ├── flash.lua
    │   ├── conform.lua
    │   ├── gitsigns.lua
    │   ├── noice.lua
    │   ├── trouble.lua
    │   ├── which-key.lua
    │   ├── todo-comments.lua
    │   ├── render-markdown.lua
    │   ├── comment.lua
    │   └── autopairs.lua
    ├── utils/
    │   └── hover.lua
    └── appearance/
        └── theme.lua
```

## Requirements

* Neovim >= 0.11
* Git
* A [Nerd Font](https://www.nerdfonts.com/)
* `ripgrep`, `fd`
* `make` / C compiler

## Installation

```bash
git clone https://github.com/diominvd/neovim.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

## Keybindings

Leader is `<Space>`. Pressing `<Space>` shows all groups and mappings
(which-key). The complete, up-to-date reference is in
[`KEYBINDINGS.md`](KEYBINDINGS.md).

### Leader groups (which-key)

| Prefix | Group |
| --- | --- |
| `<Space>f` | Find (Telescope) |
| `<Space>g` | Git |
| `<Space>s` | Split |
| `<Space>x` | Diagnostics / Trouble |

### Most used

| Key | Action |
| --- | --- |
| `<leader>w` / `<leader>W` | Save / save all and exit |
| `<leader>ff` | Find files |
| `gd` / `gr` | Go to definition / references |
| `]d` / `[d` | Next / previous diagnostic |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `s` / `S` | Flash jump / treesitter |
| `<leader>e` | Toggle file explorer |

## Versioning

The config follows [Semantic Versioning](https://semver.org/). The current
version lives in `lua/config/version.lua` and is shown with `:ConfigVersion`.

### Releasing a new version

1. Add a short summary of your changes under `## [Unreleased]` in `CHANGELOG.md`.
2. Run `./scripts/bump.sh patch` (or `minor` / `major`).
3. Push with `git push && git push --tags`.

The script moves the `[Unreleased]` entries into a dated release section,
bumps the version and creates an annotated `vX.Y.Z` tag — the tag is the
thing to link in a channel post about the update.

## Troubleshooting

| Problem | Solution |
| --- | --- |
| Icons missing | Install a [Nerd Font](https://www.nerdfonts.com/) |
| Telescope grep empty | Install `ripgrep` |
| Telescope find empty | Install `fd` |
| LSP not working | Run `:Mason` and install the server |
| Plug-in not loading | Check `:Lazy` for errors |
