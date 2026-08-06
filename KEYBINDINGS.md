# Keybindings Reference

Complete, up-to-date keybinding reference for this configuration.

## Conventions

| Symbol | Meaning |
| --- | --- |
| `<leader>` | `<Space>` (both `mapleader` and `maplocalleader` are `<Space>`) |
| `<C-…>` | `Ctrl` + key |
| `<S-…>` | `Shift` + key |
| `<A-…>` | `Alt` + key |
| `n` / `v` / `x` / `o` / `i` | Normal / Visual / Visual-block / Operator-pending / Insert mode |

* `<leader>w` means: press `<Space>`, then `w`.
* `]d` means: press `]`, then `d`.
* All mappings are `noremap` and `silent` unless noted otherwise.
* LSP and gitsigns mappings are **buffer-local** — they only exist while an LSP
  client / gitsigns is attached to the current buffer.
* The safest way to explore is pressing `<Space>` and following which-key groups.

## Leader Groups (which-key)

Pressing `<Space>` shows a popup with every group and mapping.

| Prefix | Group |
| --- | --- |
| `<Space>f` | Find (Telescope) |
| `<Space>g` | Git |
| `<Space>s` | Split |
| `<Space>x` | Diagnostics / Trouble |

## General

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>w` | n | Save buffer |
| `<Space>W` | n | Save all buffers and exit |
| `<Space>qq` | n | Quit without saving |
| `<Space>d` | n, v | Delete to the black-hole register (`"_d`) — nothing is lost from `"` |
| `<Space>y` | n, v | Yank line (`yy`) |
| `<Space>fmt` | n | Format current buffer (conform, falls back to LSP) |
| `<Space>e` | n | Toggle neo-tree file explorer |
| `<Space>mp` | n | Toggle markdown rendering (render-markdown) |
| `<Space>Q` | n | Delete current session and quit |

## Editing

| Key | Mode | Action |
| --- | --- | --- |
| `jk` / `kj` | i | Exit insert mode |
| `jk` / `kj` | v | Exit visual mode |
| `<` / `>` | v | Indent left / right, keeping the selection |
| `J` / `K` | v | Move selection down / up (re-indents) |
| `---` | i | Insert an em-dash (`—`) |

## Windows & Splits

| Key | Mode | Action |
| --- | --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | n | Move to the window left / down / up / right |
| `<C-q>` | n | Close current window |
| `<Space>sv` | n | Vertical split |
| `<Space>sh` | n | Horizontal split |

## Buffers

| Key | Mode | Action |
| --- | --- | --- |
| `<S-h>` | n | Previous buffer |
| `<S-l>` | n | Next buffer |
| `<S-x>` | n | Close buffer (smart: jumps to the alternate/previous buffer first) |
| `<S-p>` | n | Toggle buffer pin (Bufferline) |
| `<A-h>` | n | Move buffer left (Bufferline) |
| `<A-l>` | n | Move buffer right (Bufferline) |

## Find (Telescope)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>ff` | n | Find files (`fd`, hidden files, `.git` excluded) |
| `<Space>fg` | n | Live grep across the project (hidden files included) |
| `<Space>fw` | n | Grep the word under the cursor |
| `<Space>fb` | n | List open buffers |
| `<Space>fo` | n | Recent files (`oldfiles`) |
| `<Space>fh` | n | Search `:help` tags |
| `<Space>ft` | n | Find TODOs / FIXMEs (todo-comments) |
| `<Space>fk` | n | Show all keymaps |
| `<Space>fs` | n | Search & restore sessions (auto-session) |

## Git

| Key | Mode | Action |
| --- | --- | --- |
| `]h` | n | Next hunk (gitsigns) |
| `[h` | n | Previous hunk (gitsigns) |
| `<Space>gp` | n | Preview hunk (gitsigns) |
| `<Space>gb` | n | Git blame for current line (gitsigns) |
| `<Space>gc` | n | Browse git commits (Telescope) |
| `<Space>gs` | n | Git status / changed files (Telescope) |
| `<Space>gl` | n | Browse git branches (Telescope) |

## LSP

Active only while an LSP server is attached to the buffer.

| Key | Mode | Action |
| --- | --- | --- |
| `K` | n | Hover + diagnostics combined window (opens anywhere, forces) |
| `gd` | n | Go to definition |
| `gr` | n | Find references |
| `<Space>rn` | n | Rename symbol |
| `<Space>ca` | n | Code action |
| `<C-k>` | i | Signature help |

## Diagnostics

| Key | Mode | Action |
| --- | --- | --- |
| `]d` / `[d` | n | Next / previous diagnostic |
| `]e` / `[e` | n | Next / previous error only |
| `<Space>xx` | n | Toggle project diagnostics (Trouble) |
| `<Space>xb` | n | Toggle buffer diagnostics (Trouble) |
| `<Space>xq` | n | Toggle quickfix list (Trouble) |

## Comments

| Key | Mode | Action |
| --- | --- | --- |
| `gc` | n, v | Toggle comment (line-wise) |
| `gb` | n, v | Toggle block comment |

JSX-aware: `gc` on JSX elements uses `{/* */}`.

## Treesitter Text Objects

Select (works as a motion — combine with operators):

| Key | Mode | Object |
| --- | --- | --- |
| `af` / `if` | x, o | Function (outer / inner) |
| `ac` / `ic` | x, o | Class (outer / inner) |
| `aa` / `ia` | x, o | Parameter (outer / inner) |
| `al` / `il` | x, o | Loop (outer / inner) |
| `ai` / `ii` | x, o | Conditional (outer / inner) |

Examples:
* `daf` — delete the whole function under the cursor.
* `yif` — yank the function body without its signature.
* `ciw`-style: `cia` — change the parameter under the cursor.

Move (next / previous):

| Key | Mode | Object |
| --- | --- | --- |
| `]f` / `[f` | n, x, o | Next / previous function |
| `]]` / `[[` | n, x, o | Next / previous class |

## Completion (Blink, insert mode)

| Key | Action |
| --- | --- |
| `<C-space>` | Show completion / documentation |
| `<C-e>` | Hide completion |
| `<CR>` | Accept selected item (falls back to newline if none) |
| `<Tab>` | Select next item (falls back to tab) |
| `<S-Tab>` | Select previous item (falls back to tab) |
| `<C-b>` | Scroll documentation up |
| `<C-f>` | Scroll documentation down |

## Flash

| Key | Mode | Action |
| --- | --- | --- |
| `s` | n, x, o | Flash jump (label-based motion) |
| `S` | n, x, o | Flash treesitter (jump to treesitter nodes) |

## File Explorer (Neo-tree window)

| Key | Action |
| --- | --- |
| `l` | Open file / expand node |
| `h` | Close node / go to parent |
| `v` | Open in vertical split |
| `s` | Open in horizontal split |
| `<Space>` | Disabled (reserved for the leader) |

## Telescope Picker Window

| Key | Mode | Action |
| --- | --- | --- |
| `<C-j>` / `<C-k>` | i | Move selection down / up |
| `<C-q>` | i | Close picker |
| `q` | n | Close picker |

## Sessions (auto-session)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>fs` | n | Search & restore a saved session |
| `<Space>Q` | n | Delete current session and quit |

Sessions are saved automatically on exit and restored on startup (except for
`/`, `~` and `~/Downloads`).
