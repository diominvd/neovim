# Changelog

All notable changes to this configuration are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
