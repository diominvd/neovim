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
| `<Space>c` | Code |
| `<Space>f` | Find (Telescope) |
| `<Space>g` | Git |
| `<Space>h` | Help |
| `<Space>i` | Inlay |
| `<Space>m` | Markdown |
| `<Space>q` | Quit / Session |
| `<Space>r` | Refactor |
| `<Space>s` | Split |
| `<Space>t` | Terminal |
| `<Space>u` | Undo / Format |
| `<Space>x` | Diagnostics / Trouble |

## General

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>w` | n | Save buffer |
| `<Space>W` | n | Save all buffers and exit |
| `<Space>qq` | n | Quit without saving |
| `<Space>hk` | n | Open this reference (`KEYBINDINGS.md`) |
| `<Space>hh` | n | Clear the search highlight (`:noh`) |
| `<Space>d` | n, v | Delete to the black-hole register (`"_d`) — nothing is lost from `"` |
| `<Space>y` | n | Yank line (`yy`) |
| `<Space>y` | v | Yank the selection |
| `<Space>uF` | n | Toggle auto-format on save (conform) |
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
| `<Space>gd` | n | Diff current file against HEAD (gitsigns) |
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
| `gD` | n | Go to declaration |
| `gy` | n | Go to type definition |
| `gI` | n | Go to implementation |
| `<Space>rn` | n | Rename symbol |
| `<Space>ca` | n | Code action |
| `<Space>ih` | n | Toggle inlay hints |
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
| `]k` / `[k` | n, x, o | Next / previous class |

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

## Terminal

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>t` | n | Toggle the bottom-anchored floating terminal (confined to the editor area) |
| `<Space>gg` | n | Open lazygit fullscreen (requires the `lazygit` binary) |

## Folding

Buffers with a treesitter parser fold with `foldmethod=expr` (tree-sitter based).
`zc` / `zo` close / open a fold, `zM` / `zR` close / open all folds. Fold levels
start fully open (`foldlevelstart = 99`).

## Flash

| Key | Mode | Action |
| --- | --- | --- |
| `s` | n, x, o | Flash jump (label-based motion) |
| `S` | n, x, o | Flash treesitter (jump to treesitter nodes) |

## Undo

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>uu` | n | Open the undo tree (visual history of all changes) |

## Surround (mini.surround)

Work on surrounding characters (quotes, brackets, tags, words).

| Key | Mode | Action |
| --- | --- | --- |
| `gsa` | n, v | Add surrounding — e.g. `gsaiw"` wraps the word in `"` |
| `gsd` | n, v | Delete surrounding — `gsd"` turns `"foo"` into `foo` |
| `gsr` | n, v | Replace surrounding — `gsr"` then `'` turns `"foo"` into `'foo'` |
| `gsf` | n | Find the surrounding to the right |
| `gsF` | n | Find the surrounding to the left |
| `gsh` | n, v | Highlight the current surrounding |
| `gsn` | n | Set the number of lines for the search (`updaten_lines`) |

Examples:
* `gsaiw"` — wrap the word under the cursor in `"`.
* `gsd'` — strip the surrounding `'` from `'foo'`.
* `gsr[` then `(` — change `[foo]` into `(foo)`.
* In visual mode select text and press `gsa` + a character to wrap the selection.

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
