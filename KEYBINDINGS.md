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
| `<Space>a` | Assist / Sidekick (AI) |
| `<Space>c` | Code |
| `<Space>d` | Debug (DAP) |
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
| `<Space>t` | Test (Neotest) |
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
| `<Space>D` | n, v | Delete to the black-hole register (`"_d`) — nothing is lost from `"` |
| `<Space>y` | n | Yank line (`yy`) |
| `<Space>y` | v | Yank the selection |
| `<Space>uF` | n | Toggle auto-format on save (conform) |
| `<Space>uc` | n | Toggle the habit coach (`:Coach`) |
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
| `<Space>bd` | n | Delete the current buffer, keeping the window layout (snacks) |
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
| `<Space>fr` | n | Project-wide search & replace (grug-far) |

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
| `<Space>gv` | n | Diff view of the working tree (diffview) |
| `<Space>gh` | n | Diff view of the current file history (diffview) |
| `<Space>gr` | n | Open the remote repository in a browser (snacks.gitbrowse) |
| `<Space>gz` | n | Zen mode — distraction-free window (snacks.zen) |
| `<Space>gg` | n | Open lazygit fullscreen (requires the `lazygit` binary) |

## LSP

Active only while an LSP server is attached to the buffer. The `gr*` keys are
Neovim's own defaults (0.11+), so `:help lsp-defaults` and tutorials match;
the ones that produce a list open it in Telescope.

| Key | Mode | Action |
| --- | --- | --- |
| `K` | n | Hover + diagnostics combined window (global; works without LSP too) |
| `gd` | n | Go to definition (Telescope when there are several) |
| `grr` | n | References (Telescope) |
| `gri` | n | Implementations (Telescope) |
| `grt` | n | Type definition (Telescope) |
| `gO` | n | Symbols in the file (Telescope) |
| `<Space>fS` | n | Symbols in the project (Telescope) |
| `grn` / `<Space>rn` | n | Rename symbol |
| `gra` | n, v | Code action (built in); `<Space>ca` — with diff preview |
| `gD` | n | Go to declaration |
| `gK` | n | Signature help |
| `<C-k>` / `<C-s>` | i | Signature help |
| `<Space>ih` | n | Toggle inlay hints |

Reference navigation — highlights every occurrence of the word under the cursor
(`snacks.words`):

| Key | Mode | Action |
| --- | --- | --- |
| `]]` / `[[` | n | Next / previous occurrence of the word under the cursor |
| `<a-n>` / `<a-p>` | n | Next / previous occurrence (wraps around) |

## Diagnostics

| Key | Mode | Action |
| --- | --- | --- |
| `]d` / `[d` | n | Next / previous diagnostic (built in) |
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

## Habit coach

Watches what you type and, when it spots an inefficient habit (`jjjjjj`,
`xxxx`, arrows, `dd dd dd`, backspacing words…), pops a short tip written in a
neutral, documentation-like style. With [Ollama](https://ollama.com) running locally a small model
(`qwen2.5:1.5b`) phrases the tip for the situation; without it the built-in
tip is shown. At most one tip per 90 s; toggle with `<Space>uc` / `:Coach`.

```
sudo pacman -S ollama && sudo systemctl enable --now ollama
ollama pull qwen2.5:1.5b
```

## Terminal

| Key | Mode | Action |
| --- | --- | --- |
| `<C-\>` | n, t | Toggle the bottom-anchored floating terminal (confined to the editor area) |

## Debugging (DAP)

Adapter selection is automatic: Python files use `debugpy`, JavaScript /
TypeScript files use the `node2` adapter. Both are installed by Mason
(`mason-nvim-dap`) the first time you open the debugger. Set the breakpoint
before choosing *Run / Continue*.

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>db` | n | Toggle breakpoint |
| `<Space>dc` | n | Run / continue the session |
| `<Space>di` | n | Step into |
| `<Space>do` | n | Step out |
| `<Space>dO` | n | Step over |
| `<Space>dp` | n | Pause the running session |
| `<Space>dr` | n | Toggle the REPL |
| `<Space>dt` | n | Terminate the session |
| `<Space>du` | n | Toggle the debug sidebar (scopes, stacks, watches, breakpoints) |
| `<Space>de` | n, v | Evaluate the expression under the cursor (add it to the watches) |

The sidebar opens automatically when a session starts and closes when it ends.

## Testing (Neotest)

Tests run in a background terminal; results are streamed inline as virtual text.

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>tr` | n | Run the nearest test |
| `<Space>tf` | n | Run every test in the current file |
| `<Space>td` | n | Debug the nearest test (starts DAP instead of running it) |
| `<Space>ts` | n | Toggle the test summary tree |
| `<Space>to` | n | Open the output of the test under the cursor |

Adapters: `neotest-python` (pytest) and `neotest-vitest`. The results list opens
in Trouble when available, otherwise in the quickfix list.

## AI — Opencode (deep integration)

`opencode.nvim` injects the editor context into your agent prompts. It
communicates with the OpenCode server, so **`opencode` must be installed and in
`$PATH`**. Without it the mappings notify an error instead of failing loudly.

Contexts you can reference: `@this` (range or cursor), `@buffer`, `@buffers`,
`@diagnostics`, `@marks`, `@quickfix`, `@visible`.

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>oa` | n, v | Ask OpenCode about the current range / cursor (`@this`) |
| `<Space>oo` | n, v | Select from the built-in prompt menu |
| `<Space>os` | n, v (operator) | Send a motion / selection to OpenCode — e.g. `g+osa` |
| `<Space>ol` | n (operator) | Send the current line to OpenCode |
| `<Space>ob` | n | Ask OpenCode about the whole buffer (`@buffer`) |
| `<Space>od` | n | Ask OpenCode about the diagnostics |
| `<Space>ot` | n, t | Toggle the OpenCode terminal (snacks float) |

## AI — Sidekick (terminal hub)

Sidekick wraps any AI CLI in a terminal. It is configured for **`opencode`**
and needs the binary in `$PATH`; run selection only works while a CLI session
is open (`<Space>as` first).

| Key | Mode | Action |
| --- | --- | --- |
| `<C-.>` | n, i, t, v | Focus / toggle the CLI window |
| `<Space>aa` | n | Toggle the CLI window |
| `<Space>as` | n | Select which CLI tool to open (opencode, claude, …) |
| `<Space>ao` | n | Open OpenCode directly in a focused CLI window |
| `<Space>at` | n, v | Send the current range to the CLI |
| `<Space>av` | v | Send the selection to the CLI |
| `<Space>af` | n | Send the current file to the CLI |
| `<Space>ap` | n, v | Pick one of Sidekick's built-in prompts |

> Both AI plugins control OpenCode. `opencode.nvim` (`<Space>o…`) is the
> editor-integrated one (context, diff review, event hooks); Sidekick
> (`<Space>a…`) is the plain terminal one. Keep whichever you prefer — disabling
> the other only removes its keys.

## Git Diff (Diffview)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>gv` | n | Open diff view of the whole working tree |
| `<Space>gh` | n | Open diff view of the current file history |

## Search & Replace (Grug-far)

`<Space>fg` (Telescope) is read-only search; grug-far is the interactive
replace front-end over ripgrep.

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
