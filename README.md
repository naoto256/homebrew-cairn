# homebrew-cairn

Homebrew tap for [`cairn`](https://github.com/naoto256/cairn) — a local,
symbol-aware code index. Daemon-backed structural code search across
registered repos with no external service.

## Install

```sh
brew tap naoto256/cairn
brew install cairn
brew services start cairn
```

Then register a repo:

```sh
cairn ctl register-repo --alias <name> /path/to/repo
```

## Layout

- `Formula/cairn.rb` — the formula. The `sha256` values point at the
  matching binary archives published in the upstream
  [GitHub Releases](https://github.com/naoto256/cairn/releases).
- After each upstream release, the formula's `version` and `sha256` lines
  need to be updated. See the upstream repo's `dist/brew/README.md` for
  the bump procedure.

## License

The formula itself is under MIT/Apache-2.0 dual license matching cairn
upstream.
