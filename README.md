# nvim

![preview](/assets/preview.jpg)

Minimal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Table of Contents
* [Features](#features)
* [File Layout](#file-layout)
* [Requirements](#requirements)
* [Installation](#installation)
* [Keybindings](#keybindings)
* [Versioning](#versioning)
* [Troubleshooting](#troubleshooting)

## Features

* lazy.nvim — lazy-loading, optimised startup.
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
* Semantic versioning with `:ConfigVersion` and `scripts/bump.sh`.

## File Layout

```
~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── CHANGELOG.md
├── scripts/
│   └── bump.sh
└── lua/
    ├── config/
    │   ├── options.lua
    │   ├── keymaps.lua
    │   ├── commands.lua
    │   ├── languages.lua
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

Leader is `<Space>`.

### General

| Key | Action |
| --- | --- |
| `jk` / `kj` | Exit insert mode |
| `<leader>w` | Save buffer |
| `<leader>wq` | Save all and exit |
| `<leader>qq` | Exit without saving |
| `<leader>d` | Delete to black hole |
| `<leader>y` | Yank line |

### Find (Telescope)

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Grep word under cursor |
| `<leader>fb` | Buffers |
| `<leader>fo` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>ft` | Find TODOs |
| `<leader>fk` | Show keymaps |

### Buffers

| Key | Action |
| --- | --- |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<S-x>` | Close buffer (smart) |
| `<S-p>` | Pin buffer |
| `<A-h>` / `<A-l>` | Move buffer left / right |

### Editing

| Key | Action |
| --- | --- |
| `<` / `>` (visual) | Indent left / right |
| `J` / `K` (visual) | Move selection down / up |
| `---` (insert) | Insert em-dash |

### Windows

| Key | Action |
| --- | --- |
| `<C-h/j/k/l>` | Navigate windows |
| `<C-q>` | Close window |
| `<leader>sv` / `<leader>sh` | Vertical / horizontal split |

### LSP

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover + diagnostics |
| `<C-k>` | Signature help (insert) |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |

### Git

| Key | Action |
| --- | --- |
| `]h` / `[h` | Next / previous hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |

### Treesitter Textobjects

| Key | Action |
| --- | --- |
| `af` / `if` | Function (outer / inner) |
| `ac` / `ic` | Class (outer / inner) |
| `aa` / `ia` | Parameter (outer / inner) |
| `]f` / `[f` | Next / previous function |
| `]]` / `[[` | Next / previous class |

### Other

| Key | Action |
| --- | --- |
| `s` / `S` | Flash jump / treesitter |
| `<leader>e` | Toggle file explorer |
| `<leader>fmt` | Format buffer |
| `<leader>xx` | Diagnostics (Trouble) |
| `<leader>xb` | Buffer diagnostics (Trouble) |
| `<leader>xq` | Quickfix list (Trouble) |
| `<leader>mp` | Toggle markdown render |
| `<leader>Q` | Delete session and quit |

See `lua/config/keymaps.lua` for the full list.

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
