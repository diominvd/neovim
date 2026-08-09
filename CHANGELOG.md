# Changelog

All notable changes to this configuration are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
