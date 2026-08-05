# Changelog

All notable changes to this configuration are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-08-06

### Added

- TypeScript / React tooling: `ts_ls`, `cssls`, `html` LSP servers, `tsx` / `css` / `html` treesitter parsers and `prettierd` formatting for JS/TS/JSX/CSS/HTML.
- JSX-aware comments (`{/* */}`) via Comment.nvim and nvim-ts-context-commentstring.
- Combined diagnostics + LSP hover window opened on `K` and `CursorHold`.
- Central per-language config in `lua/config/languages.lua` with an `enabled` toggle per language.
- Semantic versioning: `:ConfigVersion` command, `CHANGELOG.md` and `scripts/bump.sh`.
