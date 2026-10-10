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
  client / gitsigns is attached to the current buffer. The only exception is
  `K` (hover), which is global so it works in any buffer.
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
| `<Space>M` | Mason |
| `<Space>o` | Opencode (AI) |
| `<Space>q` | Quit / Session |
| `<Space>r` | Refactor |
| `<Space>s` | Split |
| `<Space>sk` | Sidekick (AI) |
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
| `<Space>E` | n | Collapse the explorer tree to its root (close all open folders) |
| `<Space>mp` | n | Toggle markdown rendering (render-markdown) |
| `<Space>Q` | n | Delete current session and quit |

## Editing

| Key | Mode | Action |
| --- | --- | --- |
| `jk` / `kj` | i | Exit insert mode (better-escape, ~150 ms) |
| `<` / `>` | v | Indent left / right, keeping the selection |
| `J` / `K` | v | Move selection down / up (re-indents) |
| `---` | i | Insert an em-dash (`—`) — prose filetypes only (`text`, `tex`, `rst`) |

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
| `K` | n | Hover + diagnostics combined window (global; works without LSP too) |
| `gK` | n | Signature help |
| `gd` | n | Go to definition |
| `gr` | n | Find references |
| `gD` | n | Go to declaration |
| `gy` | n | Go to type definition |
| `gI` | n | Go to implementation |
| `<Space>rn` | n | Rename symbol |
| `<Space>ca` | n, v | Code action with diff preview (actions-preview) |
| `<Space>ih` | n | Toggle inlay hints |
| `<C-k>` | i | Signature help |

Reference navigation — highlights every occurrence of the word under the cursor
(`snacks.words`):

| Key | Mode | Action |
| --- | --- | --- |
| `]]` / `[[` | n | Next / previous occurrence of the word under the cursor |
| `<a-n>` / `<a-p>` | n | Next / previous occurrence (wraps around) |

## Diagnostics

| Key | Mode | Action |
| --- | --- | --- |
| `]d` / `[d` | n | Next / previous diagnostic |
| `]e` / `[e` | n | Next / previous error only |
| `<Space>xx` | n | Toggle project diagnostics (Trouble) |
| `<Space>xb` | n | Toggle buffer diagnostics (Trouble) |
| `<Space>cs` | n | Toggle file outline / symbols (Trouble) |
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
| `<C-n>` / `<C-p>` | Select next / previous item |
| `<C-y>` | Accept the selected item |
| `<C-e>` | Hide completion |
| `<CR>` | Accept selected item (falls back to newline if none) |
| `<Tab>` | Select next item (falls back to tab) |
| `<S-Tab>` | Select previous item (falls back to tab) |
| `<C-b>` | Scroll documentation up |
| `<C-f>` | Scroll documentation down |

Documentation for the highlighted candidate opens automatically (after ~200 ms),
and a signature-help popup appears while a call is being typed. Completion also
works in the command line (`:`) — use `<Tab>` to accept there.

## Terminal

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>t` | n | Toggle the bottom-anchored floating terminal (confined to the editor area) |
| `<Space>gg` | n | Open lazygit fullscreen (requires the `lazygit` binary) |

## Debugging (DAP)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>db` | n | Toggle breakpoint |
| `<Space>dc` | n | Continue / start debug |
| `<Space>dso` | n | Step over |
| `<Space>dsi` | n | Step into |
| `<Space>dui` | n | Toggle debug UI (dap-ui) |
| `<Space>deb` | n | Show breakpoints panel |
| `<Space>dev` | n | Evaluate expression |

## Testing (Neotest)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>tr` | n | Run nearest test |
| `<Space>tf` | n | Run all tests in current file |
| `<Space>td` | n | Debug nearest test |
| `<Space>ts` | n | Toggle test summary panel |
| `<Space>to` | n | Open test output (enter to close) |

## AI — Opencode

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>oa` | n | Ask OpenCode (with buffer context) |
| `<Space>os` | v | Send visual selection to OpenCode |
| `<Space>ot` | n | Toggle OpenCode window |
| `<Space>on` | n | Start new OpenCode session |

## AI — Sidekick

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>sk` | n | Open Sidekick |
| `<Space>sc` | n | Open Sidekick CLI (opencode/claude/codex) |
| `<Space>sn` | n | New Sidekick session |

## Git Diff (Diffview)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>do` | n | Open diff view |
| `<Space>dh` | n | Open file history |

## Search & Replace (Grug-far)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>fr` | n | Open project-wide search and replace |

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
| `W` | Collapse the whole tree to its root (close all open folders) |
| `<Space>` | Disabled (reserved for the leader) |

## Telescope Picker Window

| Key | Mode | Action |
| --- | --- | --- |
| `<C-j>` / `<C-k>` | i | Move selection down / up |
| `<C-q>` | i | Close picker |
| `q` | n | Close picker |

## Mason (language tooling)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>Mi` | n | Install every LSP server / formatter from `lua/config/languages.lua` |
| `<Space>Mo` | n | Open the Mason registry (`:Mason`) |

## Sessions (auto-session)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>fs` | n | Search & restore a saved session |
| `<Space>Q` | n | Delete current session and quit |

Sessions are saved automatically on exit and restored on startup (except for
`/`, `~` and `~/Downloads`).

## Hardtime (training)

[hardtime.nvim](https://github.com/m4xshen/hardtime.nvim) is enabled by default
and helps you break bad habits while learning Vim motions:

* **Blocks the arrow keys** in normal, insert, visual and terminal modes — use
  `hjkl` (or counts, e.g. `5j`) instead.
* **Disables the mouse**.
* **Detects repeated keys** (e.g. `j j j` within a second) and hints a better
  command (e.g. `3j`), plus suggests more efficient alternatives — `D` instead
  of `d$`, `A` instead of `$a`, `C` instead of `ciw`, and so on.

| Command | Action |
| --- | --- |
| `:Hardtime toggle` | Turn hardtime on / off for the current session |
| `:Hardtime enable` / `:Hardtime disable` | Force hardtime on / off |
| `:Hardtime report` | Show your most frequent bad habits |

Hints are shown via `vim.notify` (rendered by Noice). A log is written to
`~/.local/state/nvim/hardtime.nvim.log`.
