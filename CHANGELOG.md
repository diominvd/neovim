# Changelog

All notable changes to this configuration are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.8.0] - 2026-10-14

### Fixed

- **LSP never started.** Mason is lazy-loaded and adds `mason/bin` to `PATH`
  only on first use, so `lua_ls`, `pyright`, `ruff`, `ts_ls`… were "not
  executable" and no server attached. `options.lua` now puts `mason/bin` on
  `PATH` at startup.
- **Leader key clashes.** `<leader>d` (black-hole delete) shadowed the Debug
  group and `<leader>t` (terminal) the Test group, so both waited for
  `timeoutlen`. Black-hole delete is `<leader>D`, the terminal `<C-\>` (also
  from inside it).
- **nvim-lint errors on save:** `fixjson` is not a linter and eslint was not
  installed (and does not lint CSS/HTML). Only installed linters run now
  (ruff; eslint_d / eslint for JS/TS when present).
- `sessionoptions` gains `localoptions` (auto-session health warning);
  `foldlevelstart` is set globally (it was a no-op as a local option); lazy's
  luarocks support is off; the `regex` parser is installed for noice.

### Changed

- **LSP keys follow Neovim's defaults** (`grr`, `gri`, `grt`, `gO`, `grn`,
  `gra`); list results open in Telescope. `gr`, `gy`, `gI` are gone, `gd`
  uses Telescope, `<leader>fS` searches project symbols.
- `]d` / `[d` are the built-in ones; `]e` / `[e` use `vim.diagnostic.jump`.
- No automatic hover popup on CursorHold — tiny-inline-diagnostic already
  shows diagnostics; `K` still opens the combined window.
- hardtime suggests better motions instead of blocking keys.
- `vim.hl.on_yank` replaces the deprecated `vim.highlight.on_yank`.

## [0.7.6] - 2026-10-11

## [0.7.5] - 2026-10-11

### Fixed

- **All `lua/plugins/*.lua` specs added in v0.7.4 were inert.** They were written
  as bare tables without the leading `return`, so `lazy.nvim` never discovered
  them — the 12 new plugins were silently absent (the config reported 39 plugins
  instead of 52). Every spec now returns its table.
- **`opencode.nvim` never loaded.** It registers no Neovim commands and the spec
  called a non-existent `require("opencode").setup()`, so `config` errored with
  `attempt to call field 'setup' (a nil value)`. Replaced with the real
  `vim.g.opencode_opts` table and the public API (`ask`, `select`, `operator`,
  `prompt`), which also brings the `@this` / `@buffer` / `@diagnostics` contexts
  that were previously advertised but unavailable.
- **`sidekick.nvim` keys pointed at commands that do not exist**
  (`SidekickOpen`, `SidekickClose`, `SidekickCli`, `SidekickNew`) — they only
  errored `E492`. Rebound to the plugin's Lua API, and moved off `<leader>s…`,
  which collided with the `<leader>s` (Split) group.
- **`neotest` keys called a non-existent command.** `NeotestRun` does not exist;
  the plugin exposes `:Neotest <subcommand>` (`run nearest`, `summary`, …).
- **`nvim-dap-ui` refused to start** with `size: expected number, got nil` — the
  table used `width`/`height` per layout instead of the required `size`.
- **Duplicate DAP keymap.** `<leader>dso` was defined twice (step over *and*
  step out), so one of them silently won. Stepping is now `d` + `i`/`o`/`O`.
- **`<leader>d` group collided with Diffview.** `<leader>do` was Diffview's
  "open", and DAP needed the same keys for stepping. Diffview moved to
  `<leader>gv` / `<leader>gh`.
- **Duplicate lint autocmd.** `lua/config/options.lua` registered the same
  `BufWritePost` → `lint.try_lint()` handler that already lives in
  `lua/plugins/lint.lua`, linting twice per save. The one in `options.lua` is
  gone.
- **Snacks `dashboard` config was invalid** (a `preset` made of a made-up
  `header`/`buttons` shape) and would have replaced the deliberate
  neo-tree-at-startup behaviour. Removed; the other new modules were given
  their real option names (`bigfile` accepts `size`/`line_length`, not a nested
  `opts` table).
- Removed a `grug-far` `cond` guard that hid the plugin when `rg` was missing —
  grug-far already reports that itself, and the guard made the command vanish
  without explanation.

### Added

- New which-key groups: `<leader>a` (Assist / Sidekick), `<leader>d` (Debug),
  `<leader>o` (Opencode).
- Snacks: `statuscolumn`, `gitbrowse`, `zen`, `bufdelete` and `rename` with
  keys (`<leader>gz`, `<leader>gr`, `<leader>bd`).
- **Vertical bars instead of `»` for tab stops.** `listchars.tab` is now
  `│ ` so nesting is visible as columns. Indentation guides (`snacks.indent`)
  are gray (`#665c54`) while the scope the cursor is in is brighter
  (`#928374`); the `Whitespace` group uses the same gray for the tab markers.
  Colors live in `appearance/palette.lua` (`guide` / `guide_active`).
- `KEYBINDINGS.md` documents all the above, including the contexts accepted by
  OpenCode and the fact that both AI plugins use the `opencode` binary.

## [0.7.4] - 2026-10-11

### Added

- **DAP (debugging)**: `nvim-dap` + `nvim-dap-ui` + `nvim-dap-virtual-text` with Python (`debugpy`) and Node.js (`node2`) adapters, installed by `mason-nvim-dap`.
- **Testing**: `neotest` with pytest (`neotest-python`) and Vitest (`neotest-vitest`) adapters.
- **AI integration**: `opencode.nvim` (context injection, diff review, event hooks) and `sidekick.nvim` (any AI CLI in a terminal).
- **Linting**: `nvim-lint` — ESLint for JS/TS/React/CSS/HTML, Ruff for Python, fixjson for JSON.
- **Git diff**: `diffview.nvim` for side-by-side diffs and file history.
- **Project-wide search/replace**: `grug-far.nvim`.
- **IDE polish**: `mini.icons`, `guess-indent.nvim`, `fidget.nvim`, `tiny-inline-diagnostic.nvim`, `nvim-lsp-file-operations`.
- **snacks.nvim** expanded with `statuscolumn`, `gitbrowse`, `zen`, `bufdelete`, `rename` and `bigfile`.
- **Core options**: `confirm = true`, `splitkeep = "screen"`.

### Changed

- LSP capabilities now include `didChangeWatchedFiles` for file-operation notifications.

### Fixed

- Disabled built-in `virtual_text` diagnostics in favor of `tiny-inline-diagnostic`.

> ⚠️ This release was shipped with 12 inert plugin specs (see `[Unreleased]`
> above) — none of the plugins above actually loaded until the fix below.

## [0.7.3] - 2026-10-11

### Fixed

- `K` (hover) is now a global mapping instead of a buffer-local one set on
  `LspAttach`. In a buffer without an attached LSP client the built-in `K` fell
  through to `keywordprg` (`:Man`) and errored with
  `man.lua: executable not found: "man"` when the `man` binary is not installed.

## [0.7.2] - 2026-10-11

### Added

- IDE-grade hints and completion:
  - `lazydev.nvim` — smart completions for the Neovim API while editing this
    config's Lua files (registered as a `blink` source for the `lua` filetype).
  - `actions-preview.nvim` — `<leader>ca` previews code actions (diff before /
    after) in a Telescope picker before applying; also available in visual mode.
  - Word-reference highlighting and navigation via `snacks.words`:
    `]]` / `[[` / `<a-n>` / `<a-p>`.
  - File outline — `<leader>cs` opens Trouble symbols.
- `blink.cmp`: command-line completion (`:`) and `<C-y>` (accept) /
  `<C-n>` / `<C-p>` (next / previous candidate).

### Changed

- `blink.cmp`: auto-shown documentation (200 ms), signature-help popup while
  typing a call, ghost text, treesitter-highlighted menu labels, and explicit
  auto-brackets on accept.
- LSP: `gK` opens signature help in normal mode (in addition to `<C-k>` in
  insert mode).

### Fixed

- `mason.nvim`: `:Mason` again works directly — the plugin was lazy-loaded
  only via `<leader>M` keymaps, so the command did not exist until one of them
  was pressed. Added `cmd = { "Mason", ... }` to keep the plugin lazy while
  restoring the commands.
- `mason-tool-installer`: `<leader>Mi` (`:MasonInstallAll`) pointed to a
  command renamed upstream to `:MasonToolsInstall`; the keybind now uses the
  current name (`:MasonInstallAll` produced `E492`).

## [0.7.1] - 2026-09-22

### Changed

- `blink.cmp` v2: added the required
  `build = require("blink.cmp").build():pwait()` step and the `blink.lib`
  dependency (the native fuzzy matcher is built from source); `<C-/>` mirrors
  `<C-space>` for terminals that swallow it.
- `mason.nvim`: new `<leader>M` group — `<leader>Mi` (`:MasonToolsInstall`) and
  `<leader>Mo` (`:Mason`). LSP servers and formatters are now installed
  explicitly with `:MasonToolsInstall` after adding a language (treesitter
  parsers still auto-install on startup; `run_on_start = false` stays for
  fast startups).
- `---` inserts an em-dash only in prose filetypes (`text`, `tex`, `rst`),
  keeping `---` available for horizontal rules in markdown.
- `conform`: format timeout raised 500 → 1500 ms (prettierd/ruff on big files).

### Fixed

- Opening `nvim <dir>` with an existing auto-session no longer deletes the
  restored active buffer: the directory placeholder is only swapped when the
  current buffer really is a directory.
- `lazy-lock.json` removed from `.gitignore` (it stays tracked as the pinfile).

## [0.7.0] - 2026-08-25

### Fixed

- `colorcolumn` no longer creates a visible block on the cursor line: removed
  the conflicting `opt.colorcolumn = "80"` which clashes with transparent
  gruvbox-material + `CursorLine`.
- `conform.nvim`: replaced deprecated `lsp_fallback = true` with
  `lsp_format = "fallback"`.
- Treesitter fold autocmd now uses `pcall(vim.treesitter.get_parser)` instead
  of `vim.treesitter.language.add`, which only checked already-loaded parsers.
  Folds now work on first open of a filetype after cold start.
- Bufferline and Telescope keymaps use `require()` closures instead of
  `:Command<CR>` strings, preventing `E492: Not an editor command` when
  the plugin hasn't loaded yet.
- `lazy.nvim` bootstrap now checks `vim.v.shell_error` after `git clone` and
  shows an error message on failure instead of silently breaking.

### Changed

- neo-tree: removed `branch = "v3.x"` (now the default), removed
  `event_handlers` for `number`/`relativenumber` (already set globally).
- `nvim-treesitter-textobjects`: removed redundant default options
  (`lookahead`, `set_jumps`).
- `nvim-autopairs`: removed empty `ts_config` (already the default).
- `nvim-lspconfig`: simplified capabilities — `blink.cmp.get_lsp_capabilities()`
  already includes base capabilities, no need for double-wrapping.
- `blink.cmp`, `mini.surround`, `bufferline`: removed `version = "*"` (lockfile
  handles pinning; avoids unnecessary tag checks on startup).
- `flash.nvim`: lazy-loaded via `keys` spec (`s`/`S`), only loads on first use.
- `mason-tool-installer`: `run_on_start = false` to avoid spawning processes
  on every boot.
- `fillchars` uses modern table syntax: `{ eob = " " }`.
- `keymaps.lua`: re-indented from tabs to 2-space (consistent with the rest of
  the config).
- Plugin configs simplified: `autopairs`, `noice`, `lualine`, `render-markdown`
  converted from `config = function() require().setup() end` to `opts = {}`.
- All `:Command<CR>` keymap strings converted to Lua function closures for
  consistency and lazy-safety.

## [0.6.0] - 2026-08-23

### Added

- Visible current-line highlight: `cursorline` was already enabled, but the
  transparent gruvbox-material background made it invisible; it is now pinned
  to a palette color so the active row stands out.
- Neo-tree collapses to its root when the last named buffer closes — every
  expanded folder folds back instead of leaving deep nesting behind. Empty
  (`[No Name]`) and special buffers don't count as open files.
- Manual collapse: `<Space>E` folds the explorer tree back to its root from
  anywhere; `W` does the same inside the neo-tree window. The logic lives in
  `lua/utils/neotree.lua`, shared by the keymaps and the autocmd.

### Fixed

- Neo-tree no longer folds expanded folders when switching to a buffer whose
  file sits higher in the tree (`follow_current_file.leave_dirs_open = true`):
  going deeper still expands, going back up keeps what is open.

### Changed

- Internal cleanups with no behavior change: diagnostic highlights are
  generated from a severity table, treesitter motion maps are data-driven,
  redundant empty `lsp` / `formatter` fields dropped from `languages.lua`,
  and an unused `statuscolumn` module was never imported and is gone.

## [0.5.1] - 2026-08-13

### Added

- Opening a directory (or `nvim` with no arguments) starts with neo-tree focused
  and a pristine, unnamed buffer (`[No Name]`) on the right; the buffer named
  after the directory is removed. Focus stays in the file explorer.

### Changed

- blink.cmp is a direct dependency of the LSP setup, so its capabilities are
  always wired in (the silent `require` fallback is gone).
- Trailing-whitespace strip on save skips special buffers (terminal, quickfix,
  …) in addition to prose and binary ones.
- nvim-treesitter parser auto-install rewritten through the public module API.
- Startup is quieter: noice loads eagerly (it catches startup notifications)
  and `shortmess` includes `I` (no "Press ENTER" prompt).
- Remaining non-English comments were translated; gitsigns uses `require`
  instead of `package.loaded`; the lazy.nvim bootstrap uses `vim.uv`.
- Which-key popup anchoring refactored (internally) — behavior is unchanged.

### Fixed

- `<leader>ft` (find TODOs / FIXMEs) raised `attempt to call a nil value`: it
  called `telescope.builtin.todo_comments`, which does not exist. It now runs
  the `TodoTelescope` command through a lazy `keys` trigger, keeping Telescope
  cold until first use.

## [0.5.0] - 2026-08-12

### Added

- hardtime.nvim — training plugin that blocks the arrow keys (normal, insert,
  visual, terminal) and the mouse, and hints better motions (`3j`, `D`, `A`, …)
  when lazy habits are detected. Toggle with `:Hardtime toggle`, review habits
  with `:Hardtime report`.
- better-escape.nvim — `jk` / `kj` exit insert mode with **no typing latency**:
  the first key is inserted immediately, only the second has to arrive within
  ~150 ms. Replaces the old `jk` / `kj` insert mappings, which delayed every
  `j` / `k` by `timeoutlen`.

### Changed

- Terminal (`<Space>t`): the float is anchored to the bottom and confined to the
  editor area (no longer overlaps neo-tree); square `single` border.
- LazyGit (`<Space>gg`): opens in a fullscreen float instead of the small terminal window.
- Session search (`<Space>fs`) runs `:AutoSession search` — `:SessionSearch` no
  longer exists in the current auto-session.
- Telescope is lazy-loaded (`:Telescope` command) and the auto-session picker
  registers it on demand (`load_on_setup = false`), so it stays out of startup.
- auto-session uses the current `picker_opts` API (`theme_conf` was deprecated).
- `<Space>hk` resolves `KEYBINDINGS.md` via `stdpath("config")` instead of
  walking the debug source path.

### Removed

- Visual-mode `jk` / `kj` mappings — they delayed every `j` / `k` movement by
  `timeoutlen`; use `<Esc>` to leave visual mode.
- Dead auto-session options: `theme_conf` and `previewer = false` (the
  session-lens picker always renders its own preview).
- `result_width = 0.8` in telescope layout — not a valid telescope option.
- Global `linebreak` / `breakindent` — wrapping stays window-local for prose
  filetypes only.

### Fixed

- `<Space>fs` raised `E492: Not an editor command: SessionSearch` on the current
  auto-session; the session picker works again.
- Which-key popup is anchored to the left edge of the current editor window
  (and capped to its width) on every show, so it no longer overlaps the
  neo-tree column.


## [0.4.0] - 2026-08-10

### Added

- Terminal: snacks `terminal` module with `<leader>t` (floating terminal toggle).
- `<leader>gg` — lazygit (guarded: notifies if `lazygit` is missing; activates once installed).
- `<leader>hh` — clear search highlight (native `<C-l>` is taken by window navigation).
- Treesitter-based folding (`foldmethod=expr`) for every buffer with a parser.
- Yank highlight via `vim.highlight.on_yank`.
- `telescope-ui-select` — Telescope now themes `vim.ui.select` (trouble, blink, etc.).
- Extra which-key groups: `c` Code, `h` Help, `i` Inlay, `m` Markdown, `q` Quit/Session,
  `r` Refactor, `t` Terminal, `u` Undo/Format.
- Diagnostics float windows use a `single` border to match the rest of the UI.

### Changed

- Gitsigns is lazy-loaded on `BufReadPre` / `BufNewFile` instead of startup.
- Class navigation moved from `]]` / `[[` to `]k` / `[k` to restore the native
  section motions in C-like files.
- Blink.cmp drops the deprecated `use_nvim_cmp_as_default` option (the theme already
  defines the BlinkCmp highlight groups directly).

## [0.3.0] - 2026-08-09

### Added

- Smart search: `ignorecase` + `smartcase` (case-insensitive unless the query has capitals) and live `:s` preview via `inccommand`.
- Visible trailing whitespace and tabs (`list` + `listchars`) — complements the on-save cleanup.
- `showmode` disabled — the mode is already shown by lualine.
- Format-on-save toggle `<leader>uF` (guarded by the existing `disable_autoformat` flag).
- `<leader>hk` opens the keybinding reference (`KEYBINDINGS.md`).
- LSP navigation: `gD` (declaration), `gy` (type definition), `gI` (implementation) and per-buffer inlay-hint toggle `<leader>ih`.
- Gitsigns `<leader>gd` — diff the current file against HEAD (`diffthis`).
- mini.surround — surround editing with the `gs*` prefix (`gsa` / `gsd` / `gsr` / `gsf` / `gsF` / `gsh`); `s`-prefix avoided because it conflicts with flash.
- undotree — visual history of changes via `<leader>uu`.
- Snacks (`folke/snacks.nvim`) with only the `indent` (indent guides) and `scroll`
  (scrollbar) modules enabled; the rest of snacks stays off.
- Telescope `file_ignore_patterns` for build artifacts (`node_modules`, `dist`, `target`, `build`, `__pycache__`, `.venv`, `.next`, etc.).

### Changed

- Bufferline loads on `UIEnter` and neo-tree on the `Neotree` command instead of at startup — faster startup.
- `<leader>y` in visual mode yanks the selection, not the whole line.
- Which-key popup is now a compact box: no `<esc>`/`<bs>` hints, per-row icons or section-title frame, less padding.
- `.luarc.json` points `workspace.library` at the config and lazy install dirs (no more spurious lint on `require("lazy")` and friends).

### Removed

- Redundant neo-tree `neo_tree_buffer_enter` handler (relative numbers are already global).

### Fixed

- Telescope results no longer shift horizontally when navigating: `entry_prefix`
  now matches the 1-column `selection_caret`, so selected and unselected rows
  share the same text column.
- Which-key popup opens at the left edge of the current window instead of the
  whole editor, so it no longer overlaps the neo-tree file explorer.

## [0.2.0] - 2026-08-07

### Added

- Which-key enabled with leader groups (`Find`, `Git`, `Split`, `Diagnostics`).
- Diagnostic navigation: `]d` / `[d`, `]e` / `[e`.
- Telescope git pickers: `<leader>gc` (commits), `<leader>gs` (status), `<leader>gl` (branches).
- Session search via `<leader>fs` (`:SessionSearch`).
- Treesitter textobjects for loops (`al` / `il`) and conditionals (`ai` / `ii`).
- Missing treesitter parsers: `vim`, `vimdoc`, `markdown`, `markdown_inline`, `comment`, `diff`, `json`.
- Central color palette in `lua/config/palette.lua` used by `theme.lua` and `bufferline.lua`.
- Trailing-whitespace cleanup on save (skips prose filetypes and binary files).
- Line wrapping restricted to prose filetypes (markdown, text, tex, rst) instead of global.
- Debounce guard for the `CursorHold` hover window (no repeated LSP requests while visible).
- Full keybinding reference in `KEYBINDINGS.md`; README now links to it.
- The `CursorHold` diagnostics/hover window auto-opens only when the cursor is on
  an error or warning line; `K` still opens it forcibly anywhere.

### Fixed

- `treesitter.lua` rewritten for the current nvim-treesitter rewrite: `ensure_installed`,
  `highlight` and the in-core `textobjects` option no longer exist in the installed
  version, so textobject keymaps were silently inert. Keymaps are now registered
  directly against `nvim-treesitter-textobjects`, and missing parsers are installed
  from `languages.lua` on startup.
- Replaced deprecated `vim.tbl_islist` with `vim.islist` in `languages.lua`.
- Hover window no longer raises errors on every `CursorHold`: `open_floating_preview`
  returns `(bufnr, winid)` (not `(winid, bufnr)`) on this nvim version, which made
  the header extmark target the window id and the debounce guard check a buffer id
  as if it were a window.
- Prose wrapping autocmd sets `wrap` / `linebreak` / `breakindent` as window-local
  options on the buffer's windows (`vim.wo`) instead of `vim.bo`, which raised
  `'buf' cannot be passed for window-local option 'wrap'` on nvim 0.12.

### Changed

- `Save all and exit` moved from `<leader>wq` to `<leader>W` to remove the 300ms
  timeout conflict with `<leader>w` (save).
- Removed `hijack_netrw_behavior` from neo-tree (netrw is disabled).
- Color palette moved from `lua/config/palette.lua` to `lua/appearance/palette.lua`;
  the lazy.nvim import is now scoped to `appearance.theme` so the palette module
  is not scanned as a plugin spec.

## [0.1.0] - 2026-08-06

### Added

- TypeScript / React tooling: `ts_ls`, `cssls`, `html` LSP servers, `tsx` / `css` / `html` treesitter parsers and `prettierd` formatting for JS/TS/JSX/CSS/HTML.
- JSX-aware comments (`{/* */}`) via Comment.nvim and nvim-ts-context-commentstring.
- Combined diagnostics + LSP hover window opened on `K` and `CursorHold`.
- Central per-language config in `lua/config/languages.lua` with an `enabled` toggle per language.
- Semantic versioning: `:ConfigVersion` command, `CHANGELOG.md` and `scripts/bump.sh`.
